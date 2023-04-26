import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:todo_2/models/tasks.dart';
import 'package:todo_2/moduels/tasks_list/task_Item.dart';
import 'package:calendar_timeline/calendar_timeline.dart';
import 'package:todo_2/shared/network/local/firebase_utiles.dart';

import '../../shared/styles/colors.dart';

class TaskListTab extends StatefulWidget {
  @override
  State<TaskListTab> createState() => _TaskListTabState();
}

class _TaskListTabState extends State<TaskListTab> {
  DateTime CurrentDate = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(children: [
        CalendarTimeline(
          initialDate: CurrentDate,
          firstDate: DateTime.now().subtract(const Duration(days: 365)),
          lastDate: DateTime.now().add(const Duration(days: 365)),
          onDateSelected: (date) {
            CurrentDate = date;
            setState(() {});
          },
          leftMargin: 20,
          monthColor: colorBlack,
          dayColor: pramiryColor,
          activeDayColor: Colors.white,
          activeBackgroundDayColor: pramiryColor,
          dotsColor: Colors.white,
          selectableDayPredicate: (date) => true,
          locale: 'en',
        ),
        StreamBuilder<QuerySnapshot<TaskData>>(
          stream: getTasksFromFirestore(CurrentDate),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            if (snapshot.hasError) {
              return const Center(
                  child: Text(
                "Something went wrong ",
              ));
            }
            var tasks =
                snapshot.data?.docs.map((doc) => doc.data()).toList() ?? [];
            if (tasks.isEmpty) {
              return const Center(
                child: Text("No Data"),
              );
            }
            return Expanded(
              child: ListView.builder(
                itemCount: tasks.length,
                itemBuilder: (context, index) {
                  return TaskItem(tasks[index]);
                },
              ),
            );
          },
        )
      ]),
    );
  }
}
