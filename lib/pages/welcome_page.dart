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
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            SvgPicture.asset(
              "assets/welcome.svg",
              width: screen.shortestSide,
              semanticsLabel: "Welcome illustration",
            ),
            RichText(
              text: TextSpan(
                text: "Welcome !\n",
                style: Theme.of(context).textTheme.headline1,
                children: [
                  TextSpan(
                    text: "Sign up or log in with the data that you entered during your registration !", 
                    style: Theme.of(context).textTheme.bodyText2
                  ),
                ],
              ),
            ),
            SizedBox(
              width: screen.shortestSide,
              child: CustomButton(
                onPressed: () => { Navigator.pushNamed(context, '/login') },
                text: "Log in / Sign up",
                textStyle: Theme.of(context).textTheme.headline5,
                startColor: mainLight,
                endColor: mainDark,
              ),
            ),
            /*SizedBox(
              width: screen.shortestSide,
              child: CustomButton(
                onPressed: () => { Navigator.pushNamed(context, '/signup') },
                text: "Sign up",
                textStyle: Theme.of(context).textTheme.bodyText1,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                borderColor: mainLight,
              ),
            ),
            Row(
              children: <Widget>[
                const Expanded(child: Divider(color: Colors.grey, thickness: 2)),
                Padding(
                  padding: EdgeInsets.symmetric(horizontal: 10, vertical: screen.shortestSide * 0.075),
                  child: Text("OR", style: Theme.of(context).textTheme.headline6),
                ),
                const Expanded(child: Divider(color: Colors.grey, thickness: 2)),
              ]
            ),*/
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: <Widget>[
                CustomButton(
                  onPressed: () => { },
                  onlyIcon: true,
                  borderColor: Colors.white,
                  backgroundColor: const Color(0xFF4267B2),
                  icon: FontAwesome.facebook,
                ),
                CustomButton(
                  onPressed: () => { },
                  onlyIcon: true,
                  borderColor: Colors.white,
                  backgroundColor: const Color(0xFFDB4437),
                  icon: FontAwesome.google,
                ),
                CustomButton(
                  onPressed: () => { },
                  onlyIcon: true,
                  borderColor: Colors.white,
                  backgroundColor: const Color(0xFF1DA1F2),
                  icon: FontAwesome.twitter,
                ),
              ]
            ),
          ],
        ),
      ),
    );
  }
}
