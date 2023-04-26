import 'package:flutter/material.dart';
import 'package:todo_2/models/tasks.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import '../../shared/network/local/firebase_utiles.dart';
import '../../shared/styles/colors.dart';

class EditTask extends StatefulWidget {
  static const String routeName = "EditTask";

  @override
  State<EditTask> createState() => _EditTaskState();
}

class _EditTaskState extends State<EditTask> {
  GlobalKey<FormState> FromKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var descriptionController = TextEditingController();
  late TaskData task;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((DurationS) {
      task = ModalRoute.of(context)?.settings.arguments as TaskData;
      titleController.text = task.title;
      descriptionController.text = task.description;
      selectData = DateTime.fromMillisecondsSinceEpoch(task.date);

      setState(() {});
    });
  }

  DateTime selectData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    var ScreenSize = MediaQuery.of(context).size;
    return Scaffold(
      appBar: AppBar(
        backgroundColor: pramiryColor,
        elevation: 0,
        title: const Text("To Do List"),
      ),
      body: Container(
        color: Colors.white10,
        child: SingleChildScrollView(
          child: Column(children: [
            Stack(children: [
              Container(
                color: pramiryColor,
                height: ScreenSize.height * 0.1,
              ),
              Container(
                padding: const EdgeInsets.all(10),
                margin:
                    const EdgeInsets.symmetric(vertical: 20, horizontal: 40),
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(18)),
                height: ScreenSize.height * 0.7,
                width: ScreenSize.width * 0.8,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(AppLocalizations.of(context)!.editTask,
                        textAlign: TextAlign.center,
                        style: Theme.of(context)
                            .textTheme
                            .subtitle1
                            ?.copyWith(color: Colors.black, fontSize: 25)),
                    const SizedBox(
                      height: 10,
                    ),
                    Form(
                        key: FromKey,
                        child: Column(children: [
                          TextFormField(
                              controller: titleController,
                              decoration: InputDecoration(
                                label: Text(
                                    AppLocalizations.of(context)!.editTitle),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          TextFormField(
                              controller: descriptionController,
                              maxLines: 2,
                              decoration: InputDecoration(
                                label: Text(AppLocalizations.of(context)!
                                    .editDescrabtion),
                              )),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(AppLocalizations.of(context)!.editSelectData,
                              style: Theme.of(context)
                                  .textTheme
                                  .subtitle1
                                  ?.copyWith(color: colorBlack)),
                          const SizedBox(
                            height: 10,
                          ),
                          InkWell(
                            onTap: () {
                              ShowPickar(context);
                            },
                            child: Text(
                                '${selectData.year}/${selectData.month}/${selectData.day}',
                                textAlign: TextAlign.center,
                                style: Theme.of(context).textTheme.subtitle1),
                          ),
                          const SizedBox(
                            height: 20,
                          ),
                          ElevatedButton(
                              onPressed: () {
                                if (FromKey.currentState!.validate()) {
                                  task.title = titleController.text;
                                  task.description = descriptionController.text;
                                  task.date = DateUtils.dateOnly(selectData)
                                      .millisecondsSinceEpoch;

                                  updateTask(task);
                                }
                                Navigator.of(context).pop();
                              },
                              child: Text(
                                AppLocalizations.of(context)!.saveChanges,
                                style: TextStyle(fontSize: 20),
                              ))
                        ]))
                  ],
                ),
              )
            ])
          ]),
        ),
      ),
    );
  }

  void ShowPickar(BuildContext context) async {
    DateTime? chosenDate = await showDatePicker(
        context: context,
        initialDate: selectData,
        firstDate: DateTime.now(),
        lastDate: DateTime.now().add(const Duration(days: 365)));

    selectData = chosenDate!;
    if (chosenDate == null) return;
    selectData = chosenDate;
    setState(() {});
  }
}

void updateTask(TaskData task) {
  editTaskinFirebase(task);
}
