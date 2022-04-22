import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flymeet/constants.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({Key? key}) : super(key: key);

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    
    return Scaffold(
      body: Column(
        children: <Widget>[
          SizedBox(
            width: screen.shortestSide,
            height: screen.shortestSide * 0.5,
            child: Neumorphic(
              style: NeumorphicStyle(
                surfaceIntensity: 1,
                boxShape: NeumorphicBoxShape.path(BottomRoundedCorners())
              ),
              padding: const EdgeInsets.only(left: 20, top: 50),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("New Account !", 
                    textAlign: TextAlign.center,
                    style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context), size: 42, weight: FontWeight.bold, color: mainLight)
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "Sign up and get started !",
                    style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context)),
                  ),
                ],
              ),
            ),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: <Widget>[
                Align(
                  alignment: Alignment.centerLeft,
                  child: IconButton(
                    onPressed: () => { Navigator.pop(context) }, 
                    icon: Icon(
                      Icons.arrow_back_rounded,
                      size: 32,
                      color: mainLight,
                    )
                  ),
                )
              ],
            ),
          )
        ],
      )
    );
  }
}
