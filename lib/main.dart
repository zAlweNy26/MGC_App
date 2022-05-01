import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/pages/home_page.dart';
import 'package:flymeet/pages/welcome_page.dart';
import 'package:flymeet/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Main(savedThemeMode: savedThemeMode));
  });
}

class Main extends StatelessWidget {
  final AdaptiveThemeMode? savedThemeMode;

  const Main({Key? key, this.savedThemeMode}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
      light: lightTheme,
      dark: darkTheme,
      initial: savedThemeMode ?? AdaptiveThemeMode.light,
      builder: (lightTheme, darkTheme) => MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'FlyMeet',
        theme: lightTheme,
        darkTheme: darkTheme,
        initialRoute: '/',
        onGenerateRoute: (settings) {
          switch (settings.name) {
            case '/':
              return PageTransition(
                  child: const WelcomePage(), type: PageTransitionType.fade);
            case '/login':
              return PageTransition(
                  child: const LoginPage(), type: PageTransitionType.fade);
            case '/home':
              return PageTransition(
                  child: const HomePage(), type: PageTransitionType.fade);
            default:
              return null;
          }
        },
      ),
    );
  }
}
