import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';

class MyHabitTile extends StatelessWidget {
  final bool iscompleted;
  final String text;
  final void Function (bool?)? onchanged;
  final void Function (BuildContext)? editHabit;
  final void Function (BuildContext)? deleteHabit;
  const MyHabitTile({super.key,required this.text,required this.iscompleted,
    required this.onchanged,required this.editHabit,
    required this.deleteHabit
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding:const EdgeInsets.symmetric(horizontal: 25,vertical: 5),
      child: Slidable(
        endActionPane: ActionPane(
          motion: const StretchMotion(),
          children: [
            SlidableAction(
                onPressed:editHabit,
              backgroundColor: Colors.blue,
              icon: Icons.edit,
              borderRadius: BorderRadius.circular(8),

            ),
            SlidableAction(
              onPressed:deleteHabit,
              backgroundColor: Colors.red,
              icon: Icons.delete,
              borderRadius: BorderRadius.circular(8),
            ),
          ],
        ),
        child: GestureDetector(
          onTap: (){
            if(onchanged!=null){
              onchanged!(!iscompleted);
            }
          },
          child: Container(
            decoration: BoxDecoration(
              color: iscompleted?
                  Colors.green:
                  Theme.of(context).colorScheme.secondary,
              borderRadius: BorderRadius.circular(8),
            ),
            margin: const EdgeInsets.symmetric(vertical:2,horizontal:0),
            padding: EdgeInsets.all(8),
            child: ListTile(
            title: Text(text,style:
              TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.w600,
                color: (iscompleted)?Colors.white:Theme.of(context).colorScheme.inversePrimary,
              ),
          ),
              leading: Checkbox(
                activeColor: Colors.green,
                value: iscompleted,
                onChanged: onchanged,
              ),
          ),
          ),
        ),
      ),
    );
  }
}
