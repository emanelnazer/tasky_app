import 'package:date_picker_timeline/date_picker_timeline.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:tasky/core/dialogs/app_dialogs.dart';
import 'package:tasky/core/dialogs/app_toasts.dart';
import 'package:tasky/core/utils/app_assets.dart';
import 'package:tasky/feature/home/domain/usercase/add_task_usecase.dart';
import 'package:tasky/feature/home/domain/usercase/get_task_usecase.dart';
import 'package:tasky/feature/home/domain/usercase/update_task_usecase.dart';
import 'package:tasky/feature/home/presentation/view_model/home_cubit.dart';
import 'package:tasky/feature/home/presentation/view_model/home_state.dart';
import 'package:tasky/feature/home/presentation/widgets/completedTaskwidgets.dart';
import 'package:tasky/feature/home/presentation/widgets/loading_widgets.dart';
import 'package:tasky/feature/home/presentation/widgets/tasklist_wiget.dart';
import 'package:toastification/toastification.dart';

class HomeScreen extends StatefulWidget {
  static const String routeName = "homeScreen";
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late HomeCubit cubit;
  DateTime selectedDate = DateTime.now();

  @override
  void initState() {
    super.initState();
    cubit = HomeCubit(
      injectableAddTasksUseCase(),
      injectableGetTasksUseCase(),
      injectableUpdateTasksUseCase(),
    );
    cubit.getTasks(selectedDate);
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<HomeCubit, HomeState>(
      bloc: cubit,
      listener: (context, state) {
        if (state is HomaLoadingSate) {
          AppDialogs.showLoadingDialog(context);
        } else if (state is HomeErrorState) {
          Navigator.pop(context);
          AppToast.showToast(
            context: context,
            title: "Error",
            description: "Something went wrong",
            type: ToastificationType.error,
          );
        } else if (state is HomeSucessState) {
          Navigator.pop(context);
        }
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.white,
          title: Image.asset(AppAssets.logo),
          actions: [
            InkWell(
              onTap: () {
                FirebaseAuth.instance.signOut();
                Navigator.of(context).pushNamed("LoginScreen");
              },
              child: Row(
                children: [
                  Image.asset(AppAssets.logout),
                  const SizedBox(width: 10),
                  const Text(
                    "Logout",
                    style: TextStyle(color: Color(0xffFF4949)),
                  ),
                  const SizedBox(width: 10),
                ],
              ),
            ),
          ],
        ),
        body: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            DatePicker(
              DateTime.now(),
              initialSelectedDate: selectedDate,
              selectionColor: const Color(0xff5F33E1),
              selectedTextColor: Colors.white,
              onDateChange: (date) {
                selectedDate = date;
                cubit.getTasks(date);
              },
            ),
            const SizedBox(height: 10),
            BlocBuilder<HomeCubit, HomeState>(
              bloc: cubit,
              builder: (context, state) {
                if (state is HomaLoadingSate) {
                  return const LoadingWidet();
                }

                return TasksListWidget(
                  tasks: cubit.tasks,
                  onToggleComplete: (task, value) {
                    cubit.updateTask(
                      task.copyWith(isCompleted: value),
                    );
                  },
                );
              },
            ),
            const SizedBox(height: 10),
            const Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Text(
                "Completed",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
              ),
            ),
            CompletedTaskWidgets(
              tasks: cubit.completedTasks,
              onToggleComplete: (task, value) {
                cubit.updateTask(
                  task.copyWith(isCompleted: value),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
}
