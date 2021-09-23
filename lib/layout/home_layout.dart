import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:todo/modules/done/done_tasks_screen.dart';
import 'package:todo/modules/new/new_tasks_screen.dart';
import 'package:sqflite/sqflite.dart';
import 'package:date_time_picker/date_time_picker.dart';
import 'package:todo/shared/cubit/cubit/cubit.dart';
import 'package:todo/shared/cubit/states/states.dart';
import 'package:todo/shared/shared/components.dart';
import 'package:todo/shared/shared/constants.dart';
import '../modules/archived/arcived_tasks_screen.dart';
import 'package:intl/intl.dart';

class HomeLayoutScreen extends StatelessWidget {
  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();
  var titleController = TextEditingController();
  var timeController = TextEditingController();
  var dateController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit(AppIntialState())..createDatabase(),
      child: BlocConsumer<AppCubit,AppState>(
        listener: (context,state){
          if(state is AppInsertToDataBase){
            Navigator.pop(context);
          }
        },
        builder: (context,state) {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            backgroundColor: Colors.black,
            key: scaffoldKey,
            appBar: AppBar(
              title: Text(cubit.titles[cubit.currentIndex]),
              backgroundColor: Colors.teal,
            ),
            body: cubit.screens[cubit.currentIndex],
            floatingActionButton: FloatingActionButton(
              child: Icon(cubit.facIcon),
              backgroundColor: Colors.teal,
              onPressed: () {
                if (cubit.isBottomSheetShown) {
                  if (formKey.currentState.validate()) {
                    cubit.insertToDatabase(
                        title: titleController.text,
                        time: timeController.text,
                        date: dateController.text);
                  }
                } else {
                  scaffoldKey.currentState
                      .showBottomSheet((context) {
                    return Container(
                      color: Colors.black,
                      child: Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(70),
                              topRight: Radius.circular(70)),
                          color: Colors.teal,
                        ),
                        padding: EdgeInsets.all(15),
                        child: Form(
                          key: formKey,
                          child: SingleChildScrollView(
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Title Must Not Be Empty !!!';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.text,
                                  controller: titleController,
                                  labelText: 'Task Title',
                                  prefix: Icons.title,
                                  labelColor: Colors.white,
                                  iconColor: Colors.white,
                                  focusedBorderRaduis: 25.0,
                                  focusdborderColor: Colors.white,
                                  fillcolor: Colors.grey,
                                  enabledBorderRaduis: 25.0,
                                  enabledBorderColor: Colors.white,
                                  cursorColor: Colors.white,
                                  borderRaduis: 25,
                                  borderColor: Colors.white,
                                  focusColor: Colors.white,
                                  errorBorderColor: Colors.white,
                                  errorBorderRaduis: 25.0,
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Time Must Not Be Empty !!!';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.datetime,
                                  controller: timeController,
                                  labelText: 'Task Time',
                                  prefix: Icons.watch_later_rounded,
                                  labelColor: Colors.white,
                                  iconColor: Colors.white,
                                  focusedBorderRaduis: 25.0,
                                  focusdborderColor: Colors.white,
                                  fillcolor: Colors.grey,
                                  enabledBorderRaduis: 25.0,
                                  enabledBorderColor: Colors.white,
                                  cursorColor: Colors.white,
                                  borderRaduis: 25,
                                  borderColor: Colors.white,
                                  focusColor: Colors.white,
                                  errorBorderColor: Colors.white,
                                  errorBorderRaduis: 25.0,
                                  onTap: () {
                                    showTimePicker(
                                        context: context,
                                        initialTime: TimeOfDay.now())
                                        .then((value) {
                                      timeController.text =
                                          value.format(context).toString();
                                    });
                                  },
                                ),
                                SizedBox(
                                  height: 20,
                                ),
                                defaultFormField(
                                  validate: (String value) {
                                    if (value.isEmpty) {
                                      return 'Date Must Not Be Empty !!!';
                                    }
                                    return null;
                                  },
                                  type: TextInputType.datetime,
                                  controller: dateController,
                                  labelText: 'Task Date',
                                  prefix: Icons.date_range_rounded,
                                  labelColor: Colors.white,
                                  iconColor: Colors.white,
                                  focusedBorderRaduis: 25.0,
                                  focusdborderColor: Colors.white,
                                  fillcolor: Colors.grey,
                                  enabledBorderRaduis: 25.0,
                                  enabledBorderColor: Colors.white,
                                  cursorColor: Colors.white,
                                  borderRaduis: 25,
                                  borderColor: Colors.white,
                                  focusColor: Colors.white,
                                  errorBorderColor: Colors.white,
                                  errorBorderRaduis: 25.0,
                                  onTap: () {
                                    showDatePicker(
                                      context: context,
                                      initialDate: DateTime.now(),
                                      firstDate: DateTime.now(),
                                      lastDate: DateTime.parse('2021-05-03'),
                                    ).then((value) {
                                      dateController.text =
                                          DateFormat.yMMMd().format(value);
                                    });
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    );
                  })
                      .closed
                      .then((value) {
                    cubit.BottomSheetState(icon: Icons.edit, isShow: false);

                   // cubit.isBottomSheetShown = false;
                  });
                  cubit.BottomSheetState(icon: Icons.add, isShow: true);
                  //cubit.isBottomSheetShown = false;

                }
              },
            ),
            bottomNavigationBar: BottomNavigationBar(
              items: [
                BottomNavigationBarItem(
                    icon: Icon(Icons.article), label: 'New Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.cloud_done_rounded), label: 'Done Tasks'),
                BottomNavigationBarItem(
                    icon: Icon(Icons.archive_rounded), label: 'Archived Tasks'),
              ],
              onTap: (int index) {
                cubit.changeIndex(index);
              },
              currentIndex: cubit.currentIndex,
              backgroundColor: Colors.teal,
              selectedItemColor: Colors.white,
            ),
          );
        }
      ),
    );
  }

}
