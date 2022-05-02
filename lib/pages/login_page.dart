import 'package:bottom_picker/bottom_picker.dart';
import 'package:country_code_picker/country_code_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/widgets/custom_button.dart';
import 'package:flymeet/widgets/custom_input.dart';
import 'package:flymeet/widgets/custom_switch.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
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
  final TextEditingController birthDateController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();

  CountryCode countryCode = CountryCode.fromCountryCode("IT");

  bool isRegistering = false, rememberLogin = false, privacyAccepted = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    EdgeInsets partialPadding = MediaQuery.of(context).viewPadding;

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: PaddedScrollView(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              SvgPicture.asset(
                isRegistering ? "assets/register.svg" : "assets/login.svg",
                width: screen.width,
                semanticsLabel: isRegistering
                    ? "Register illustration"
                    : "Login illustration",
              ),
              SizedBox(height: screen.width * 0.05),
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
                        style: Theme.of(context).textTheme.bodyMedium),
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
                            .bodyMedium
                            ?.copyWith(
                                color: mainLight,
                                fontWeight: FontWeight.bold)),
                  ],
                ),
              ),
              SizedBox(height: screen.width * 0.05),
              CustomInputField(
                controller: emailController,
                inputType: TextInputType.emailAddress,
                prefixIcon: Icons.email_outlined,
                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                placeholder: "Email",
              ),
              SizedBox(height: screen.width * 0.05),
              if (isRegistering) Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  Row(children: [
                    Expanded(
                        child: CustomInputField(
                      controller: firstNameController,
                      inputType: TextInputType.text,
                      placeholder: "First Name",
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    )),
                    SizedBox(width: screen.width * 0.05),
                    Expanded(
                        child: CustomInputField(
                      controller: lastNameController,
                      inputType: TextInputType.text,
                      placeholder: "Last Name",
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                    )),
                  ]),
                  SizedBox(height: screen.width * 0.05),
                  Row(children: [
                    Expanded(
                        child: CustomInputField(
                      controller: birthDateController,
                      inputType: TextInputType.none,
                      placeholder: "Birthday",
                      prefixIcon: Icons.event,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      onTap: () {
                        BottomPicker.date(
                                title: "Set your Birthday",
                                dismissable: true,
                                //pickerTextStyle: Theme.of(context).textTheme.labelSmall!,
                                closeIconColor:
                                    Theme.of(context).backgroundColor,
                                displaySubmitButton: true,
                                buttonSingleColor: mainLight,
                                //titleStyle: Theme.of(context).textTheme.titleSmall!.copyWith(color: mainLight),
                                onSubmit: (dt) => birthDateController.text =
                                    DateFormat("dd/MM/yyyy").format(dt),
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                minDateTime: DateTime(1900),
                                initialDateTime:
                                    DateTime(DateTime.now().year - 16),
                                maxDateTime:
                                    DateTime(DateTime.now().year - 16),
                                dateOrder: DatePickerDateOrder.dmy)
                            .show(context);
                        /*showPlatformDatePicker(
                          context: context,
                          initialDate: DateTime.now()
                              .subtract(const Duration(days: 5840)),
                          firstDate: DateTime(1900),
                          lastDate: DateTime.now(),
                          material: (context, platform) =>
                            MaterialDatePickerData(
                              initialDatePickerMode: DatePickerMode.year
                            ),
                          cupertino: (context, platform) =>
                            CupertinoDatePickerData(
                            ),
                        ).then((value) {
                          if (value != null) {
                            birthDateController.text = DateFormat("dd/MM/yyyy").format(value);
                          }
                        });*/
                      },
                    )),
                    SizedBox(width: screen.width * 0.05),
                    Expanded(
                        child: Material(
                      shadowColor: Theme.of(context).backgroundColor,
                      elevation: 3,
                      clipBehavior: Clip.antiAlias,
                      color: Theme.of(context).scaffoldBackgroundColor,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(100)),
                      child: CountryCodePicker(
                        boxDecoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(20),
                            border: Border.all(width: 2, color: mainLight),
                            color: Theme.of(context).scaffoldBackgroundColor),
                        textStyle: Theme.of(context).textTheme.bodyMedium,
                        dialogTextStyle:
                            Theme.of(context).textTheme.bodyMedium,
                        searchStyle: Theme.of(context).textTheme.bodyMedium,
                        closeIcon: const Icon(Icons.close_rounded),
                        dialogSize: Size(
                            screen.width * 0.75,
                            (screen.height -
                                    partialPadding.top -
                                    partialPadding.bottom) *
                                0.75),
                        barrierColor: Colors.transparent,
                        padding: const EdgeInsets.all(0),
                        initialSelection: "IT",
                        onChanged: (cc) => setState(() => countryCode = cc),
                        showCountryOnly: true,
                        showOnlyCountryWhenClosed: true,
                        alignLeft: true,
                      ),
                    ))
                  ]),
                  SizedBox(height: screen.width * 0.05),
                ]
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  CustomInputField(
                    controller: passwordController,
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
                    style: Theme.of(context).textTheme.labelSmall),
                ]
              ),
              SizedBox(height: screen.width * 0.05),
              Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
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
                  if (isRegistering) Row(
                    children: [
                      CustomSwitch(
                        isChecked: privacyAccepted,
                        onChange: (v) => privacyAccepted = v,
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
                ]
              ),
              SizedBox(height: screen.width * 0.05),
              CustomButton(
                onPressed: () {
                  print("Email : ${emailController.text}");
                  print("Password : ${passwordController.text}");
                  print("Full Name : ${firstNameController.text} ${lastNameController.text}");
                  print("Date of birth : ${birthDateController.text}");
                  print("Nazionality : ${countryCode.name}");
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
        )
      ),
    );
  }
}
