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