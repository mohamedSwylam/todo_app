import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sqflite/sqflite.dart';
import 'package:todo/modules/archived/arcived_tasks_screen.dart';
import 'package:todo/modules/done/done_tasks_screen.dart';
import 'package:todo/modules/new/new_tasks_screen.dart';
import 'package:todo/shared/cubit/states/states.dart';

class AppCubit extends Cubit<AppState> {
  AppCubit(AppState initialState) : super(initialState);
  static AppCubit get(context) => BlocProvider.of(context);
  int currentIndex = 0;
  List <Map> newtasks=[];
  List <Map> donetasks=[];
  List <Map> archivedtasks=[];
  bool isBottomSheetShown = false;
  IconData facIcon = Icons.edit;
  List<Widget> screens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchivedTasksScreen(),
  ];


  List<String> titles = [
    'New Tasks',
    'Done Tasks',
    'Archived Tasks',
  ];
  void BottomSheetState({
    @required IconData icon,
    @required bool isShow,
  }){
    facIcon =icon;
    isBottomSheetShown=isShow;
    emit(AppBottomSheetState());
  }
  void changeIndex(index) {
    currentIndex = index;
     emit(AppBottomSheetNavigationBar());
  }
  Database database;
  insertToDatabase({
    @required String title,
    @required String time,
    @required String date,
  }) async
  {
    await database.transaction((txn) {
      txn
          .rawInsert(
          'INSERT INTO tasks(title, date, time, status) VALUES("$title","$date","$time","new")')
          .then((value) {
        print('$value inserted succefully');
        emit(AppInsertToDataBase());
        getDataFromDatabase(database);
      }).catchError((error) {
        print('Error when inserting new Record ${error.toString()}');
      });
      return null;
    });
  }

  void getDataFromDatabase(database) {
    newtasks = [];
    donetasks = [];
    archivedtasks = [];
    //emit(AppGetDatabaseLoadingState());
    database.rawQuery('SELECT * FROM tasks').then((value) {
      value.forEach((element) {
        if (element['status'] == 'new')
          newtasks.add(element);
        else if (element['status'] == 'done')
          donetasks.add(element);
        else
          archivedtasks.add(element);
      });
      emit(AppGetDatabase());
    });
  }

  void createDatabase() {
    openDatabase('todo.db', version: 1, onCreate: (database, version) {
      print('database created');
      database
          .execute(
          'CREATE TABLE tasks (id INTEGER PRIMARY KEY , title TEXT , date TEXT , time TEXT , status TEXT )')
          .then((value) {
        print('table created');
      }).catchError((error) {
        print('Error when Creating Table ${error.toString()}');
      });
    }, onOpen: (database) {
      getDataFromDatabase(database);
      print('database opened');
    }).then((value) {
      database = value;
      emit(AppCreateDatabase());
    });
  }
  void deleteDatebase({
    @required int id,
  }) async {
    database.rawDelete(
      'DELETE FROM tasks WHERE id = ?',
      [id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppDeleteDataBase());
    });
  }
  void updateDatabase({
    @required String status,
    @required int id,
  }) async {
    database.rawUpdate(
      'UPDATE tasks SET status = ? WHERE id = ?',
      ['$status', id],
    ).then((value) {
      getDataFromDatabase(database);
      emit(AppUpdateDataBase());
    });
  }
}