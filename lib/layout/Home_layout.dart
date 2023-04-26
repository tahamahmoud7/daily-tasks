import 'package:flutter/material.dart';
import 'package:todo_2/settings/settings.dart';
import '../moduels/tasks_list/tasks_list.dart';
import 'add_task_bottom_sheet.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class Home_layout extends StatefulWidget {
  static const String routeName = "Home";

  @override
  State<Home_layout> createState() => _Home_layoutState();
}

class _Home_layoutState extends State<Home_layout> {
  int currentIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        extendBody: true,
        appBar: AppBar(title: Text(AppLocalizations.of(context)!.toDoList)),
        floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
        floatingActionButton: FloatingActionButton(
          shape: const StadiumBorder(
              side: BorderSide(color: Colors.white, width: 4)),
          onPressed: () {
            ShowAddTaskBottomSheet();
          },
          child: const Icon(Icons.add),
        ),
        bottomNavigationBar: BottomAppBar(
          notchMargin: 8,
          shape: const CircularNotchedRectangle(),
          child: BottomNavigationBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            currentIndex: currentIndex,
            onTap: (index) {
              currentIndex = index;
              setState(() {});
            },
            items:  [
              BottomNavigationBarItem(
                  icon: Icon(Icons.list, size: 30), label: AppLocalizations.of(context)!.list),
              BottomNavigationBarItem(
                  icon: Icon(Icons.settings, size: 30), label:AppLocalizations.of(context)!.setting,)
            ],
          ),
        ),
        body: Tabs[currentIndex]);
  }

  void ShowAddTaskBottomSheet() {
    showModalBottomSheet(
        isScrollControlled: true,
        context: context,
        builder: (context) => Padding(
              padding: EdgeInsets.only(
                  bottom: MediaQuery.of(context).viewInsets.bottom),
              child: const AddTaskBottomSheet(),
            ));
  }

  List<Widget> Tabs = [TaskListTab(), const SettingsTab()];
}
