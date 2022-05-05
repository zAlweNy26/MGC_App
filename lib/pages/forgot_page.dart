import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/custom_input.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:pinput/pinput.dart';

class ForgotPage extends StatefulWidget {
  const ForgotPage({Key? key}) : super(key: key);

  @override
  State<ForgotPage> createState() => _ForgotPageState();
}

class _ForgotPageState extends State<ForgotPage> {
  final _forgotKey = GlobalKey<FormState>();
  String email = "", newPassword = "";
  bool emailSent = false, isResetting = false;

  Future<bool> _onWillPop() async {
    emailSent = false;
    return true;
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    final customPinTheme = PinTheme(
      width: 56,
      height: 60,
      textStyle: Theme.of(context).textTheme.headlineMedium,
      decoration: BoxDecoration(
        color: lighten(Theme.of(context).scaffoldBackgroundColor, 20),
        borderRadius: BorderRadius.circular(15),
        border: Border.all(color: Colors.transparent),
      ),
    );

    return WillPopScope(
      onWillPop: _onWillPop,
      child: Scaffold(
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
                  Align(
                    alignment: Alignment.centerLeft,
                    child: IconButton(
                      splashRadius: 24,
                      onPressed: () => print("pressed !"), 
                      icon: FaIcon(
                        FontAwesomeIcons.arrowLeftLong,
                        size: 24, 
                        color: Theme.of(context).backgroundColor
                      )
                    ),
                  ),
                  RichText(
                    textAlign: TextAlign.center,
                    text: TextSpan(
                      text: isResetting ? "Create new password\n" : (emailSent ? "Verification\n" : "Reset password\n"),
                      style: Theme.of(context).textTheme.headlineLarge,
                      children: [
                        TextSpan(
                            text: isResetting ? "Your new password must be different from previous used passwords." : 
                              (emailSent ? "Enter the 6-digit code sent to the email you specified before." :
                              "Enter the email associated with your account and we will send an email with instructions to reset your password."),
                            style: Theme.of(context).textTheme.bodyMedium),
                      ],
                    ),
                  ),
                  SizedBox(height: screen.width * 0.05),
                  if (!emailSent || isResetting) CustomInputField(
                    onSaved: (val) => isResetting ? newPassword = val ?? "" : email = val ?? "",
                    obscureText: isResetting,
                    inputType: isResetting ? TextInputType.visiblePassword : TextInputType.emailAddress,
                    prefixIcon: isResetting ? Icons.password_outlined : Icons.email_outlined,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    placeholder: isResetting ? "New Password" : "Email",
                  ),
                  if (isResetting) CustomInputField(
                    onSaved: (val) => print("Password : $val | $newPassword"),
                    obscureText: true,
                    inputType: TextInputType.visiblePassword,
                    prefixIcon: Icons.lock_rounded,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    placeholder: "Confirm Password",
                  ),
                  if (!emailSent) SizedBox(height: screen.width * 0.05),
                  if (emailSent && !isResetting) SizedBox(
                    height: 68,
                    child: Pinput(
                      length: 6,
                      defaultPinTheme: customPinTheme,
                      androidSmsAutofillMethod: AndroidSmsAutofillMethod.smsUserConsentApi,
                      animationCurve: Curves.easeInOut,
                      onCompleted: (pin) {
                        if (pin == "555555") {
                          print("validato !");
                          setState(() => isResetting = true);
                        }
                      },
                      focusedPinTheme: customPinTheme.copyWith(
                        width: 68,
                        height: 68,
                        decoration: customPinTheme.decoration!.copyWith(
                          border: Border.all(color: mainLight, width: 2),
                        ),
                      ),
                    ),
                  ),
                  if (emailSent) SizedBox(height: screen.width * 0.05),
                  CustomButton(
                    onPressed: () {
                      if (isResetting) {
                        print("aggiorna la password nel database");
                      } else if (_forgotKey.currentState!.validate() && !emailSent) {
                        _forgotKey.currentState!.save();
                        print("Email : $email");
                        setState(() => emailSent = true);
                      } else if (emailSent) { // mettere anche timer prima di poter reinviare il codice
    
                      }
                    },
                    text: isResetting ? "Confirm reset" : (emailSent ? "Send again" : "Send instructions"),
                    textStyle: Theme.of(context).textTheme.titleMedium,
                    startColor: mainLight,
                    endColor: mainDark,
                  ),
                  SizedBox(height: screen.width * 0.05),
                  SvgPicture.asset(
                    isResetting ? "assets/new_password.svg" : (emailSent ? "assets/new_email.svg" : "assets/forgot_password.svg"),
                    width: emailSent ? screen.width / 2 : screen.width,
                    semanticsLabel: isResetting ? "New password illustration" : (emailSent ? "Email sent illustration" : "Forgot password illustration")
                  ),
                ],
              ),
            )
          ),
        ),
      ),
    );
  }
}
