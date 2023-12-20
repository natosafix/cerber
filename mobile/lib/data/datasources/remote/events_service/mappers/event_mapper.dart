import 'package:project/data/datasources/remote/events_service/responses/event_api_response.dart';
import 'package:project/domain/models/event.dart';
import 'package:project/utils/constants/constants.dart';

extension EventMapper on EventApiResponse {
  Event toModel() {
    return Event(
      id: id,
      name: name,
      shortDescription: shortDescription,
      description: description,
      city: city,
      address: address,
      startDate: from,
      endDate: to,
      photoUrl: "${Constants.eventsRepositoryBaseUrl}/files/${cover.id}/download",
      category: category.name,
      lastDownloaded: null,
    );
  }
}
