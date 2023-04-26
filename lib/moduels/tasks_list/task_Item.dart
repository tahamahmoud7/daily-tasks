import 'package:flutter/material.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'package:todo_2/models/tasks.dart';
import 'package:todo_2/moduels/edit_task/edit_task.dart';
import '../../shared/network/local/firebase_utiles.dart';
import '../../shared/styles/colors.dart';

class TaskItem extends StatelessWidget {
  TaskData task;

  TaskItem(this.task);

  @override
  Widget build(BuildContext context) {
    return Slidable(
      startActionPane: ActionPane(motion: BehindMotion(), children: [
        SlidableAction(
          onPressed: (context) {
            deleteTaskFromFirestore(task.id);
          },
          label: "Delete",
          backgroundColor: Colors.red,
          icon: Icons.delete,
        ),
        SlidableAction(
          onPressed: (context) {
            Navigator.of(context).pushNamed(EditTask.routeName,arguments: task);
          },
          label: "Edit",
          backgroundColor: Colors.blue,
          icon: Icons.edit,
        )
      ]),
      child: Container(
        decoration: BoxDecoration(
            color: Colors.white, borderRadius: BorderRadius.circular(12)),
        padding: const EdgeInsets.all(20),
        margin: const EdgeInsets.symmetric(
          vertical: 10,
        ),
        child: Row(children: [
          Container(
            height: 70,
            width: 5,
            color: task.isDone ? colorGreen : pramiryColor,
          ),
          const SizedBox(
            width: 10,
          ),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(task.title,
                    style: task.isDone
                        ? Theme.of(context)
                            .textTheme
                            .subtitle1!
                            .copyWith(color: colorGreen)
                        : Theme.of(context).textTheme.subtitle1),
                Text(task.description)
              ],
            ),
          ),
          InkWell(
            onTap: () {
              editisDoneinFirestore(task);
            },
            child: task.isDone
                ? const Text(
                    "Done!",
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: colorGreen),
                  )
                : Container(
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(12),
                        color: pramiryColor),
                    child: const Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 20, vertical: 5),
                      child: Icon(
                        Icons.done,
                        color: Colors.white,
                        size: 30,
                      ),
                    )),
          )
        ]),
      ),
    );
  }
}
