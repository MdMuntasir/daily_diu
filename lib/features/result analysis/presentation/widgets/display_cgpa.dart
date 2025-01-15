import 'package:diu_student/features/result%20analysis/domain/entities/semesterResultEntity.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class DisplayCgpa extends StatefulWidget {
  final bool showAvg;
  final double cgpa;
  final List<List<SemesterResultEntity>> results;

  const DisplayCgpa(
      {super.key,
      this.showAvg = false,
      required this.results,
      required this.cgpa});

  @override
  State<DisplayCgpa> createState() => _DisplayCgpaState();
}

class _DisplayCgpaState extends State<DisplayCgpa> {
  List<Color> gradientColors = [
    Colors.blue,
    Colors.teal,
  ];

  @override
  Widget build(BuildContext context) {
    double h = MediaQuery.of(context).size.height;
    double w = MediaQuery.of(context).size.width;

    return Padding(
      padding: EdgeInsets.symmetric(horizontal: w * .02),
      child: AspectRatio(
        aspectRatio: 1.10,
        child: Padding(
          padding: const EdgeInsets.only(
            right: 18,
            left: 12,
            top: 24,
            bottom: 12,
          ),
          child: LineChart(
            widget.showAvg ? avgData() : mainData(),
          ),
        ),
      ),
    );
  }

  Widget leftTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.blue.shade700,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );
    String text;
    switch (value.toInt()) {
      case 1:
        text = '1.0';
        break;
      case 2:
        text = '2.0';
        break;
      case 3:
        text = '3.0';
        break;
      case 4:
        text = '4.0';
        break;
      default:
        return const SizedBox();
    }

    return Text(text, style: style, textAlign: TextAlign.left);
  }

  List<FlSpot> mainDataSpots() {
    List<FlSpot> spots = [];
    double x = 0;
    widget.results.forEach((semester) {
      spots.add(FlSpot(x++, double.parse("${semester[0].cgpa}")));
    });

    return spots;
  }

  List<FlSpot> avgDataSpots() {
    List<FlSpot> spots = [];
    double x = 0;
    widget.results.forEach((semester) {
      spots.add(FlSpot(x++, widget.cgpa.toDouble()));
    });

    return spots;
  }

  Widget bottomTitleWidgets(double value, TitleMeta meta) {
    TextStyle style = TextStyle(
      color: Colors.teal.shade700,
      fontWeight: FontWeight.bold,
      fontSize: 10,
    );

    return SideTitleWidget(
      axisSide: AxisSide.bottom,
      child: Text(
        widget.results[value.toInt()][0].semesterId.toString(),
        style: style,
      ),
    );
  }

  LineChartData mainData() {
    return LineChartData(
      // backgroundColor: Colors.black.withValues(alpha: 0.8),
      borderData: FlBorderData(show: false),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        horizontalInterval: 1,
        verticalInterval: 1,
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 2,
          );
        },
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 1,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      minX: 0,
      maxX: widget.results.length.toDouble() - 1,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: mainDataSpots(),
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          dotData: const FlDotData(
            show: true,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.5))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }

  LineChartData avgData() {
    return LineChartData(
      borderData: FlBorderData(show: false),
      // backgroundColor: Colors.black87.withValues(alpha: 0.8),
      gridData: FlGridData(
        show: true,
        drawVerticalLine: true,
        drawHorizontalLine: true,
        verticalInterval: 1,
        horizontalInterval: 1,
        getDrawingVerticalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 2,
          );
        },
        getDrawingHorizontalLine: (value) {
          return const FlLine(
            color: Colors.white,
            strokeWidth: 2,
          );
        },
      ),
      titlesData: FlTitlesData(
        show: true,
        rightTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        topTitles: const AxisTitles(
          sideTitles: SideTitles(showTitles: false),
        ),
        bottomTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: bottomTitleWidgets,
          ),
        ),
        leftTitles: AxisTitles(
          sideTitles: SideTitles(
            showTitles: true,
            reservedSize: 30,
            interval: 1,
            getTitlesWidget: leftTitleWidgets,
          ),
        ),
      ),
      minX: 0,
      maxX: widget.results.length.toDouble() - 1,
      minY: 0,
      maxY: 4,
      lineBarsData: [
        LineChartBarData(
          spots: avgDataSpots(),
          gradient: LinearGradient(
            colors: gradientColors,
          ),
          barWidth: 3,
          dotData: const FlDotData(
            show: false,
          ),
          belowBarData: BarAreaData(
            show: true,
            gradient: LinearGradient(
              colors: gradientColors
                  .map((color) => color.withValues(alpha: 0.4))
                  .toList(),
            ),
          ),
        ),
      ],
    );
  }
}
