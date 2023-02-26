// reference our box
import 'package:flutter_heatmap_calendar/flutter_heatmap_calendar.dart';
import 'package:habit_tracker/date_time/date_time.dart';
import 'package:hive_flutter/hive_flutter.dart';

final _myBox = Hive.box("Habit_Database");

class HabitDatabase {
  List habitList = [];
  Map<DateTime, int>?  heatMapDatasets = {}; 
  // initial data
  void createDefaultData() {
     habitList = [
      ["Morning", false],
      ["Night", false],
    ];

    _myBox.put("START_DATE", todaysDateFormated()); 
    
  }
  phabit(){
    print("habit list in phabit ${habitList}");
  }
  // load Data
  void loadData() {
    if(_myBox.get(todaysDateFormated()).length == 0 ){
      print("load data if");
      habitList = _myBox.get("CURRENT_HABIT_LIST"); 
      for(int i=0 ; i< habitList.length ; i++){
        habitList[i][1]= false; 
      }
    }else{
       print("load data else");
      habitList = _myBox.get(todaysDateFormated());
    }
  }

  // updataData
  void updateData() {
    // update entry  
    _myBox.put(todaysDateFormated(), habitList); 
    // update universal habit oloist in case it changed (new habit ,edit habit , delete habit)
    _myBox.put("CURRENT_HABIT_LIST", habitList); 

    calculateHabitPersentage(); 

    loadHeatMap(); 
  }


  // calculate habit persentage  
  calculateHabitPersentage(){
    int countCompleted = 0 ; 
    for(int i=0 ; i<habitList.length; i++){
      if(habitList[i][1] == true){
        countCompleted++; 
      }
    }

   String persent =habitList.length == 0 ?'0.0':  ( countCompleted / habitList.length).toStringAsFixed(1); 
   _myBox.put("PERSENTAGE_SUMMARY_${todaysDateFormated()}", persent); 
  }

  loadHeatMap(){
    DateTime startDate = createDateTimeObject(_myBox.get("START_DATE")); 

    // count the number of days to load 
    int daysInBetween = DateTime.now().difference(startDate).inDays; 

    for(int i=0; i<daysInBetween ; i++){
      String yyyymmdd = convertDateTimeToString(startDate.add(Duration(days: i))); 
      double strength = double.parse(_myBox.get("PERSENTAGE_SUMMARY_${todaysDateFormated()}") ?? "0.0"); 
      int year = startDate.add(Duration(days: i)).year; 
      int month = startDate.add(Duration(days: i)).month; 
      int day = startDate.add(Duration(days: i)).day; 
      final persentageForEachDay = <DateTime , int> {
        DateTime(year,month,day): (10 * strength).toInt(), 
      };

      heatMapDatasets?.addEntries(persentageForEachDay.entries); 
      print(heatMapDatasets);
    }
  }
}
