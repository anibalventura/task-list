import 'package:flutter/material.dart';
import 'package:flutter/scheduler.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:introduction_screen/introduction_screen.dart';
import 'package:task_list/data/cache/shared_pref.dart';
import 'package:task_list/ui/screens/task_list_screen.dart';
import 'package:task_list/ui/themes.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:task_list/utils/localizations.dart';

class IntroScreen extends StatefulWidget {
  const IntroScreen({Key? key}) : super(key: key);
  static const routeName = '/intro-screen';

  @override
  _IntroScreenState createState() => _IntroScreenState();
}

class _IntroScreenState extends State<IntroScreen> {
  late String _brightness;
  final String imageAssets = 'assets/images/intro_screen/';

  void _checkBrightness() {
    var platformBrightness =
        SchedulerBinding.instance!.window.platformBrightness;
    if (platformBrightness == Brightness.dark) {
      _brightness = 'night';
    } else {
      _brightness = 'light';
    }
  }

  void _finishIntro(BuildContext context) {
    Navigator.of(context).pushReplacementNamed(TaskListScreen.routeName);
    SharedPref().setBool('intro', true);
  }

  @override
  void initState() {
    _checkBrightness();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final pageDecoration = PageDecoration(
      pageColor: theme(context).backgroundColor,
      imagePadding: EdgeInsets.symmetric(horizontal: 0.05.sw),
      titleTextStyle: theme(context).textTheme.headline1!.copyWith(
            fontSize: isLandscape() ? 52.sp : 26.sp,
          ),
      bodyTextStyle: theme(context).textTheme.bodyText1!.copyWith(
            fontSize: Themes().headlineTextSize,
          ),
    );

    final textButtonStyle = theme(context).textTheme.bodyText2!.copyWith(
          fontSize: Themes().bodyTextSize,
        );

    return IntroductionScreen(
      showSkipButton: true,
      onSkip: () => _finishIntro(context),
      onDone: () => _finishIntro(context),
      skip: Text(
        translate(context, Texts.introSkip),
        style: textButtonStyle,
      ),
      done: Text(
        translate(context, Texts.introDone),
        style: textButtonStyle,
      ),
      next: Icon(
        FontAwesomeIcons.arrowRight,
        size: isLandscape() ? 0.025.sw : 0.05.sw,
        color: Colors.white,
      ),
      dotsContainerDecorator: BoxDecoration(
        color: theme(context).primaryColor,
        borderRadius: BorderRadius.circular(15.r),
      ),
      dotsDecorator: DotsDecorator(
        color: Colors.black26,
        activeColor: theme(context).accentColor,
        size: Size.square(
          isLandscape() ? 20.r : 10.r,
        ),
        activeSize: Size(
          isLandscape() ? 40.r : 20.r,
          isLandscape() ? 20.r : 10.r,
        ),
        spacing: EdgeInsets.symmetric(
          horizontal: isLandscape() ? 0.01.sw : 0.015.sw,
        ),
        activeShape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(30.r),
        ),
      ),
      pages: [
        PageViewModel(
          title: translate(context, Texts.introWelcomeTitle),
          body: translate(context, Texts.introWelcomeMsg),
          image: SvgPicture.asset(
            'assets/images/launcher/app_icon.svg',
            semanticsLabel: 'Task List App Icon',
            height: 0.3.sh,
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: translate(context, Texts.introEditTitle),
          body: translate(context, Texts.introEditMsg),
          image: Image(
            image: AssetImage('${imageAssets}swipe_edit_$_brightness.png'),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: translate(context, Texts.introDeleteTitle),
          body: translate(context, Texts.introDeleteMsg),
          image: Image(
            image: AssetImage('${imageAssets}swipe_delete_$_brightness.png'),
          ),
          decoration: pageDecoration,
        ),
        PageViewModel(
          title: translate(context, Texts.introPullRefreshTitle),
          body: translate(context, Texts.introPullRefreshMsg),
          image: Image(
            image: AssetImage('${imageAssets}pull_down_$_brightness.png'),
          ),
          decoration: pageDecoration,
        ),
      ],
    );
  }
}
