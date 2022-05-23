import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/layout/news_app/cubit/states.dart';
import 'package:news_app/modules/business/business_screen.dart';
import 'package:news_app/modules/science/science_screen.dart';
import 'package:news_app/modules/sports/sports_screen.dart';

import '../../../modules/settings/settings_screen.dart';
import '../../../shared/network/remote/dio_helper.dart';

class NewsCubit extends Cubit<NewsStates>
{
  NewsCubit():super(NewsInitialState());

  static NewsCubit get(context) => BlocProvider.of(context);

  int currentIndex=0;
  List<BottomNavigationBarItem> bottomItems=[
    BottomNavigationBarItem(
        icon: Icon(Icons.business),
      label: 'Business'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.sports),
        label: 'Sports'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.science),
        label: 'Science'
    ),
    BottomNavigationBarItem(
        icon: Icon(Icons.settings),
        label: 'Settings'
    ),
  ];

  List<Widget> screens=[
    BusinessScreen(),
    SportsScreen(),
    ScienceScreen(),
    SettingsScreen()
  ];

  void changeBottomNavBar(int index)
  {
    currentIndex = index;
    emit(NewsBottomNavState());
  }

  List<dynamic> business =[];

  void getBusiness()
  {
    emit(NewsGetBusinessLoadingState());
   DioHelper.getData(
     url: 'v2/top-headlines',
     query:
     {
       'country':'eg',
       'category':'business',
       'apiKey':'2e367227a3ba4e198a3b2e94a168a444',
     },
   ).then((value)
   {
     print(value);
     business = value?.data['articles'];
     print(business.length);
     emit(NewsGetBusinessSuccessState());
   }).catchError((Error)
   {
     print(Error.toString());
     emit(NewsGetBusinessErrorState(Error.toString()));

   });
  }

  List<dynamic> sports =[];

  void getSports()
  {
    emit(NewsGetSportsLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'sports',
        'apiKey':'2e367227a3ba4e198a3b2e94a168a444',
      },
    ).then((value)
    {
      print(value);
      sports = value?.data['articles'];
      print(sports.length);
      emit(NewsGetSportsSuccessState());
    }).catchError((Error)
    {
      print(Error.toString());
      emit(NewsGetSportsErrorState(Error.toString()));

    });
  }

  List<dynamic> science =[];

  void getScience()
  {
    emit(NewsGetScienceLoadingState());
    DioHelper.getData(
      url: 'v2/top-headlines',
      query:
      {
        'country':'eg',
        'category':'science',
        'apiKey':'2e367227a3ba4e198a3b2e94a168a444',
      },
    ).then((value)
    {
      print(value);
      science = value?.data['articles'];
      print(science.length);
      emit(NewsGetScienceSuccessState());
    }).catchError((Error)
    {
      print(Error.toString());
      emit(NewsGetScienceErrorState(Error.toString()));

    });
  }
}