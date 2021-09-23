import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/shared/cubit/cubit/cubit.dart';
import 'package:todo/shared/cubit/states/states.dart';
import 'package:todo/shared/shared/components.dart';
import 'package:todo/shared/shared/constants.dart';

class ArchivedTasksScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit, AppState>(
      listener: (context, state) {},
      builder: (context, state) {
        var tasks= AppCubit.get(context).archivedtasks;
        return taskBuilder(tasks: tasks);
      }
    );
  }
}
