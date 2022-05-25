import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:news_app/shared/bloc_observer.dart';
import 'package:news_app/shared/cubit/cubit.dart';
import 'package:news_app/shared/cubit/states.dart';
import 'package:news_app/shared/network/local/cache.helper.dart';
import 'package:news_app/shared/network/remote/dio_helper.dart';
import 'layout/news_app/news_layout.dart';

void main() async {

  // Ensure that all is done
  WidgetsFlutterBinding.ensureInitialized();

  DioHelper.init();
  await CacheHelper.init();

  bool? isDark = CacheHelper.getData(key: 'isDark');

  BlocOverrides.runZoned(
    () => runApp(MyApp(isDark: isDark!,)),
    blocObserver: MyBlocObserver(),
  );
}

class MyApp extends StatelessWidget {
  final bool isDark;

  const MyApp({Key? key, required this.isDark}) : super(key: key);



  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (BuildContext context) => AppCubit()..changeAppMode(fromShared: isDark),
      child: BlocConsumer<AppCubit, AppStates>(
        listener: (context, state) {},
        builder: (context, state) => MaterialApp(
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primarySwatch: Colors.deepOrange,
            scaffoldBackgroundColor: Colors.white,
            appBarTheme: const AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: Colors.white,
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: Colors.white,
                    statusBarIconBrightness: Brightness.dark),
                elevation: 0.0,
                titleTextStyle: TextStyle(
                    color: Colors.black,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.black)),
            floatingActionButtonTheme: const FloatingActionButtonThemeData(
              backgroundColor: Colors.deepOrange,
            ),
            bottomNavigationBarTheme: const BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: Colors.white,
            ),
            textTheme: const TextTheme(
                bodyText1: const TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.black)),
          ),
          darkTheme: ThemeData(
            scaffoldBackgroundColor: HexColor('333739'),
            primarySwatch: Colors.deepOrange,
            appBarTheme: AppBarTheme(
                titleSpacing: 20.0,
                backgroundColor: HexColor('333739'),
                systemOverlayStyle: SystemUiOverlayStyle(
                    statusBarColor: HexColor('333739'),
                    statusBarIconBrightness: Brightness.light),
                elevation: 0.0,
                titleTextStyle: const TextStyle(
                    color: Colors.white,
                    fontSize: 20.0,
                    fontWeight: FontWeight.bold),
                iconTheme: const IconThemeData(color: Colors.white)),
            bottomNavigationBarTheme: BottomNavigationBarThemeData(
              type: BottomNavigationBarType.fixed,
              selectedItemColor: Colors.deepOrange,
              unselectedItemColor: Colors.grey,
              elevation: 20.0,
              backgroundColor: HexColor('333739'),
            ),
            textTheme: const TextTheme(
                bodyText1: TextStyle(
                    fontSize: 18,
                    fontWeight: FontWeight.w600,
                    color: Colors.white)),
          ),
          themeMode:
              AppCubit.get(context).isDark ? ThemeMode.dark : ThemeMode.light,
          home: NewsLayout(),
        ),
      ),
    );
  }
}
