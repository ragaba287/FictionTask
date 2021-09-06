import 'package:ahmed_ragab/cubit/homeStates.dart';
import 'package:ahmed_ragab/utils/const.dart';
import 'package:ahmed_ragab/views/start.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:ahmed_ragab/cubit/homeCubit.dart';
import 'package:ahmed_ragab/utils/cubitObserver.dart';
import 'package:ahmed_ragab/utils/sharedpreference.dart';
import 'package:ahmed_ragab/utils/style/theme.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Sharedpreference.init();
  Bloc.observer = MyBlocObserver();

  isDarkMode = await Sharedpreference.getData(key: 'isDarkMode') ?? false;

  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
            create: (BuildContext context) => HomeCubit()..getTotalPrice()),
      ],
      child: BlocConsumer<HomeCubit, HomeStates>(
        listener: (context, state) {},
        builder: (context, state) {
          return ScreenUtilInit(
              designSize: Size(360, 690),
              builder: () {
                SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
                  statusBarColor: Colors.transparent,
                  statusBarIconBrightness:
                      isDarkMode ? Brightness.light : Brightness.dark,
                ));
                return MaterialApp(
                  color: accentColor,
                  title: 'Ahmed Ragab',
                  theme: lightTheme,
                  darkTheme: darkTheme,
                  themeMode: isDarkMode ? ThemeMode.dark : ThemeMode.light,
                  home: StartScreen(),
                );
              });
        },
      ),
    );
  }
}
