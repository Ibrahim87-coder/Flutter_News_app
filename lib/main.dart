
import 'package:bloc/bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_layout.dart';

void main() {
  BlocOverrides.runZoned(
        ()=>runApp(const MyApp()),
    blocObserver: MyBlocObserver(),
  );

  DioHelper.init();

}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepOrange,
        scaffoldBackgroundColor: Colors.white,
        appBarTheme: const AppBarTheme(
          backgroundColor: Colors.white,
          systemOverlayStyle: SystemUiOverlayStyle(
            statusBarColor: Colors.white,
            statusBarIconBrightness: Brightness.dark
          ),
          elevation: 0.0,
          titleTextStyle: TextStyle(
            color: Colors.black,
            fontSize: 20.0,
            fontWeight: FontWeight.bold
          ),
            iconTheme: const IconThemeData(color: Colors.black)
        ),
        bottomNavigationBarTheme: const BottomNavigationBarThemeData(
          type:BottomNavigationBarType.fixed ,
          selectedItemColor: Colors.deepOrange,
          elevation: 20.0,

        ),
      ),
      darkTheme: ThemeData(),
      themeMode: ThemeMode.light,
      home: const NewsLayout(),
      );
  }
}
