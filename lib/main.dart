import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/pages/signup_page.dart';
import 'package:flymeet/pages/welcome_page.dart';
import 'package:flymeet/pages/login_page.dart';
import 'package:page_transition/page_transition.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

void main() {
  //WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  runApp(const Main());
}

class Main extends StatelessWidget {
  const Main({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return NeumorphicApp(
      debugShowCheckedModeBanner: false,
      title: 'FlyMeet',
      themeMode: ThemeMode.light,
      theme: lightTheme,
      darkTheme: darkTheme,
      initialRoute: '/',
      onGenerateRoute: (settings) {
        switch (settings.name) {
          case '/':
            return PageTransition(child: const WelcomePage(), type: PageTransitionType.fade);
          case '/login':
            return PageTransition(child: const LoginPage(), type: PageTransitionType.fade);
          case '/signup':
            return PageTransition(child: const SignupPage(), type: PageTransitionType.fade);
          default:
            return null;
        }
      },
    );
  }
}