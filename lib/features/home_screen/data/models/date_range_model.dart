class DateRange {
  final String minimum;
  final String maximum;

  DateRange({required this.minimum, required this.maximum});

  factory DateRange.fromJson(Map<String, dynamic> json) {
    return DateRange(minimum: json["minimum"], maximum: json["maximum"]);
  }
}