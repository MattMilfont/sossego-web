import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:sossego_web/modules/home/models/report_model.dart';

class ReportsMonthsGraphic extends StatefulWidget {
  final List<ReportModel> reports;
  final Color columnColor;
  const ReportsMonthsGraphic({
    required this.reports,
    required this.columnColor,
    super.key,
  });

  @override
  State<ReportsMonthsGraphic> createState() => _ReportsMonthsGraphicState();
}

class _ReportsMonthsGraphicState extends State<ReportsMonthsGraphic> {
  @override
  Widget build(BuildContext context) {
    Map<int, int> reportsPerMonth = getReportsPerMonth(widget.reports);
    List<BarChartGroupData> barGroups = generateBarChartGroups(
      reportsPerMonth,
      widget.columnColor,
    );

    return BarChart(
      BarChartData(
        alignment: BarChartAlignment.spaceAround,
        maxY:
            (reportsPerMonth.values.isNotEmpty
                    ? reportsPerMonth.values.reduce((a, b) => a > b ? a : b) + 2
                    : 10)
                .toDouble(),
        barGroups: barGroups,
        titlesData: FlTitlesData(
          topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          leftTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
          bottomTitles: AxisTitles(
            sideTitles: SideTitles(
              showTitles: true,
              getTitlesWidget: (value, meta) {
                switch (value.toInt()) {
                  case 1:
                    return Text('Jan');
                  case 2:
                    return Text('Fev');
                  case 3:
                    return Text('Mar');
                  case 4:
                    return Text('Abr');
                  case 5:
                    return Text('Mai');
                  case 6:
                    return Text('Jun');
                  case 7:
                    return Text('Jul');
                  case 8:
                    return Text('Ago');
                  case 9:
                    return Text('Set');
                  case 10:
                    return Text('Out');
                  case 11:
                    return Text('Nov');
                  case 12:
                    return Text('Dez');
                  default:
                    return Text('');
                }
              },
            ),
          ),
        ),
      ),
    );
  }

  Map<int, int> getReportsPerMonth(List<ReportModel> reports) {
    Map<int, int> reportsPerMonth = {};

    for (var report in reports) {
      if (report.reportDate != null) {
        try {
          DateTime date = DateTime.parse(report.reportDate!);
          int month = date.month;

          if (reportsPerMonth.containsKey(month)) {
            reportsPerMonth[month] = reportsPerMonth[month]! + 1;
          } else {
            reportsPerMonth[month] = 1;
          }
        } catch (e) {
          print('Erro ao converter data: ${report.reportDate}');
        }
      }
    }

    return reportsPerMonth;
  }

  List<BarChartGroupData> generateBarChartGroups(
    Map<int, int> reportsPerMonth,
    Color columnColor,
  ) {
    List<BarChartGroupData> barGroups = [];

    for (int i = 1; i <= 12; i++) {
      double y = (reportsPerMonth[i] ?? 0).toDouble();

      barGroups.add(
        BarChartGroupData(
          x: i,
          barRods: [BarChartRodData(toY: y, color: columnColor)],
        ),
      );
    }

    return barGroups;
  }
}
