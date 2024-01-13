import 'package:project/domain/models/visitor.dart';

sealed class QrCodeProcessResult {}

final class VisitorFound extends QrCodeProcessResult {
  final Visitor visitor;

  VisitorFound(this.visitor);
}

final class VisitorNotFound extends QrCodeProcessResult {}

final class VisitorIdValidButNotFound extends QrCodeProcessResult {}
