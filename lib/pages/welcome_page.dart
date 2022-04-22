import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';

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
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        child: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              SvgPicture.asset("assets/welcome.svg",
                width: screen.shortestSide,
                height: screen.shortestSide,
                semanticsLabel: 'Welcome Illustration'
              ),
              SizedBox(height: screen.height * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Welcome !", 
                    textAlign: TextAlign.center,
                    style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context), size: 42, weight: FontWeight.bold)
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sign up or log in with the data that you entered during your registration !",
                    style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context)),
                  ),
                ],
              ),
              SizedBox(height: screen.height * 0.1),
              Column(
                children: [
                  SizedBox(
                    width: screen.shortestSide,
                    child: NeumorphicButton(
                      onPressed: () => { Navigator.pushNamed(context, '/login') },
                      style: NeumorphicStyle(
                        surfaceIntensity: 1,
                        color: mainLight,
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Log in",
                        textAlign: TextAlign.center,
                        style: themedStyle(invert: NeumorphicTheme.isUsingDark(context), size: 24),
                      )
                    ),
                  ),
                  const SizedBox(height: 20),
                  SizedBox(
                    width: screen.shortestSide,
                    child: NeumorphicButton(
                      onPressed: () => { Navigator.pushNamed(context, '/signup') },
                      style: NeumorphicStyle(
                        border: NeumorphicBorder(
                          color: mainLight,
                          width: 2
                        ),
                        shape: NeumorphicShape.convex,
                        boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
                      ),
                      padding: const EdgeInsets.all(15),
                      child: Text(
                        "Sign up",
                        textAlign: TextAlign.center,
                        style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context), size: 24),
                      )
                    ),
                  )
                ],
              ),
            ],
          ),
        )
      ),
    );
  }
}
