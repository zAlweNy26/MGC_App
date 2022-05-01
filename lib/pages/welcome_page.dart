import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
// ignore: import_of_legacy_library_into_null_safe
import 'package:flutter_icons/flutter_icons.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';

class WelcomePage extends StatefulWidget {
  const WelcomePage({Key? key}) : super(key: key);

  @override
  State<WelcomePage> createState() => _WelcomePageState();
}

class _WelcomePageState extends State<WelcomePage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: screen.height,
          width: screen.width,
          padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
          child: SingleChildScrollView(
              child: ConstrainedBox(
            constraints: BoxConstraints(maxHeight: screen.height - 30),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: <Widget>[
                SvgPicture.asset(
                  "assets/welcome.svg",
                  width: screen.width,
                  semanticsLabel: "Welcome illustration",
                ),
                RichText(
                  text: TextSpan(
                    text: "Welcome !\n",
                    style: Theme.of(context).textTheme.headlineLarge,
                    children: [
                      TextSpan(
                          text:
                              "Sign up or log in with the data that you entered during your registration !",
                          style: Theme.of(context).textTheme.bodySmall),
                    ],
                  ),
                ),
                CustomButton(
                  onPressed: () => Navigator.pushNamed(context, '/login'),
                  text: "Log in / Sign up",
                  width: screen.width,
                  textStyle: Theme.of(context).textTheme.titleMedium,
                  startColor: mainLight,
                  endColor: mainDark,
                ),
                /*SizedBox(
                  width: screen.width,
                  child: CustomButton(
                    onPressed: () => Navigator.pushNamed(context, '/signup'),
                    text: "Sign up",
                    textStyle: Theme.of(context).textTheme.bodyMedium,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    borderColor: mainLight,
                  ),
                ),
                Row(
                  children: <Widget>[
                    const Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                    Padding(
                      padding: EdgeInsets.symmetric(horizontal: 10, vertical: screen.width * 0.075),
                      child: Text("OR", style: Theme.of(context).textTheme.titleSmall),
                    ),
                    const Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                  ]
                ),*/
                Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      CustomButton(
                        onPressed: () => {},
                        onlyIcon: true,
                        icon: const Icon(FontAwesome.facebook,
                            color: Color(0xFF4267B2)),
                      ),
                      CustomButton(
                        onPressed: () =>
                            {AdaptiveTheme.of(context).toggleThemeMode()},
                        onlyIcon: true,
                        icon: const Icon(FontAwesome.google,
                            color: Color(0xFFDB4437)),
                      ),
                      CustomButton(
                        onPressed: () => {},
                        onlyIcon: true,
                        icon: const Icon(FontAwesome.twitter,
                            color: Color(0xFF1DA1F2)),
                      ),
                    ]),
              ],
            ),
          ))),
    );
  }
}
