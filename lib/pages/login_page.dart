import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/neumorphic_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        height: screen.height,
        child: SingleChildScrollView(
          child: Column(
            children: <Widget>[
              SizedBox(
                width: double.infinity,
                height: screen.shortestSide * 0.5,
                child: Neumorphic(
                  style: NeumorphicStyle(
                      boxShape:
                          NeumorphicBoxShape.path(BottomRoundedCorners())),
                  padding: const EdgeInsets.only(left: 20, top: 50),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text("Welcome back !",
                          textAlign: TextAlign.center,
                          style: themedStyle(
                              invert: !NeumorphicTheme.isUsingDark(context),
                              size: 42,
                              weight: FontWeight.bold,
                              color: mainLight)),
                      const SizedBox(height: 10),
                      Text(
                        "Log in and get started right now !",
                        style: themedStyle(
                            invert: !NeumorphicTheme.isUsingDark(context)),
                      ),
                    ],
                  ),
                ),
              ),
              Container(
                width: double.infinity,
                height: screen.longestSide - (screen.shortestSide * 0.5),
                padding: const EdgeInsets.all(10),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: <Widget>[
                    Align(
                      alignment: Alignment.centerLeft,
                      child: IconButton(
                          onPressed: () => {Navigator.pop(context)},
                          icon: Icon(
                            Icons.arrow_back_rounded,
                            size: 32,
                            color: mainLight,
                          )),
                    ),
                    Padding(
                      padding: const EdgeInsets.all(10),
                      child: Column(
                        children: [
                          NeumorphicInput(
                            hintLabel: "Email", 
                            editingController: emailController, 
                            prefixIcon: Icons.email_outlined,
                            suffixIcon: Icons.close_rounded
                          ),
                          SizedBox(height: screen.shortestSide * 0.1),
                          NeumorphicInput(
                            hintLabel: "Password", 
                            editingController: passwordController, 
                            prefixIcon: Icons.password_outlined, 
                            suffixIcon: Icons.close_rounded,
                            obscure: true
                          ),
                          SizedBox(height: screen.shortestSide * 0.1),
                          SizedBox(
                            width: screen.shortestSide,
                            child: NeumorphicButton(
                                onPressed: () =>
                                    {Navigator.pushNamed(context, '/home')},
                                style: NeumorphicStyle(
                                  surfaceIntensity: 1,
                                  color: mainLight,
                                  shape: NeumorphicShape.convex,
                                  boxShape: NeumorphicBoxShape.roundRect(
                                      BorderRadius.circular(50)),
                                ),
                                padding: const EdgeInsets.all(15),
                                child: Text(
                                  "Log in",
                                  textAlign: TextAlign.center,
                                  style: themedStyle(
                                      invert:
                                          NeumorphicTheme.isUsingDark(context),
                                      size: 24),
                                )),
                          ),
                        ],
                      ),
                    )
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
