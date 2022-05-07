import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/pages/home_page.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:page_transition/page_transition.dart';
import 'package:shared_preferences/shared_preferences.dart';
//import 'package:flutter_native_splash/flutter_native_splash.dart';

Future<void> main() async {
  final widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  //FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
  final packageInfo = await PackageInfo.fromPlatform();
  final savedThemeMode = await AdaptiveTheme.getThemeMode();
  final sharedPreferences = await SharedPreferences.getInstance();
  SystemChrome.setPreferredOrientations(
      [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]).then((_) {
    runApp(Main(
      sharedPreferences: sharedPreferences,
      savedThemeMode: savedThemeMode,
      packageInfo: packageInfo,
    ));
  });
}

class Main extends StatelessWidget {
  final SharedPreferences sharedPreferences;
  final AdaptiveThemeMode? savedThemeMode;
  final PackageInfo? packageInfo;

  const Main(
      {Key? key,
      required this.sharedPreferences,
      this.savedThemeMode,
      this.packageInfo})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdaptiveTheme(
        light: lightTheme,
        dark: darkTheme,
        initial: savedThemeMode ?? AdaptiveThemeMode.system,
        builder: (light, dark) => PlatformApp(
              localizationsDelegates: const [
                DefaultMaterialLocalizations.delegate,
                DefaultWidgetsLocalizations.delegate,
                DefaultCupertinoLocalizations.delegate,
              ],
              debugShowCheckedModeBanner: false,
              title: 'MG Clinic',
              initialRoute: '/',
              onGenerateRoute: (settings) {
                switch (settings.name) {
                  case '/':
                    return PageTransition(child: const HomePage(), type: PageTransitionType.fade);
                  default:
                    return null;
                }
              },
              material: (_, __) => MaterialAppData(
                theme: light,
                darkTheme: dark,
              ),
              cupertino: (_, __) => CupertinoAppData(
                theme: MaterialBasedCupertinoThemeData(materialTheme: light),
              ),
            ));
  }
}
