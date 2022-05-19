import 'package:device_preview/device_preview.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:moviedb/detail_page/screen/detailmovie_screen.dart';
import 'package:moviedb/home_page/screen/home_screen.dart';

void main() {
  runApp(DevicePreview(enabled: !kReleaseMode, builder: (context) => MyApp()));
}

// DevicePreview(enabled: !kReleaseMode, builder: (context) =>
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      useInheritedMediaQuery: true,
      locale: DevicePreview.locale(context),
      builder: DevicePreview.appBuilder,
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      debugShowCheckedModeBanner: false,
      initialRoute: '/',
      // routes: {
      //   '/home': (context) => const HomeScreen(),
      //   '/detail': (context) => DetailMovieScreen(id: ,),
      // },
      home: const HomeScreen(),
    );
  }
}
