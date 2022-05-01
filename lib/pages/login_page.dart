import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/custom_input.dart';
import 'package:flymeet/widgets/custom_switch.dart';
import 'package:intl/intl.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({Key? key}) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final TextEditingController firstNameController = TextEditingController();
  final TextEditingController lastNameController = TextEditingController();
  final TextEditingController birthdayController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  bool isRegistering = false, rememberLogin = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
        height: screen.height,
        width: screen.width,
        padding: const EdgeInsets.only(left: 20, top: 30, right: 20),
        child: SingleChildScrollView(
          child: Form(
              key: _loginKey,
              child: ConstrainedBox(
                constraints: BoxConstraints(maxHeight: screen.height - 30),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  crossAxisAlignment: CrossAxisAlignment.stretch,
                  children: [
                    SvgPicture.asset(
                      isRegistering
                          ? "assets/register.svg"
                          : "assets/login.svg",
                      width: screen.width,
                      semanticsLabel: isRegistering
                          ? "Register illustration"
                          : "Login illustration",
                    ),
                    RichText(
                      textAlign: TextAlign.center,
                      text: TextSpan(
                        text: isRegistering
                            ? "New account !\n"
                            : "Welcome back !\n",
                        style: Theme.of(context).textTheme.headlineLarge,
                        children: [
                          TextSpan(
                              text: isRegistering
                                  ? "Already have an account ?"
                                  : "Don't have an account ?",
                              style: Theme.of(context).textTheme.bodySmall),
                          TextSpan(
                              text: isRegistering
                                  ? " Log in now !"
                                  : " Sign in now !",
                              recognizer: TapGestureRecognizer()
                                ..onTap = () {
                                  setState(() {
                                    isRegistering = !isRegistering;
                                  });
                                },
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: mainLight,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                    CustomInputField(
                      inputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      placeholder: "Email",
                    ),
                    if (isRegistering)
                      Row(children: [
                        Expanded(
                            child: CustomInputField(
                          inputType: TextInputType.text,
                          placeholder: "First Name",
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        )),
                        SizedBox(width: screen.width * 0.05),
                        Expanded(
                            child: CustomInputField(
                          inputType: TextInputType.text,
                          placeholder: "Last Name",
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                        )),
                      ]),
                    if (isRegistering)
                      Row(children: [
                        Expanded(
                            child: CustomInputField(
                          controller: birthdayController,
                          inputType: TextInputType.none,
                          placeholder: "Birthday",
                          prefixIcon: Icons.event,
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          onTap: () async {
                            showPlatformDatePicker(
                              context: context,
                              initialDate: DateTime.now()
                                  .subtract(const Duration(days: 5840)),
                              firstDate: DateTime(1900),
                              lastDate: DateTime.now(),
                            ).then((value) {
                              if (value != null) {
                                birthdayController.text = DateFormat("dd/MM/yyyy").format(value);
                              }
                            });
                          },
                        )),
                        SizedBox(width: screen.width * 0.05),
                        Expanded(
                            child: Material(
                          shadowColor: Theme.of(context).backgroundColor,
                          elevation: 3,
                          color: Theme.of(context).scaffoldBackgroundColor,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(100)),
                          child: CountryCodePicker(
                            boxDecoration: BoxDecoration(
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                            hideSearch: true,
                            closeIcon: const Icon(Icons.close_rounded),
                            dialogSize: Size(screen.width, screen.height),
                            barrierColor: Colors.transparent,
                            padding: const EdgeInsets.all(0),
                            initialSelection: "IT",
                            onChanged: print,
                            showCountryOnly: true,
                            showOnlyCountryWhenClosed: true,
                            alignLeft: true,
                          ),
                        ))
                      ]),
                    Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        CustomInputField(
                          obscureText: true,
                          inputType: TextInputType.visiblePassword,
                          placeholder: "Password",
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          prefixIcon: Icons.password_outlined,
                        ),
                        if (isRegistering) const SizedBox(height: 5),
                        if (isRegistering) Text(
                          "The password must be minimum 8 characters long, with at least one uppercase letter, one lowercase letter, one number and one special character (@\$!%*?&)",
                          style: Theme.of(context).textTheme.labelSmall
                        ),
                      ]
                    ),
                    Row(
                      children: [
                        CustomSwitch(
                          isChecked: rememberLogin,
                          onChange: (v) => rememberLogin = v,
                          borderColor: mainLight,
                          selectedIconColor: mainLight,
                        ),
                        RichText(
                          text: TextSpan(
                            text: "Remember me",
                            style: Theme.of(context).textTheme.bodySmall,
                          ),
                        )
                      ],
                    ),
                    if (isRegistering)
                      Row(
                        children: [
                          CustomSwitch(
                            isChecked: rememberLogin,
                            onChange: (v) => rememberLogin = v,
                            borderColor: mainLight,
                            selectedIconColor: mainLight,
                          ),
                          RichText(
                            text: TextSpan(
                              text: "I have read and accept the",
                              style: Theme.of(context).textTheme.bodySmall,
                              children: [
                                TextSpan(
                                    text: " Privacy Policy",
                                    recognizer: TapGestureRecognizer()
                                      ..onTap = () =>
                                          print("Privacy Policy accepted"),
                                    style: Theme.of(context)
                                        .textTheme
                                        .bodySmall
                                        ?.copyWith(
                                            color: mainLight,
                                            fontWeight: FontWeight.bold)),
                              ],
                            ),
                          )
                        ],
                      ),
                    CustomButton(
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                        /*if (_loginKey.currentState!.validate()) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(content: Text('Processing Data')),
                          );
                        }*/
                      },
                      text: isRegistering ? "Sign up" : "Log in",
                      textStyle: Theme.of(context).textTheme.titleMedium,
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
