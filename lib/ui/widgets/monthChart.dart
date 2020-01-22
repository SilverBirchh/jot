import 'package:Jot/bloc/jot/bloc.dart';
import 'package:Jot/data/jot/jot_model.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class ChartData {
  ChartData({this.name, this.yVal});

  String name;
  int yVal;
}

class ExtendedChartData {
  final List<String> names = [];
  final List<BarChartGroupData> data = [];
}

class MonthChart extends StatelessWidget {
  MonthChart({this.jotState});

  final LoadedJots jotState;

  double getMaxY(List<BarChartGroupData> data) {
    double max = 0;

    for (BarChartGroupData datum in data) {
      if (datum.barRods.first.y > max) {
        max = datum.barRods.first.y;
      }
    }

    return max;
  }

  ExtendedChartData getChartData() {
    List<Jot> jots = jotState.jots;
    Map<String, ChartData> chartData = <String, ChartData>{};
    ExtendedChartData fullData = ExtendedChartData();

    for (Jot jot in jots) {
      DateFormat month = DateFormat("MMM");
      DateFormat year = DateFormat("y");

      String fullDate =
          '${month.format(jot.startDate.toDate())} ${year.format(jot.startDate.toDate())}';
      if (chartData[fullDate] != null) {
        ++chartData[fullDate].yVal;
      } else {
        chartData[fullDate] = ChartData(name: fullDate, yVal: 1);
      }
    }

    int idx = 0;

    for (String key in chartData.keys) {
      fullData.names.add(key);
      fullData.data.add(
        BarChartGroupData(
          x: idx,
          barRods: [
            BarChartRodData(
                y: chartData[key].yVal.toDouble(),
                color: Colors.lightBlueAccent)
          ],
          showingTooltipIndicators: [0],
        ),
      );

      ++idx;
    }

    return fullData;
  }

  @override
  Widget build(BuildContext context) {
    ExtendedChartData chartData = getChartData();
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(4)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          Padding(
            padding: const EdgeInsets.fromLTRB(34.0, 8.0, 8.0, 8.0),
            child: Text(
              "By Month",
              style: TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black),
            ),
          ),
          Center(
            child: SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Container(
                width: MediaQuery.of(context).size.width <=
                        (chartData.data.length * 10).toDouble()
                    ?(chartData.data.length * 10).toDouble() : MediaQuery.of(context).size.width,
                    
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: getMaxY(chartData.data) + 3,
                    barTouchData: BarTouchData(
                      enabled: false,
                      touchTooltipData: BarTouchTooltipData(
                        tooltipBgColor: Colors.transparent,
                        tooltipPadding: const EdgeInsets.all(0),
                        tooltipBottomMargin: 8,
                        getTooltipItem: (
                          BarChartGroupData group,
                          int groupIndex,
                          BarChartRodData rod,
                          int rodIndex,
                        ) {
                          return BarTooltipItem(
                            rod.y.round().toString(),
                            TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          );
                        },
                      ),
                    ),
                    titlesData: FlTitlesData(
                      show: true,
                      bottomTitles: SideTitles(
                        showTitles: true,
                        textStyle: TextStyle(
                            color: const Color(0xff7589a2),
                            fontWeight: FontWeight.bold,
                            fontSize: 14),
                        margin: 20,
                        getTitles: (double value) {
                          return chartData.names[value.toInt()];
                        },
                      ),
                      leftTitles: const SideTitles(showTitles: false),
                    ),
                    borderData: FlBorderData(
                      show: false,
                    ),
                    barGroups: List.from(chartData.data.reversed),
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
