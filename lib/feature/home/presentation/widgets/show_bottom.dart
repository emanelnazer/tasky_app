import 'package:flutter/material.dart';
import 'package:tasky/core/common/widgets/custom_textfield.dart';
import 'package:tasky/core/network/result_firbase.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/core/utils/app_dalog.dart';
import 'package:tasky/feature/home/data/firebase/task_firebase.dart';
import 'package:tasky/feature/home/data/model/task_dto.dart';
import 'package:tasky/feature/home/presentation/widgets/priority_dialog.dart';


class ShowBottomSheetTask extends StatefulWidget {
  const ShowBottomSheetTask({super.key});

  @override
  State<ShowBottomSheetTask> createState() => _ShowBottomSheetTaskState();
}

class _ShowBottomSheetTaskState extends State<ShowBottomSheetTask> {
  late TextEditingController taskNameController;
  late TextEditingController descriptionController;
  late DateTime selectedDate;
  late int priorityIndex;
  FireBaseTask? _fireBaseTask;
  @override
  void initState() {
    super.initState();
    taskNameController = TextEditingController();
    descriptionController = TextEditingController();
    selectedDate = DateTime.now();
    priorityIndex = 1;
  }

  @override
  void dispose() {
    taskNameController.dispose();
    descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        child: Column(
          children: [
            const Text(
              "Add Task",
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),
            TextFormFieldWidget(
              controller: taskNameController,
              hintText: "Enter task title",
              validator: (value) {
                if (value!.isEmpty) return "Field is required";
                return null;
              },
            ),
            const SizedBox(height: 10),
            TextFormFieldWidget(
              controller: descriptionController,
              hintText: "Enter description",
              validator: (value) {
                if (value!.isEmpty) return "Description is required";
                return null;
              },
            ),
            const SizedBox(height: 15),
            Row(
              children: [
                iconInWell(
                  imagePath: AppAssets.timer,
                  onPressed: () async {
                    selectedDate = await showDatePicker(
                      context: context,
                      initialDate: DateTime.now(),
                      firstDate: DateTime.now(),
                      lastDate:
                      DateTime.now().add(const Duration(days: 30)),
                    ) ??
                        DateTime.now();
                  },
                ),
                const SizedBox(width: 10),
                iconInWell(
                  imagePath: AppAssets.flag,
                  onPressed: () {
                    showDialog(
                      context: context,
                      builder: (context) => PriorityDialogWidget(
                        ontap: (index) {
                          setState(() {
                            priorityIndex = index;
                          });
                        },
                      ),
                    );
                  },
                ),
                const Spacer(),
                iconInWell(
                  imagePath: AppAssets.send,
                  onPressed: _onPressedSendTask,
                )
              ],
            ),
          ],
        ),
      ),
    );
  }

  Widget iconInWell({
    required String imagePath,
    required VoidCallback onPressed,
  }) {
    return InkWell(
      onTap: onPressed,
      child: Image.asset(
        imagePath,
        width: 24,
        height: 24,
        fit: BoxFit.contain,
      ),
    );
  }

  void _onPressedSendTask() async {
    final normalizedDate =
    DateTime(selectedDate.year, selectedDate.month, selectedDate.day);

    AppDialog.showloading(context);
    try {

      final result = await _fireBaseTask!.addTask(TaskDto(
        title: taskNameController.text,
        description: descriptionController.text,
        date: normalizedDate,
        priority: priorityIndex,
      ));

      if (result is SucessFB<TaskDto>) {
        Navigator.of(context).pop(); // Close bottom sheet
        print("Task added successfully: ${result.data.id}");
      } else if (result is ErrorFB<TaskDto>) {
        print("Failed to add task: ${result.message}");
        AppDialog.showerror(context, error: result.message);
      }
    } finally {
      Navigator.of(context).pop(); // Close loading dialog
    }
  }
}
