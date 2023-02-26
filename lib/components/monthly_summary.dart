import 'package:flutter/material.dart';
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/date_time/date_time.dart';

class MonthlySummary extends StatelessWidget {
  final Map<DateTime ,int>? datasets; 
  final String startDate; 
  const MonthlySummary({super.key, required this.datasets, required this.startDate});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(top: 25, left: 25),
      child: HeatMap(
        datasets: datasets,
        startDate: createDateTimeObject(startDate),
        endDate: DateTime.now().add(Duration(days:0)),
        colorMode: ColorMode.color,
        showColorTip: false,
        showText: true,
        scrollable: true,
        colorsets: {
          1: Color.fromARGB(255, 7, 73, 29),
          2: Color.fromARGB(255, 10, 124, 48),
          3: Color.fromARGB(255, 6, 155, 56),
          4: Color.fromARGB(255, 2, 190, 65),
          5: Color.fromARGB(255, 2, 212, 72),
          6: Color.fromARGB(255, 2, 224, 76),
          7: Color.fromARGB(255, 2, 236, 80),
          8: Color.fromARGB(255, 0, 255, 85),
          9: Color.fromARGB(255, 0, 255, 85),
          10: Color.fromARGB(255, 0, 255, 85),
         
        },
        onClick: (value) {
          ScaffoldMessenger.of(context)
              .showSnackBar(SnackBar(content: Text(value.toString())));
        },
      ),
    );
  }
}
