import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:provider/provider.dart';
import 'package:task_list/data/cache/shared_pref.dart';
import 'package:task_list/data/controllers/task_controller.dart';
import 'package:task_list/ui/screens/intro_screen.dart';
import 'package:task_list/utils/localizations.dart';
import 'package:task_list/utils/http_overrides.dart';
import 'package:task_list/ui/screens/task_list_screen.dart';
import 'package:task_list/ui/themes.dart';

void main() async {
  // Returns an instance of the WidgetsBinding, creating and initializing.
  WidgetsFlutterBinding.ensureInitialized();

  // Handle the HandshakeException: CERTIFICATE_VERIFY_FAILED.
  HttpOverrides.global = MyHttpOverrides();

  // Load environment variables.
  await dotenv.load(fileName: 'assets/.env');

  runApp(
    // Init app with providers for controllers.
    MultiProvider(
      providers: [
        ChangeNotifierProvider<TaskController>(
          create: (_) => TaskController(),
        ),
      ],
      // Init ScreenUtils for dynamic sizes.
      child: ScreenUtilInit(
        builder: () => const TaskListApp(),
      ),
    ),
  );
}

class TaskListApp extends StatelessWidget {
  const TaskListApp({
    Key? key,
  }) : super(key: key);

  Future<String> _showIntro() async {
    // TODO: Correct key after finish intro UI.
    if (await SharedPref().getBool('intr')) {
      return TaskListScreen.routeName;
    } else {
      return IntroScreen.routeName;
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
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
    );
  }
}
