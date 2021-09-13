import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/components/constants.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/cubit/states.dart';
import 'package:sqflite/sqflite.dart';
import 'package:intl/intl.dart';
import 'package:conditional_builder/conditional_builder.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';

class HomeLayout extends StatelessWidget
{


  var scaffoldKey = GlobalKey<ScaffoldState>();
  var formKey = GlobalKey<FormState>();


  var titleController = TextEditingController();
  var dateController = TextEditingController();
  var timeController = TextEditingController();


  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..createDataBase(),
      child: BlocConsumer <AppCubit , AppStates>(
        listener: (context , state)
        {
          if(state is AppInsertToDatabaseState)
            {
              Navigator.pop(context);
            }
        },
        builder: (context , state)
        {
          AppCubit cubit = AppCubit.get(context);
          return Scaffold(
            key: scaffoldKey,
            floatingActionButton: FloatingActionButton(
              child: Icon(
                cubit.floatingButtonIcon,
              ),
              onPressed: ()
              {
                if(cubit.bottomSheetShown)
                {
                  if(formKey.currentState!.validate())
                  {
                    cubit.insertToDataBase(titleController.text , dateController.text, timeController.text);
                    cubit.changeBottomSheetState(bottomSheetShownFlag: false, floatingButtonIconPassed: Icons.edit_rounded);
                  }
                }
                else
                {

                  cubit.changeBottomSheetState(bottomSheetShownFlag: true, floatingButtonIconPassed: Icons.save_rounded);
                  scaffoldKey.currentState!.showBottomSheet(
                        (context) => Form(
                      key: formKey,
                      child: Container(
                        padding: EdgeInsets.all(13),
                        child: Column(
                          mainAxisSize: MainAxisSize.min,
                          children: [
                            defaultTextFormField(
                              prefixIcon: Icons.title,
                              controller: titleController,
                              keyboardType: TextInputType.text,
                              lableText: 'TITLE',
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Title must not be emply.';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaultTextFormField(
                              readOnly: true,
                              prefixIcon: Icons.watch_later_outlined,
                              controller: timeController,
                              keyboardType: TextInputType.text,
                              lableText: 'TIME',
                              onTap: ()
                              {
                                showTimePicker(
                                  context: context,
                                  initialTime: TimeOfDay.now(),
                                ).then((value)
                                {
                                  timeController.text = value!.format(context);

                                }
                                );
                              },
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Time must not be empty.';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                            ),
                            SizedBox(
                              height: 8,
                            ),
                            defaultTextFormField(
                              readOnly: true,
                              prefixIcon: Icons.date_range_outlined,
                              controller: dateController,
                              keyboardType: TextInputType.text,
                              lableText: 'DATE',
                              onTap: ()
                              {
                                showDatePicker(
                                  context: context,
                                  initialDate: DateTime.now(),
                                  firstDate: DateTime.now(),
                                  lastDate: DateTime(2030),
                                ).then((value)
                                {
                                  dateController.text = DateFormat.yMMMd().format(value!).toString();
                                });
                              },
                              validator: (String? value)
                              {
                                if(value!.isEmpty)
                                {
                                  return 'Date must not be emply.';
                                }
                                else
                                {
                                  return null;
                                }
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ).closed.then((value)
                    {
                      cubit.changeBottomSheetState(bottomSheetShownFlag: false, floatingButtonIconPassed: Icons.edit_rounded);
                    }
                  );
                }
                print(cubit.newTasks!.length);
              },
            ),
            appBar: AppBar(
              title: Text(
                cubit.appBarTitle[cubit.screenIndex],
              ),
              centerTitle: true,
            ),
            body: ConditionalBuilder(
              //condition: databaseList!.length > 0,
              condition: state is! AppLoadingState,
              builder: (context) => cubit.bodyScreens[cubit.screenIndex],
              fallback: (context) => Center(child: CircularProgressIndicator()),
            ),

            bottomNavigationBar: BottomNavigationBar(
              onTap: (value){
                cubit.changeNavBarState(value);
              },
              items: [
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.menu,
                  ),
                  label: 'New',
                ),
                BottomNavigationBarItem(
                  icon: Icon(
                    Icons.check_circle_outline,
                  ),
                  label: 'Done',
                ),
                BottomNavigationBarItem(
                    icon: Icon(
                      Icons.archive,
                    ),
                    label: 'Achieved'
                ),
              ],
              currentIndex: cubit.screenIndex,
            ),
          );
        },
      ),
    );
  }

  Future<String> printstr() async
  {
    return 'Kassem';
  }

}
