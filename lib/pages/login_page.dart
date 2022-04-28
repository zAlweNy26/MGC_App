import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/custom_input.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  bool isRegistering = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 30),
        child: SingleChildScrollView(
          child: Form(
              key: _loginKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screen.longestSide - 60),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      isRegistering ? "assets/register.svg" : "assets/login.svg",
                      width: screen.shortestSide,
                      semanticsLabel: isRegistering ? "Register illustration" : "Login illustration",
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: isRegistering ? "New account !\n" : "Welcome back !\n",
                        style: Theme.of(context).textTheme.headline1,
                        children: [
                          TextSpan(
                              text: isRegistering ? "Already have an account ?" : "Don't have an account ?",
                              style: Theme.of(context).textTheme.bodyText2),
                          TextSpan(
                              text: isRegistering ? " Log in now !" : " Sign in now !",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isRegistering = !isRegistering;
                                  });
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodyText2
                                  ?.copyWith(
                                      color: mainLight,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    CustomInputField(
                      width: screen.shortestSide,
                      inputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      placeholder: "Email",
                    ),
                    if (isRegistering) Row(
                      children: <Widget>[
                        CustomInputField(
                          width: screen.shortestSide / 2.5,
                          obscureText: true,
                          inputType: TextInputType.text,
                          placeholder: "First Name"
                        ),
                        const Spacer(),
                        CustomInputField(
                          width: screen.shortestSide / 2.5,
                          obscureText: true,
                          inputType: TextInputType.text,
                          placeholder: "Last Name"
                        ),
                      ]
                    ),
                    CustomInputField(
                      width: screen.shortestSide,
                      obscureText: true,
                      inputType: TextInputType.visiblePassword,
                      placeholder: "Password",
                      prefixIcon: Icons.password_outlined,
                    ),
                    CustomButton(
                      onPressed: () {
                        if (_loginKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }
                      },
                      text: isRegistering ? "Sign up" : "Log in",
                      textStyle: Theme.of(context).textTheme.headline5,
                      startColor: mainLight,
                      endColor: mainDark,
                    ),
                  ],
                ),
              )),
        ),
      ),
    );
  }
}
