import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:habit_tracker/components/habit_title.dart';
import 'package:habit_tracker/components/monthly_summary.dart';
import 'package:habit_tracker/components/my_new_habit.dart';
import 'package:habit_tracker/components/my_floatingaction_btn.dart';
import 'package:habit_tracker/data/habit_database.dart';
import 'package:hive_flutter/hive_flutter.dart';

class Home extends StatefulWidget {
  const Home({super.key});

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  final _newHavitController = TextEditingController();

  HabitDatabase db = HabitDatabase(); 
  final _myBox = Hive.box("Habit_Database"); 
 
  

  // checkbox tapped
  checkboxTapped(value, int index) {
    setState(() {
      db.habitList[index][1] = value;
    });
     db.updateData(); 
  }

  // create habit
  createHabit() {
    showDialog(
        context: context,
        builder: (context) {
          return MyNewHabit(
              onSave: onSave,
              onCancel: onCancel,
              controller: _newHavitController);
        });
  }

  // on save create new item
  onSave() {
    setState(() {
      db.habitList.add([_newHavitController.text, false]);
    });
    db.updateData();
    Navigator.of(context).pop();
  }

  // on cancel
  onCancel() {
    _newHavitController.clear();
    Navigator.of(context).pop();
  }


  // on tapped on delete
  onSettingTapped(index) {
    showDialog(
      context: context,
      builder: (context) {
        return MyNewHabit(
            onSave:()=> saveExixgingHabit(index),
            onCancel: onCancel,
            controller: _newHavitController);
      },
    );
  }

  saveExixgingHabit(int index) {
    setState(() {
      db.habitList[index][0] = _newHavitController.text;
    });
     db.updateData(); 
    _newHavitController.clear();
    Navigator.of(context).pop();
  }

  onDeleteTapped(index) {
   setState(() {
      db.habitList.removeAt(index);
       db.updateData(); 
   });

  }
  @override
  void initState() {
    super.initState();
     db.createDefaultData(); 
     
    if(_myBox.get("CURRENT_HABIT_LIST").length ==0){
      print("in if"); 
        
      db.createDefaultData(); 
      
    }else{
      print('current habitlist ${_myBox.get("CURRENT_HABIT_LIST").length }');
      print("in else"); 
       db.phabit();
      db.loadData();
    }
    db.updateData(); 

  }

  @override
  Widget build(BuildContext context) {
    print(db.phabit());
    return Scaffold(
      backgroundColor: Colors.grey[300],
      appBar: AppBar(
        title: const Text("Habit Tracker"),
        elevation: 0.0,
      ),
      body: ListView(
        children: [
          MonthlySummary(datasets: db.heatMapDatasets, startDate: _myBox.get("START_DATE"))
          , ListView.builder(
            shrinkWrap: true,
            itemCount: db.habitList.length,
            itemBuilder: (context, index) {
              print("hello"); 
              return HabitTitle(
                habitName: db.habitList[index][0],
                habitCompleted: db.habitList[index][1],
                onChanged: (value) => checkboxTapped(value, index),
                onSettingTapped: (context) => onSettingTapped(index),
                onDeleteTapped: (context) => onDeleteTapped(index),
              );
            },
          ),
        ],
      ),
      floatingActionButton: MyFloatingActionButton(onPressed: createHabit),
    );
  }
}
