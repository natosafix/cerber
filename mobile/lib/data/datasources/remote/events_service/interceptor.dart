import 'package:dio/dio.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:project/domain/repositories/authentication_repository/authentication_repository.dart';
import 'package:project/utils/locator.dart';
import 'package:project/utils/constants/secure_storage_keys.dart';

class EventsServiceInterceptor extends Interceptor {
  final _secureStorage = locator<FlutterSecureStorage>();

  final _authenticationRepository = locator<AuthenticationRepository>();

  late final _eventsDio = locator<Dio>();

  @override
  void onRequest(RequestOptions options, RequestInterceptorHandler handler) async {
    final token = await _secureStorage.read(key: SecureStorageKeys.authToken);

    // if there are other cookies this will overwrite them...
    options.headers['Cookie'] = 'CerberAuth=$token';

    super.onRequest(options, handler);
  }

  @override
  void onError(DioException err, ErrorInterceptorHandler handler) async {
    final statusCode = err.response?.statusCode;

    if (statusCode == null || statusCode != 401) {
      return super.onError(err, handler);
    }
    // '401 Unauthorized' - token expired

    final isRefreshed = await _authenticationRepository.tryRefreshToken();

    if (isRefreshed) {
      // retrying failed request
      final req = err.requestOptions;
      final response = await _eventsDio.request(
        req.path,
        data: req.data,
        queryParameters: req.queryParameters,
        options: Options(
          method: req.method,
          headers: req.headers,
        ),
      );

      return handler.resolve(response);
    }

    handler.next(err);
  }
}
