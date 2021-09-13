import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/cubit/states.dart';

class DoneTasksScreen extends StatelessWidget {
  const DoneTasksScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<AppCubit,AppStates>(
      listener: (context , state) {},
      builder: (context , state)
      {
        var databaseList = AppCubit.get(context).doneTasks;
        return defaultTaskBuilder (databaseList);
      },
    );
  }
}
