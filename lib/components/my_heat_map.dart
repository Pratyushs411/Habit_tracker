import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';

class MyHeatmap extends StatelessWidget {
  final DateTime startDate;
  final Map<DateTime, int>datasets;
  const MyHeatmap({super.key,required this.startDate,required this.datasets,});

  @override
  Widget build(BuildContext context) {
    return HeatMap(
      startDate: startDate,
        endDate: DateTime.now(),
       datasets: datasets,
        colorMode: ColorMode.color,
        defaultColor: Theme.of(context).colorScheme.secondary,
        textColor: Theme.of(context).colorScheme.inversePrimary,
        fontSize: 15,
        showColorTip: false,
        showText: true,
        scrollable: true,
        size:30,
        colorsets:
    {
      1:Colors.green.shade300,
      2:Colors.green.shade400,
      3:Colors.green.shade500,
      4:Colors.green.shade600,
      5:Colors.green.shade700,
      6:Colors.green.shade800,
      7:Colors.green.shade900,
    }
    );
  }
}
