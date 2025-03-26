import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:pr_tracker/models/pr_model.dart';
import 'package:intl/intl.dart';

class LineChartPrWidget extends StatelessWidget {
  final PrModel pr;

  const LineChartPrWidget({super.key, required this.pr});

  List<DateTime> getLastXMonths(int x) {
    final now = DateTime.now();
    return List.generate(x, (i) {
      final date = DateTime(now.year, now.month - (x - 1) + i);
      return DateTime(date.year, date.month); // normalize to 1st of month
    });
  }

  @override
  Widget build(BuildContext context) {
    final monthsDelay = 3;
    final months = getLastXMonths(monthsDelay);

    return SizedBox(
      height: 180,
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: LineChart(
          LineChartData(
            maxY: pr.maxY() + 1,
            minY: pr.minY() - 1,
            maxX: monthsDelay.toDouble(),
            minX: 0,
            gridData: FlGridData(show: false), // Show grid lines
            titlesData: FlTitlesData(
              bottomTitles: AxisTitles(
                sideTitles: SideTitles(
                  showTitles: true,
                  interval: 1,
                  getTitlesWidget: (value, meta) {
                    final index = value.toInt();
                    if (index >= 0 && index < months.length) {
                      return Text(
                        DateFormat('MMM').format(months[index]), // e.g., Jan
                        style: TextStyle(fontSize: 12),
                      );
                    }
                    return Text('');
                  },
                ),
              ),
              topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
            ),
            borderData: FlBorderData(show: false),
            lineBarsData: [
              LineChartBarData(
                spots: pr.getTries(monthsDelay),
                isCurved: true, // Smooth the line
                color: pr.isGoalMet() ? Colors.green : Colors.red,
                barWidth: 3,
                belowBarData: BarAreaData(show: false),
                dotData: FlDotData(show: true), // Show dots on points
              ),
            ],
            extraLinesData: ExtraLinesData(
              horizontalLines: [
                HorizontalLine(
                  y: pr.goal,
                  color: Colors.grey,
                  strokeWidth: 2,
                  dashArray: [5, 5],
                  label: HorizontalLineLabel(
                    show: true,
                    labelResolver: (_) => 'Target',
                    style: TextStyle(
                      color: Colors.grey,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
