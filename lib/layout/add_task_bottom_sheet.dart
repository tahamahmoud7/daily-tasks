import 'package:flutter/material.dart';
import 'package:todo_2/models/tasks.dart';

import '../shared/compnents/compnets.dart';
import '../shared/network/local/firebase_utiles.dart';
import '../shared/styles/colors.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
class AddTaskBottomSheet extends StatefulWidget {
  const AddTaskBottomSheet({super.key});

  @override
  State<AddTaskBottomSheet> createState() => _AddTaskBottomSheetState();
}

class _AddTaskBottomSheetState extends State<AddTaskBottomSheet> {
  var titleController = TextEditingController();

  var descriptionController = TextEditingController();

  GlobalKey<FormState> FromKey = GlobalKey<FormState>();

  DateTime selectData = DateTime.now();

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Container(
        margin: const EdgeInsets.symmetric(vertical: 20, horizontal: 20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(AppLocalizations.of(context)!.addNewTask,
                textAlign: TextAlign.center,
                style: Theme.of(context)
                    .textTheme
                    .subtitle1
                    ?.copyWith(color: Colors.black, fontSize: 30)),
            const SizedBox(
              height: 10,
            ),
            Form(
                key: FromKey,
                child: Column(children: [
                  TextFormField(
                      controller: titleController,
                      validator: (text) {
                        if (text == "") {
                          return AppLocalizations.of(context)!.pleaseEntarTitle;
                        }
                        return null;
                      },
                      decoration:  InputDecoration(
                          label: Text(AppLocalizations.of(context)!.title),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: pramiryColor)))),
                  const SizedBox(
                    height: 20,
                  ),
                  TextFormField(
                      validator: (text) {
                        if (text == "") {
                          return AppLocalizations.of(context)!.pleaseEntarDescrbtion;
                        }
                        return null;
                      },
                      controller: descriptionController,
                      maxLines: 3,
                      decoration:  InputDecoration(
                          label: Text(AppLocalizations.of(context)!.descrabtion),
                          enabledBorder: const OutlineInputBorder(
                              borderSide: BorderSide(color: pramiryColor)))),
                  const SizedBox(
                    height: 20,
                  ),
                  Text(AppLocalizations.of(context)!.selectData,
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
                          TaskData task = TaskData(
                              title: titleController.text,
                              description: descriptionController.text,
                              date: DateUtils.dateOnly(selectData)
                                  .millisecondsSinceEpoch);
                          showLoading(context, "Loding..");
                          showMessage(
                              context,
                              AppLocalizations.of(context)!.areYouSureAddTask,
                              AppLocalizations.of(context)!.yes,
                              () {
                                addTaskToFirebaseFirestore(task);
                                hideLoding(context);

                                Navigator.pop(context);
                                Navigator.pop(context);
                              },
                              nagBtn: AppLocalizations.of(context)!.cencal,
                              negAction: () {
                                hideLoding(context);
                                Navigator.pop(context);
                                Navigator.pop(context);
                              });
                        }
                      },
                      child:  Text(
                        AppLocalizations.of(context)!.addTask,
                      ))
                ]))
          ],
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
    setState(() {});
  }

  void editIsDone(TaskData taskData) {
    editisDoneinFirestore(taskData);
  }
void updateTask(TaskData task){
    editTaskinFirebase(task);
}
}
