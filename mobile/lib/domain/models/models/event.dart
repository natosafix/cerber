import 'dart:typed_data';

class Event {
  final String id;
  final String name;
  final String description;
  final DateTime startDate;
  final Uint8List? photoBlob;

  Event({
    required this.id,
    required this.name,
    required this.description,
    required this.startDate,
     this.photoBlob,
  });

  static List<Event> mock = [
    Event(id: "4", name: "QEw", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "5", name: "Gfd", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "6", name: "QEW", description: "Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "7", name: "GVS", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "0", name: "POL", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "9", name: "}{KJ}", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(
        id: "12", name: "BBNKIJHN", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(id: "11", name: "name1", description: "description1", startDate: DateTime.now().add(const Duration(days: 2))),
    Event(
        id: "2",
        name: "Ивент2",
        description: "description1 lorem ipsum kofs jiosdf sdff sd",
        startDate: DateTime.now().add(const Duration(days: 2, hours: 2))),
  ];
}
