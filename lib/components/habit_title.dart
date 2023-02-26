import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class HabitTitle extends StatelessWidget {
  final String habitName;
  final bool habitCompleted;
  final Function(bool?)? onChanged;
  final Function(BuildContext?)? onSettingTapped; 
  final Function(BuildContext?)? onDeleteTapped; 
  const HabitTitle(
      {super.key,
      required this.habitName,
      required this.habitCompleted,
     required this.onChanged, required this.onSettingTapped,required this.onDeleteTapped});

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;
    return Padding(
      padding: EdgeInsets.only(
          top: height * .03, left: width * .05, right: width * .05),
      child: Slidable(
        endActionPane: ActionPane(
          motion: StretchMotion(),
          children: [
            SlidableAction(
              onPressed: onSettingTapped,
              icon: Icons.settings,
              backgroundColor: Colors.grey.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
            SlidableAction(
              onPressed: onDeleteTapped,
              icon: Icons.delete,
              backgroundColor: Colors.red.shade800,
              borderRadius: BorderRadius.circular(10),
            ),
          ],
        ),
        child: Container(
          padding: const EdgeInsets.only(left: 10, right: 10),
          width: width * .9,
          height: height * .1,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(width * .03),
            color: Colors.white,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.start,
            children: [
              Checkbox(value: habitCompleted, onChanged: onChanged),
              Text(
                habitName,
                style: TextStyle(fontSize: 20),
              )
            ],
          ),
        ),
      ),
    );
  }
}
