import 'package:coffe_brain/ui/pages/menu_page.dart';
import 'package:coffe_brain/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(360, 690),
      minTextAdapt: true,
      splitScreenMode: true,
      builder: (context, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: 'First Method',
          initialRoute: '/',
          routes: {
            '/': (context) => const Splashscreen(),
            '/menu-utama': (context) => const Menuscreen(),
          },
        );
      },
    );
  }
}
