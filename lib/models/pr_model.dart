import 'package:pr_tracker/models/record_model.dart';

class PrModel {
  String name;
  List<RecordModel> goals;
  List<RecordModel> tries;

  // Contructor
  PrModel({
    required this.name,
    required this.goals,
    required this.tries
  });

  static List<PrModel> getPrs() {
    List<PrModel> results = [];

    List<RecordModel> tractionGoals = [RecordModel(date: DateTime.now(), type: RecordType.goal, value: 10)];
    List<RecordModel> tractionTries = [];
    tractionTries.add(
      RecordModel(date: DateTime.now(), type: RecordType.pr, value: 6)
    );
    tractionTries.add(
      RecordModel(date: DateTime.now(), type: RecordType.pr, value: 7)
    );

    results.add(
      PrModel(name: "Tractions", goals: tractionGoals, tries: tractionTries)
    );results.add(
      PrModel(name: "Push up", goals: tractionGoals, tries: tractionTries)
    );

    return results;
  }
}