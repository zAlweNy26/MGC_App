import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

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
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: PaddedScrollView(
          scrollPadding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                "assets/welcome.svg",
                width: screen.width,
                semanticsLabel: "Welcome illustration",
              ),
              SizedBox(height: screen.width * 0.05),
              RichText(
                text: TextSpan(
                  text: "Welcome !\n",
                  style: Theme.of(context).textTheme.headlineLarge,
                  children: [
                    TextSpan(
                      text: "Sign up or log in with the data that you entered during your registration !",
                      style: Theme.of(context).textTheme.bodyMedium
                    ),
                  ],
                ),
              ),
              SizedBox(height: screen.width * 0.05),
              CustomButton(
                onPressed: () => Navigator.pushNamed(context, '/login'),
                text: "Log in / Sign up",
                textStyle: Theme.of(context).textTheme.titleMedium,
                startColor: mainLight,
                endColor: mainDark,
              ),
              SizedBox(height: screen.width * 0.05),
              /*Row(
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
                    radius: 32,
                    backgroundColor: lighten(Theme.of(context).scaffoldBackgroundColor),
                    icon: const FaIcon(FontAwesomeIcons.facebookF, size: 28, color: Color(0xFF4267B2)),
                  ),
                  CustomButton(
                    onPressed: () => AdaptiveTheme.of(context).toggleThemeMode(),
                    onlyIcon: true,
                    radius: 32,
                    backgroundColor: lighten(Theme.of(context).scaffoldBackgroundColor),
                    icon: const FaIcon(FontAwesomeIcons.google, size: 28, color: Color(0xFFDB4437)),
                  ),
                  CustomButton(
                    onPressed: () => {},
                    onlyIcon: true,
                    radius: 32,
                    backgroundColor: lighten(Theme.of(context).scaffoldBackgroundColor),
                    icon: const FaIcon(FontAwesomeIcons.twitter, size: 28, color: Color(0xFF1DA1F2)),
                  ),
                ]
              ),
            ],
          ),
        ),
      ),
    );
  }
}
