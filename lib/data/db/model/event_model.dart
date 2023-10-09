class Event {
  Event(
      {this.id,
      required this.name,
      required this.description,
      required this.secondDate,
      required this.firstDate,
      required this.location,
      required this.day,
      required this.color});
  int? id;
  String name;
  String description;
  String firstDate;
  String secondDate;
  String day;
  String location;
  int color;

  copyWith(
          {int? id,
          String? name,
          String? description,
          String? firstDate,
          String? secondDate,
          String? location,
          String? day,
          int? color}) =>
      Event(
        id: id ?? this.id,
        name: name ?? this.name,
        description: description ?? this.description,
        firstDate: firstDate ?? this.firstDate,
        secondDate: secondDate ?? this.secondDate,
        color: color ?? this.color,
        location: location ?? this.location,
        day: day ?? this.day,
      );

  Map<String, dynamic> toJson() => {
        Fields.id: id,
        Fields.name: name,
        Fields.description: description,
        Fields.firstDate: firstDate,
        Fields.secondDate: secondDate,
        Fields.location: location,
        Fields.color: color,
        Fields.day: day
      };

  factory Event.fromJson(Map<String, dynamic> json) => Event(
        day: json[Fields.day] as String? ?? "",
        id: json[Fields.id] as int?,
        name: json[Fields.name] as String? ?? "",
        description: json[Fields.description] as String? ?? "",
        firstDate: json[Fields.firstDate] as String? ?? "",
        secondDate: json[Fields.secondDate] as String? ?? "",
        location: json[Fields.location] as String? ?? "",
        color: json[Fields.color] as int? ?? 0,
      );
}

class Fields {
  static final List<String> values = [id, name, description, firstDate];
  static const String id = "_id";
  static const String name = "name";
  static const String description = "description";
  static const String firstDate = "first_date";
  static const String secondDate = "second_date";
  static const String location = "location";
  static const String color = "color";
  static const String day = "day";
}
