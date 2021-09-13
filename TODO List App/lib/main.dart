import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:my_first_app/layout/todo_app/todo_layout.dart';
import 'package:my_first_app/shared/bloc_observer.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/cubit/states.dart';
import 'package:my_first_app/shared/network/local/cache_helper.dart';
import 'package:my_first_app/shared/styles/themes.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  Bloc.observer = MyBlocObserver();
  await CacheHelper.init();

  runApp(MyApp());
}

class MyApp extends StatelessWidget
{
  MyApp();
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context)
  {
    return BlocProvider(
      create: (context) => AppCubit(),
      child: BlocConsumer<AppCubit,AppStates>(
        listener: (context,state) {},
        builder: (context,state)
        {
          return MaterialApp(
            debugShowCheckedModeBanner: false,
            home: Directionality(
                textDirection: TextDirection.ltr,
                child: HomeLayout(),
            ),
          );
        },
      ),
    );
  }
}
