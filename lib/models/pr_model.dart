import 'package:fl_chart/fl_chart.dart';
import 'package:pr_tracker/models/record_model.dart';

enum GoalType {
  maximize,
  minimize
}
class PrModel {
  String name;
  double goal;
  GoalType goalType;
  List<RecordModel> tries;

  // Contructor
  PrModel({
    required this.name,
    required this.goal,
    required this.tries,
    this.goalType = GoalType.maximize
  });

  double maxY() {
    double maxTries = tries.map((e) => e.value).reduce((value, element) => value > element ? value : element);
    return maxTries > goal ? maxTries : goal;
  }

  double minY() {
    double minTries = tries.map((e) => e.value).reduce((value, element) => value < element ? value : element);
    return minTries < goal ? minTries : goal;
  }

  bool isGoalMet() {
    if (goalType == GoalType.minimize) {
      return tries.last.value <= goal;
    }
    return tries.last.value >= goal;
  }

  List<FlSpot> getTries(int monthsPrecision) {
    List<FlSpot> results = [];
    DateTime baseMonth = DateTime(DateTime.now().year, DateTime.now().month - (monthsPrecision-1));
    double scale = (DateTime.now().millisecondsSinceEpoch - baseMonth.millisecondsSinceEpoch ) / monthsPrecision;
    for (int i = 0; i < tries.length; i++) {
      double index = 0;
      if (tries[i].date.isAfter(baseMonth)) {
        index = (tries[i].date.millisecondsSinceEpoch - baseMonth.millisecondsSinceEpoch) / scale;
      }
      results.add(FlSpot(index, tries[i].value.toDouble()));
    }
    return results;
  }

  static List<PrModel> getPrs() {
    List<PrModel> results = [];

    List<RecordModel> tractionTries = [];
    DateTime today = DateTime.now();
    DateTime yesterday = today.subtract(Duration(days: 35));
    tractionTries.add(
      RecordModel(date: today.subtract(Duration(days: 60)), type: RecordType.pr, value: 5)
    );
    tractionTries.add(
      RecordModel(date: yesterday, type: RecordType.pr, value: 7)
    );
    tractionTries.add(
      RecordModel(date: today, type: RecordType.pr, value: 6)
    );
    results.add(PrModel(name: 'Traction', goal: 10, tries: tractionTries));
    results.add(PrModel(name: 'Weight', goal: 10, tries: tractionTries, goalType: GoalType.minimize));
    results.add(PrModel(name: 'Retention', goal: 6, tries: tractionTries));
    results.add(PrModel(name: 'Pushups', goal: 7, tries: tractionTries));
    return results;
  }
}