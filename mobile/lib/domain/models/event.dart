import 'dart:typed_data';

class Event {
  final String id;
  final String name;
  final String location;
  final String description;
  final DateTime startDate;
  final Uint8List? photoBlob;

  Event({
    required this.id,
    required this.name,
    required this.location,
    required this.description,
    required this.startDate,
    this.photoBlob,
  });

  static List<Event> mock = [
    Event(id: "4", name: "QEw", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'Ekb'),
    Event(id: "5", name: "Gfd", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'MOscow'),
    Event(
        id: "6",
        name: "Конференция управления разработки 2023",
        description:
            """В новой книге «Поход на Бар-Хото» автор обращается к своей излюбленной восточной тематике; это вымышленная история с вымышленными героями — но в реальных декорациях.
В воспоминаниях""",
        startDate: DateTime.now().add(const Duration(days: 2)), location: 'Екатеринбург ЭКСПО'),
    Event(id: "7", name: "GVS", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'LOnodn'),
    Event(id: "0", name: "POL", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'New york'),
    Event(id: "9", name: "}{KJ}", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'Чапаева 16а'),
    Event(
        id: "12",
        name: "BBNKIJHN",
        description: "description1",
        startDate: DateTime.now().add(const Duration(days: 2)), location: 'Kanos'),
    Event(id: "11", name: "name1", description: "description1", startDate: DateTime.now().add(const Duration(days: 2)), location: 'Qwesd'),
    Event(
        id: "2",
        name: "Ивент2",
        description: "description1 lorem ipsum kofs jiosdf sdff sd",
        startDate: DateTime.now().add(const Duration(days: 2, hours: 2)), location: 'Polkjh'),
  ];
}
