import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_list/cache/shared_pref.dart';
import 'package:task_list/controllers/task_controller.dart';
import 'package:task_list/screens/intro_screen.dart';
import 'package:task_list/screens/task_list_screen.dart';
import 'package:task_list/utils/localizations.dart';
import 'package:task_list/utils/themes.dart';

class TaskListApp extends StatelessWidget {
  const TaskListApp({
    Key? key,
  }) : super(key: key);

  Future<String> _showIntro() async {
    if (await SharedPref().getBool('intro')) {
      return TaskListScreen.routeName;
    } else {
      return IntroScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskController>(
          create: (_) => TaskController(),
        ),
      ],
      child: ScreenUtilInit(
        builder: () => FutureBuilder(
          future: _showIntro(),
          builder: (context, snapshot) {
            return MaterialApp(
              debugShowCheckedModeBanner: false,
              title: Texts.appName,
              theme: Themes.lightTheme,
              darkTheme: Themes.darkTheme,
              initialRoute: snapshot.data.toString(),
              routes: {
                IntroScreen.routeName: (_) => const IntroScreen(),
                TaskListScreen.routeName: (_) => const TaskListScreen(),
              },
              supportedLocales: const [
                Locale('en', ''),
                Locale('es', ''),
              ],
              localizationsDelegates: const [
                AppLocalizations.delegate,
                GlobalWidgetsLocalizations.delegate,
                GlobalMaterialLocalizations.delegate,
                GlobalCupertinoLocalizations.delegate,
              ],
              localeResolutionCallback:
                  (Locale? locale, Iterable<Locale> supportedLocales) {
                for (final supportedLocale in supportedLocales) {
                  if (supportedLocale.languageCode == locale!.languageCode ||
                      supportedLocale.countryCode == locale.countryCode) {
                    return supportedLocale;
                  }
                }
                return supportedLocales.first;
              },
            );
          },
        ),
      ),
    );
  }
}
