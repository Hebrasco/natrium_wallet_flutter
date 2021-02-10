import 'package:fl_chart/fl_chart.dart';

class ChartSpot extends FlSpot {
  DateTime dateTime;

  ChartSpot(DateTime dateTime, double x, double y) : super(x, y) {
    this.dateTime = dateTime;
  }
}