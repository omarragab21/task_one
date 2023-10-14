// ignore_for_file: unused_local_variable, avoid_print

import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

import 'package:provider/provider.dart';

import 'package:task_one/app/questions_cycle/providers/question_provider.dart';
import 'package:task_one/app/questions_cycle/views/root_screen.dart';
import 'package:task_one/services/local_services/sqlite_db.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  LocalDataBase().database;
  var db = await LocalDataBase().database;
  print(db.path);
  await LocalDataBase().getData();
  print('Load database success');

  runApp(MultiProvider(
      providers: [ChangeNotifierProvider(create: (_) => QuestionProvider())],
      child: const MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: Size(MediaQuery.sizeOf(context).width, MediaQuery.sizeOf(context).width),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (_, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          builder: (context, widget) {
            return MediaQuery(
              // If there is no context available you can wrap [MediaQuery] with [Builder]
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget!,
            );
          },
          title: 'Task One',
          theme: ThemeData(
            primarySwatch: Colors.blue,
            textTheme: Typography.englishLike2018.apply(fontSizeFactor: 1.sp),
          ),
          home: child,
        );
      },
      child: const RootScreen(),
    );
  }
}
