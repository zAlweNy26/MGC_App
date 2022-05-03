import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/custom_input.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
import 'package:pinput/pinput.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _forgotKey = GlobalKey<FormState>();
  String email = "";
  bool emailSent = false, isResetting = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    final customPinTheme = PinTheme(
      width: 52,
      height: 56,
      textStyle: Theme.of(context).textTheme.titleMedium,
      decoration: BoxDecoration(
        color: Theme.of(context).backgroundColor,
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: PaddedScrollView(
            scrollPadding: const EdgeInsets.all(20),
            child: Form(
              key: _forgotKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: emailSent ? "Verification\n" : "Reset password\n",
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: [
                        TextSpan(
                            text: emailSent ? "Enter the code sent to the email you specified before." :
                                "Enter the email associated with your account and we will send an email with instructions to reset your password.",
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: screen.width * 0.05),
                  if (!emailSent) CustomInputField(
                    onSaved: (val) => email = val ?? "",
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    placeholder: "Email",
                  ),
                  if (!emailSent) SizedBox(height: screen.width * 0.05),
                  if (emailSent) SizedBox(
                    height: 68,
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: customPinTheme,
                      onCompleted: (pin) {
                        if (pin == "555555") {
                          setState(() => isResetting = true);
                        }
                      },
                      focusedPinTheme: customPinTheme.copyWith(
                        width: 68,
                        height: 64,
                        decoration: customPinTheme.decoration!.copyWith(
                          border: Border.all(color: mainLight, width: 2),
                        ),
                      ),
                    ),
                  ),
                  if (emailSent) SizedBox(height: screen.width * 0.05),
                  CustomButton(
                    onPressed: () {
                      if (_forgotKey.currentState!.validate() && !emailSent) {
                        _forgotKey.currentState!.save();
                        print("Email : $email");
                        setState(() => emailSent = true);
                      } else if (emailSent) { // mettere anche timer prima di poter reinviare il codice

                      }
                    },
                    text: emailSent ? "Send again" : "Send instructions",
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    startColor: mainLight,
                    endColor: mainDark,
                  ),
                  SizedBox(height: screen.width * 0.05),
                  SvgPicture.asset(
                    "assets/forgot_password.svg",
                    width: screen.width,
                    semanticsLabel: "Forgot password illustration",
                  ),
                ],
              ),
            )),
      ),
    );
  }
}
