class RecordModel {
  DateTime date;
  RecordType type;
  double value;

  RecordModel({
    required this.date,
    required this.type,
    required this.value
  });
}

enum RecordType {
  goal,
  pr,
}