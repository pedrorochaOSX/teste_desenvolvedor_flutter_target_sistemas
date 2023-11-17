class Information {
  Information({
    required this.details,
    required this.dateTime,
  });

  Information.fromJson(Map<String, dynamic> json)
      : details = json['details'],
        dateTime = DateTime.parse(json['datetime']);

  String details;
  DateTime dateTime;

  Map<String, dynamic> toJson() {
    return {
      'details': details,
      'datetime': dateTime.toIso8601String(),
    };
  }
}
