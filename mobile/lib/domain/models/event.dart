class Event {
  final int id;
  final String name;
  final String shortDescription;
  final String description;
  final String city;
  final String address;
  final DateTime startDate;
  final DateTime endDate;
  final String photoUrl;
  final String category;

  Event({
    required this.id,
    required this.name,
    required this.shortDescription,
    required this.description,
    required this.city,
    required this.address,
    required this.startDate,
    required this.endDate,
    required this.photoUrl,
    required this.category,
  });
}
