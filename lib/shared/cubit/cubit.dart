import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache.helper.dart';

class AppCubit extends Cubit<AppStates>
{
  AppCubit() : super(AppInitialState());

  static AppCubit get(context) => BlocProvider.of(context);

  ThemeMode appMode = ThemeMode.dark;
  bool isDark = false;
  void changeAppMode({
    bool? fromShared})
  {
    if(fromShared !=null)
      {
        isDark=fromShared;
        emit(AppChangeModeState());
      }

    else
      {
        isDark = !isDark;
        CacheHelper.putData(key: 'isDark', value: isDark)?.then((value)
        {
          emit(AppChangeModeState());
        } );
      }


  }
}