import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:infinite_scroll_pagination/infinite_scroll_pagination.dart';
import 'package:project/domain/repositories/events_repository/events_repository.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/visitors_list/visitors_bloc/visitors_bloc.dart';

import '../../domain/models/event.dart';
import '../../domain/models/visitor.dart';
import '../../utils/theme_util.dart';
import 'qr_code_scanner_screen.dart';

class VisitorsListScreen extends StatelessWidget {
  const VisitorsListScreen(this.event, {super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => VisitorsListScreen(event));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => VisitorsBloc(context.read<EventsRepository>(), event.id),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          foregroundColor: ThemeUtil.isLight(context) ? Colors.black : Colors.white,
          elevation: 0,
          title: Text(L10n.current.visitors),
          actions: [
            TextButton.icon(onPressed: () {}, icon: const Icon(Icons.add), label: Text(L10n.current.add)),
          ],
        ),
        body: BlocBuilder<VisitorsBloc, VisitorsState>(
          builder: (context, state) {
            return PagedListView<int, Visitor>(
              pagingController: state.pagingController,
              builderDelegate: PagedChildBuilderDelegate<Visitor>(
                itemBuilder: (context, item, index) {
                  return ListTile(
                    title: Text(item.name),
                  );
                },
                noItemsFoundIndicatorBuilder: (context) {
                  return Center(
                    child: Text(L10n.current.eventHasNoVisitors),
                  );
                },
              ),
            );
          },
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: () => _scanQrCodePressed(context),
          tooltip: L10n.current.scanVisitorsQrCode,
          child: const Icon(Icons.qr_code_2),
        ),
      ),
    );
  }

  void _scanQrCodePressed(BuildContext context) {
    Navigator.of(context).push(QrCodeScannerScreen.route());
  }
}
