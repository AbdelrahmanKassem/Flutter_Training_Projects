import 'package:bloc/bloc.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_first_app/layout/news_app/cubit/states.dart';
import 'package:my_first_app/modules/news_app/business/business_screen.dart';
import 'package:my_first_app/modules/news_app/science/science_screen.dart';
import 'package:my_first_app/modules/news_app/sports/sports_screen.dart';
import 'package:my_first_app/shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit() : super(NewsInitState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int screensIndex = 0;

  List<Widget> screens = [
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
  ];

  List<BottomNavigationBarItem> bottomNavigationBarItems = [
    BottomNavigationBarItem(
      icon: Icon(
        Icons.business,
      ),
      label: 'Business',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.sports,
      ),
      label: 'Sports',
    ),
    BottomNavigationBarItem(
      icon: Icon(
        Icons.science,
      ),
      label: 'Science',
    ),
    /*BottomNavigationBarItem(
      icon: Icon(
        Icons.settings,
      ),
      label: 'Settings',
    ),*/
  ];

  void changeNavBarIndex(int index)
  {
    screensIndex = index;
    emit(NewsChangeNavBarState());
  }

  List<dynamic>? business;

  void getBusiness()
  {
    if(business == null || business!.length == 0)
      {
        emit(NewsGetBusinessLoadingState());
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'q':'Business',
            'from':'2021-08-14',
            'sortBy':'popularity',
            'apiKey':'a1a44e535b434affa7ab4cc380756717',
          },
        ).then((value){
          business = value.data['articles'];
          print(business![0]['title']);
          emit(NewsGetBusinessSuccessState());
        }).catchError((error){
          print('${error.toString()}');
          emit(NewsGetBusinessErrorState());
        });
      }
  }

  List<dynamic>? sports;

  void getSports()
  {
    if(sports == null || sports!.length == 0)
      {
        emit(NewsGetSportsLoadingState());
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'q':'Sports',
            'from':'2021-08-14',
            'sortBy':'popularity',
            'apiKey':'a1a44e535b434affa7ab4cc380756717',
          },
        ).then((value){
          sports = value.data['articles'];
          print(sports![0]['title']);
          emit(NewsGetSportsSuccessState());
        }).catchError((error){
          print('${error.toString()}');
          emit(NewsGetSportsErrorState());
        });
      }
  }

  List<dynamic>? science;

  void getScience()
  {
    if(science == null || science!.length == 0)
      {
        emit(NewsGetScienceLoadingState());
        DioHelper.getData(
          url: 'v2/top-headlines',
          query: {
            'q':'Science',
            'from':'2021-08-14',
            'sortBy':'popularity',
            'apiKey':'a1a44e535b434affa7ab4cc380756717',
          },
        ).then((value){
          science = value.data['articles'];
          print(science![0]['title']);
          emit(NewsGetScienceSuccessState());
        }).catchError((error){
          print('${error.toString()}');
          emit(NewsGetScienceErrorState());
        });
      }
  }

  List<dynamic>? search;

  void getSearch(String data)
  {
    search = [];
    emit(NewsGetSearchLoadingState());
    DioHelper.getData(
      url: 'v2/everything',
      query: {
        'q':'$data',
        'apiKey':'a1a44e535b434affa7ab4cc380756717',
      },
    ).then((value){
      search = value.data['articles'];
      emit(NewsGetSearchSuccessState());
    }).catchError((error){
      print('${error.toString()}');
      emit(NewsGetSearchErrorState());
    });
  }

}