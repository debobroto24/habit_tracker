import 'package:flutter/material.dart';
import 'package:flutter/src/widgets/framework.dart';
import 'package:flutter/src/widgets/placeholder.dart';

class MyNewHabit extends StatelessWidget {
  final VoidCallback onSave; 
  final VoidCallback onCancel; 
  final TextEditingController controller; 
  const MyNewHabit({super.key, required this.onSave, required this.onCancel, required  this.controller});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      backgroundColor: Colors.grey[900],
      content: TextField(
        controller: controller,
         style: TextStyle(color:Colors.white), 
        decoration: InputDecoration(  
         
          hintText:"Enter new habit...",
          hintStyle: TextStyle(color:Colors.white),
         enabledBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color:Colors.white), ), 
         focusedBorder: OutlineInputBorder(borderSide: BorderSide(width: 1,color:Colors.white), ), 

        ),
      ), 
      actions: [
        MaterialButton(onPressed: onSave, child: Text("save",style: TextStyle(color:Colors.white)),color: Colors.black,)
        , MaterialButton(onPressed: onCancel, child: Text("cancel",style: TextStyle(color:Colors.white)),color: Colors.black,)
      ],
    );
  }
}