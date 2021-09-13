import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/cubit.dart';
import 'package:my_first_app/modules/news_app/search/search_screen.dart';
import 'package:my_first_app/shared/components/components.dart';
import 'package:my_first_app/shared/cubit/cubit.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

import 'cubit/states.dart';




class NewsLayout extends StatelessWidget
{
  @override
  Widget build(BuildContext context) {
    return BlocConsumer<NewsCubit,NewsStates>(
      listener: (context,state) {

      },
      builder: (context,state){
        NewsCubit cubit = NewsCubit.get(context);
        return Scaffold(
          appBar: AppBar(
            title: Text('News App'),
            actions: [
              IconButton(
                onPressed: (){
                  navigateTo(context, SearchScreen());
                },
                icon: Icon(
                  Icons.search,
                ),
              ),
              IconButton(
                onPressed: (){
                  AppCubit.get(context).changeAppTheme();
                },
                icon: Icon(
                  Icons.dark_mode,
                ),
              ),
            ],
          ),
          bottomNavigationBar: BottomNavigationBar(
            enableFeedback: true,
            showUnselectedLabels: true,
            onTap: (index){
              cubit.changeNavBarIndex(index);
            },
            items: cubit.bottomNavigationBarItems,
            currentIndex: cubit.screensIndex,
          ),
          body: cubit.screens[cubit.screensIndex],
        );
      },
    );
  }

}