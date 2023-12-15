import 'package:project/data/datasources/remote/events_service/responses/event_api_response.dart';
import 'package:project/domain/models/event.dart';

extension EventMapper on EventApiResponse {
  Event toModel() {
    return Event(
      // TODO: id is int
      id: id.toString(),
      name: name,
      shortDescription: shortDescription,
      description: description,
      city: city,
      address: address,
      startDate: from,
      endDate: to,
      photoUrl: "photoUrl",
      category: category.name,
    );
  }
}
