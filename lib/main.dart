import 'package:coffe_brain/cubit/naive_bayes/naive_bayes_proces_cubit.dart';
import 'package:coffe_brain/cubit/select_gejala_cubit.dart';
import 'package:coffe_brain/cubit/updown_cubit.dart';
import 'package:coffe_brain/ui/pages/diagnosis_page.dart';
import 'package:coffe_brain/ui/pages/diagnosis_value_page.dart';
import 'package:coffe_brain/ui/pages/menu_page.dart';
import 'package:coffe_brain/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
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
      builder: (context, child) => MultiBlocProvider(
        providers: [
          BlocProvider(create: (context) => UpdownCubit()),
          BlocProvider(create: (context) => SelectGejalaCubit()),
          BlocProvider(create: (context) => NaiveBayesProcesCubit()),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Splashscreen(),
            '/menu-utama': (context) => const Menuscreen(),
            '/diagnosis': (context) => const Diagnosisscreen(),
            '/diagnosis-value': (context) => const Diagnosisvalue(),
          },
        ),
      ),
    );
  }
}
