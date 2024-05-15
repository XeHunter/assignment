class EventModel {
  final String title;
  final String description;
  final String imageUrl;
  final String eventDescription;
  final bool isLoading;

  EventModel({
    required this.title,
    required this.description,
    required this.imageUrl,
    required this.eventDescription,
    this.isLoading = false,
  });

  factory EventModel.fromJson(Map<String, dynamic> json) {
    final titleParts = json['title'].split(':');
    final title = titleParts.isNotEmpty ? titleParts[0].trim() : '';
    final description = titleParts.length > 1 ? titleParts[1].trim() : '';

    return EventModel(
      title: title,
      description: description,
      imageUrl: json['image'][0],
      eventDescription: json['eventDescription'],
      isLoading: false,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'title': title,
      'description': description,
      'imageUrl': imageUrl,
      'eventDescription': eventDescription,
    };
  }
}