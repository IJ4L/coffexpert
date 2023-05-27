import 'package:coffe_brain/services/history_service.dart';
import 'package:coffe_brain/ui/pages/diagnosis_page.dart';
import 'package:coffe_brain/ui/pages/history_page.dart';
import 'package:coffe_brain/ui/pages/splash_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cubit/history/history_cubit.dart';
import 'cubit/naive_bayes/naive_bayes_proces_cubit.dart';
import 'cubit/select_gejala_cubit.dart';
import 'cubit/updown_cubit.dart';
import 'ui/pages/diagnosis_value_page.dart';
import 'ui/pages/menu_page.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  runApp(MyApp(sharedPreferences: sharedPreferences));
}

class MyApp extends StatelessWidget {
  final SharedPreferences sharedPreferences;

  const MyApp({super.key, required this.sharedPreferences});

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
          BlocProvider(
            create: (context) => HistoryCubit(
              historyService: HistoryService(sharedPreferences),
            ),
          ),
        ],
        child: MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: '/',
          routes: {
            '/': (context) => const Splashscreen(),
            '/menu-utama': (context) => const Menuscreen(),
            '/diagnosis': (context) => const Diagnosisscreen(),
            '/diagnosis-value': (context) => const Diagnosisvalue(),
            '/history': (context) => const HistoryLoadedPage(),
          },
        ),
      ),
    );
  }
}
