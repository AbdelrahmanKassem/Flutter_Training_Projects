import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
//import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/states.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:sqflite/sqflite.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitState());

  static AppCubit get(context) => BlocProvider.of(context);

  int screenIndex = 0;

  late Database database;

  List<Map>? newTasks;
  List<Map>? doneTasks;
  List<Map>? archivedTasks;

  List<String> appBarTitle = [
    'New Tasks',
    'Done Tasks',
    'Achieved Tasks',
  ];
/*  List<Widget> bodyScreens = [
    NewTasksScreen(),
    DoneTasksScreen(),
    ArchievedTasksScreen(),
  ];*/

  void createDataBase()
  {
    emit(AppLoadingState());
    //deleteDatabase('Todo.db');
    openDatabase(
      'Todo.db',
      version: 1,
      onCreate: (database , version) async
      {
        // When creating the db, create the table
        await database.execute(
            'CREATE TABLE Tasks (id INTEGER PRIMARY KEY, title TEXT, date TEXT, time TEXT , status TEXT)'
        ).then((value)
        {
          print('Table Created.');
        }).catchError((error)
        {
          print('Error in Table Creation: ${error.toString()}.');
        });
      },
      onOpen: (database)
      {
        getFromDataBase(database);
        print('Database Opened');
      },
    ).then((value)
    {
      database = value;
      emit(AppCreateDatabaseState());
    });
  }

  void insertToDataBase(String title, String date,String time) async
  {
    // Insert some records in a transaction
    await database.transaction((txn) async
    {
      int id1 = await txn.rawInsert(
          'INSERT INTO Tasks (title, date, time , status) VALUES("$title","$date", "$time" , "NEW")');
      print("data inserted into id: $id1");
    });
    emit(AppInsertToDatabaseState());
    getFromDataBase(database);
  }

  void getFromDataBase(database) async
  {
    newTasks = [];
    doneTasks = [];
    archivedTasks = [];

    emit(AppLoadingState());
    database.rawQuery('SELECT * FROM Tasks').then((value)
    {
      value.forEach((element)
      {
        if(element['status'] == "NEW")
          {
            if(newTasks == null)
            {
              newTasks = [element];
            }
            else
            {
              newTasks!.add(element);
            }
          }
        else if(element['status'] == "DONE")
          if(doneTasks == null)
          {
            doneTasks = [element];
          }
          else
          {
            doneTasks!.add(element);
          }
        else if(element['status'] == "ARCHIVED")
          if(archivedTasks == null)
          {
            archivedTasks = [element];
          }
          else
          {
            archivedTasks!.add(element);
          }
      });
      //databaseList = value;
      emit(AppGetFromDatabaseState());
    }
    );
  }

  void updateDataBase ({
    required int id,
    required String status,
  }) async
  {
    // Update some record
    await database.rawUpdate(
        'UPDATE Tasks SET status = ? WHERE id = ?',
        ['$status', id]);
    getFromDataBase(database);
    emit(AppUpdateDatabaseState());
  }

  void deleteFromDataBase ({
    required int id,
  }) async
  {
    // Delete a record
    await database.rawDelete('DELETE FROM Tasks WHERE id = ?', [id]);
    getFromDataBase(database);
    emit(AppDeleteDatabaseState());
  }

  void changeNavBarState (int index)
  {
    screenIndex = index;
    emit(AppChangeNavBarState());
  }

  IconData floatingButtonIcon = Icons.edit_rounded;
  bool bottomSheetShown = false;

  void changeBottomSheetState ({
    required bool bottomSheetShownFlag,
    required IconData floatingButtonIconPassed
  })
  {
    floatingButtonIcon = floatingButtonIconPassed;
    bottomSheetShown = bottomSheetShownFlag;
    emit(AppChangeBottomSheetState());
  }

  //news app
  //bool isDark = CacheHelper.getBool(key: 'isDark') ?? false;

  //shop app
  bool isDark = false;

  void changeAppTheme()
  {
    isDark = !isDark;
    CacheHelper.putBool(key: 'isDark', value: isDark).then(
        (bool)
        {
          emit(NewsChangeAppThemeState());
        }
    );
  }
}