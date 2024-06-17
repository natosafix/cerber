import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/models/download_status.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/event_detail/event_description_widget.dart';
import 'package:project/presentation/event_detail/event_detail_location.dart';
import 'package:project/presentation/event_detail/event_detail_sliver_app_bar.dart';
import 'package:project/presentation/event_detail/event_detail_bloc/event_detail_bloc.dart';
import 'package:project/presentation/qr_code_scanner/qr_code_scanner_screen.dart';
import 'package:project/presentation/widgets/full_width_button.dart';
import 'package:project/utils/extensions/context_x.dart';

class EventDetailScreen extends StatelessWidget {
  const EventDetailScreen(this.event, {super.key});

  final Event event;

  static Route route(Event event) {
    return MaterialPageRoute(builder: (context) => EventDetailScreen(event));
  }

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => EventDetailBloc(event),
      child: SafeArea(
        child: Scaffold(
          body: CustomScrollView(
            physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
            slivers: [
              EventDetailSliverAppBar(event: event),
              SliverPadding(
                padding: const EdgeInsets.all(15),
                sliver: SliverList(
                  delegate: SliverChildListDelegate.fixed([
                    EventDetailLocation(event: event),
                    const SizedBox(height: 8),
                    Text.rich(
                      style: Theme.of(context).textTheme.titleLarge,
                      TextSpan(
                        children: [
                          TextSpan(text: "${L10n.current.when}: "),
                          TextSpan(
                            text: L10n.current.formattedDateTime(event.startDate, event.startDate),
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
                    const SizedBox(height: 12),
                    EventDescriptionWidget(text: event.description),
                    const SizedBox(height: 18),
                    BlocBuilder<EventDetailBloc, EventDetailState>(
                      buildWhen: (previous, current) =>
                          previous.lastDownloaded != current.lastDownloaded,
                      builder: (context, state) {
                        final date = state.lastDownloaded;
                        if (date == null) {
                          return Text("⚠ ${L10n.current.notDownloaded}");
                        }
                        final formattedDate = L10n.current.formattedDateTime(date, date);
                        return Text("${L10n.current.lastDownloaded} $formattedDate");
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocBuilder<EventDetailBloc, EventDetailState>(
                      buildWhen: (previous, current) {
                        return previous.generatedVisitorsCount != current.generatedVisitorsCount;
                      },
                      builder: (context, state) {
                        if (state.generatedVisitorsCount == 0) {
                          return const SizedBox.shrink();
                        }
                        return Padding(
                          padding: const EdgeInsets.only(bottom: 8),
                          child: Row(
                            children: [
                              Text(L10n.current.unsyncedVisitors(state.generatedVisitorsCount)),
                              TextButton(
                                onPressed: () {
                                  context.read<EventDetailBloc>().add(SyncGeneratedVisitors());
                                },
                                child: Text(L10n.current.sync),
                              ),
                            ],
                          ),
                        );
                      },
                    ),
                    BlocConsumer<EventDetailBloc, EventDetailState>(
                      listenWhen: (previous, current) =>
                          current.downloadStatus == DownloadStatus.failure,
                      listener: (context, state) =>
                          context.showSnackbar(L10n.current.somethingWentWrong),
                      buildWhen: (previous, current) =>
                          previous.isDownloading != current.isDownloading,
                      builder: (context, state) {
                        final isDownloading = state.isDownloading;
                        return Column(
                          children: [
                            FullWidthButton.withLoading(
                              isEnabled: !isDownloading,
                              showLoadingIndicator: isDownloading,
                              onPressed: () =>
                                  context.read<EventDetailBloc>().add(DownloadDatabase()),
                              child: Text(L10n.current.downloadDatabase),
                            ),
                            const SizedBox(width: 10),
                            FullWidthButton(
                              isEnabled: !isDownloading,
                              onPressed: () => _startCheckingPressed(context),
                              child: Text(L10n.current.beginChecking),
                            ),
                          ],
                        );
                      },
                    ),
                  ]),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  void _startCheckingPressed(BuildContext context) {
    Navigator.of(context).push(QrCodeScannerScreen.route(event));
  }
}
