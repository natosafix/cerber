import 'package:expandable_text/expandable_text.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/domain/repositories/compound_events_repository/download_status.dart';
import 'package:project/l10n/generated/l10n.dart';
import 'package:project/presentation/event_detail/event_detail_sliver_app_bar.dart';
import 'package:project/presentation/event_detail/event_detail_bloc/event_detail_bloc.dart';
import 'package:project/presentation/qr_code_scanner/qr_code_scanner_screen.dart';
import 'package:project/presentation/widgets/circular_progress_indicator_inbutton.dart';
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
      child: Scaffold(
        body: CustomScrollView(
          physics: const BouncingScrollPhysics(parent: AlwaysScrollableScrollPhysics()),
          slivers: [
            EventDetailSliverAppBar(event: event),
            SliverPadding(
              padding: const EdgeInsets.all(15),
              sliver: SliverList(
                delegate: SliverChildListDelegate.fixed(
                  [
                    Text.rich(
                      style: Theme.of(context).textTheme.titleLarge,
                      TextSpan(
                        children: [
                          TextSpan(text: "${L10n.current.where}: "),
                          TextSpan(
                            text: "${event.city}, ${event.address}",
                            style: const TextStyle(fontWeight: FontWeight.bold),
                          ),
                        ],
                      ),
                    ),
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
                    ExpandableText(
                      event.description,
                      expandText: L10n.current.more,
                      collapseText: L10n.current.less,
                      collapseOnTextTap: true,
                      linkEllipsis: false,
                      animation: true,
                      maxLines: 7,
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                    const SizedBox(height: 18),
                    BlocBuilder<EventDetailBloc, EventDetailState>(
                      builder: (context, state) {
                        final date = state.lastDownloaded;
                        if (date == null) {
                          return Text("⚠ ${L10n.current.notDownloaded}");
                        }
                        return Text("${L10n.current.lastDownloaded} ${L10n.current.formattedDateTime(date, date)}");
                      },
                    ),
                    const SizedBox(height: 8),
                    BlocConsumer<EventDetailBloc, EventDetailState>(
                      listenWhen: (previous, current) => current.downloadStatus == DownloadStatus.failure,
                      listener: (context, state) => context.showSnackbar(L10n.current.somethingWentWrong),
                      buildWhen: (previous, current) => previous.isDownloading != current.isDownloading,
                      builder: (context, state) {
                        final isDownloading = state.isDownloading;
                        return Column(
                          children: [
                            FullWidthButton(
                              onPressed:
                                  isDownloading ? null : () => context.read<EventDetailBloc>().add(DownloadDatabase()),
                              child: isDownloading
                                  ? const CircularProgressIndicatorInbutton()
                                  : Text(L10n.current.downloadDatabase),
                            ),
                            const SizedBox(width: 10),
                            FullWidthButton(
                              onPressed: isDownloading ? null : () => _startCheckingPressed(context),
                              child: Text(L10n.current.beginChecking),
                            ),
                          ],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _startCheckingPressed(BuildContext context) {
    Navigator.of(context).push(QrCodeScannerScreen.route(event));
  }
}
