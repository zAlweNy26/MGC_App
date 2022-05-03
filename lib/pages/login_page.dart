import 'package:bottom_picker/bottom_picker.dart';
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
  final birthDateController = TextEditingController();
  final genderController = TextEditingController();
  final _loginKey = GlobalKey<FormState>();
  String email = "", password = "", gender = "", firstName = "", lastName = "", birthDate = "";
  bool isRegistering = false, rememberLogin = false, privacyAccepted = false;

  @override
  Widget build(BuildContext context) {
    List<Text> gendersList = [Text("Male"), Text("Female"), Text("Transgender"), Text("Non-binary")];
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
          height: screen.height,
          width: screen.width,
          child: PaddedScrollView(
              scrollPadding: const EdgeInsets.all(20),
              child: Form(
                key: _loginKey,
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
                      onSaved: (val) => email = val ?? "",
                      inputType: TextInputType.emailAddress,
                      prefixIcon: Icons.email_outlined,
                      backgroundColor:
                          Theme.of(context).scaffoldBackgroundColor,
                      placeholder: "Email",
                    ),
                    SizedBox(height: screen.width * 0.05),
                    if (isRegistering)
                      Column(
                          crossAxisAlignment: CrossAxisAlignment.stretch,
                          children: [
                            Row(children: [
                              Expanded(
                                  child: CustomInputField(
                                onSaved: (val) => firstName = val ?? "",
                                inputType: TextInputType.text,
                                placeholder: "First Name",
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                              )),
                              SizedBox(width: screen.width * 0.05),
                              Expanded(
                                  child: CustomInputField(
                                onSaved: (val) => lastName = val ?? "",
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
                                    enabled: false,
                                controller: birthDateController,
                                onSaved: (val) => birthDate = val ?? "",
                                inputType: TextInputType.datetime,
                                placeholder: "Birth Date",
                                prefixIcon: Icons.cake_rounded,
                                backgroundColor:
                                    Theme.of(context).scaffoldBackgroundColor,
                                onTap: () {
                                  BottomPicker.date(
                                          title: "Select your birth date",
                                          dismissable: true,
                                          pickerTextStyle: Theme.of(context)
                                              .textTheme
                                              .labelSmall!.copyWith(fontSize: 20),
                                          closeIconColor:
                                              Theme.of(context).backgroundColor,
                                          displaySubmitButton: true,
                                          buttonSingleColor: mainLight,
                                          titleStyle: Theme.of(context)
                                              .textTheme
                                              .titleSmall!
                                              .copyWith(color: mainLight),
                                          buttonText: "Confirm",
                                          onSubmit: (dt) =>
                                              birthDateController.text =
                                                  DateFormat("dd/MM/yyyy")
                                                      .format(dt),
                                          backgroundColor: Theme.of(context)
                                              .scaffoldBackgroundColor,
                                          minDateTime: DateTime(1900),
                                          initialDateTime: DateTime(
                                              DateTime.now().year - 16),
                                          maxDateTime: DateTime(
                                              DateTime.now().year - 16),
                                          dateOrder: DatePickerDateOrder.dmy)
                                      .show(context);
                                },
                              )),
                              SizedBox(width: screen.width * 0.05),
                              Expanded(
                                child: CustomInputField(
                                enabled: false,
                                controller: genderController,
                                onSaved: (val) => gender = val ?? "",
                                inputType: TextInputType.text,
                                placeholder: "Gender",
                                prefixIcon: Icons.person,
                                backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                onTap: () {
                                  BottomPicker(
                                    items: gendersList,
                                    title: "Select your gender",
                                    dismissable: true,
                                    closeIconColor: Theme.of(context).backgroundColor,
                                    pickerTextStyle: Theme.of(context)
                                        .textTheme
                                        .labelSmall!.copyWith(fontSize: 28),
                                    displaySubmitButton: true,
                                    buttonText: "Confirm",
                                    buttonSingleColor: mainLight,
                                    titleStyle: Theme.of(context)
                                        .textTheme
                                        .titleSmall!
                                        .copyWith(color: mainLight),
                                    onSubmit: (index) =>
                                        genderController.text = gendersList.elementAt(index).data!,
                                    backgroundColor: Theme.of(context)
                                        .scaffoldBackgroundColor)
                                .show(context);
                                },
                              )),
                            ]),
                            SizedBox(height: screen.width * 0.05),
                          ]),
                    Column(
                        crossAxisAlignment: CrossAxisAlignment.stretch,
                        children: [
                          CustomInputField(
                            onSaved: (val) => password = val ?? "",
                            obscureText: true,
                            inputType: TextInputType.visiblePassword,
                            placeholder: "Password",
                            backgroundColor:
                                Theme.of(context).scaffoldBackgroundColor,
                            prefixIcon: Icons.password_outlined,
                          ),
                          if (isRegistering) const SizedBox(height: 10),
                          if (isRegistering)
                            Text(
                                "The password must be minimum 8 characters long, with at least one uppercase letter, one lowercase letter, one number and one special character (@\$!%*?&)",
                                style: Theme.of(context).textTheme.labelSmall),
                        ]),
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
                              ),
                              const Spacer(),
                              if (!isRegistering)
                                RichText(
                                  textAlign: TextAlign.end,
                                  text: TextSpan(
                                      text: "Forgot password ?",
                                      recognizer: TapGestureRecognizer()
                                        ..onTap = () => Navigator.pushNamed(
                                            context, '/forgot'),
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodySmall
                                          ?.copyWith(
                                              color: mainLight,
                                              fontWeight: FontWeight.bold)),
                                )
                            ],
                          ),
                          if (isRegistering)
                            Row(
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
                                    style:
                                        Theme.of(context).textTheme.bodySmall,
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
                        ]),
                    SizedBox(height: screen.width * 0.05),
                    CustomButton(
                      onPressed: () {
                        //Navigator.pushNamed(context, '/home');
                        if (_loginKey.currentState!.validate()) {
                          _loginKey.currentState!.save();
                          print("Email : $email");
                          print("Password : $password");
                          print("Full Name : $firstName $lastName");
                          print("Date of birth : $birthDate");
                          print("Gender : $gender");
                        }
                      },
                      text: isRegistering ? "Sign up" : "Log in",
                      textStyle: Theme.of(context).textTheme.titleMedium,
                      startColor: mainLight,
                      endColor: mainDark,
                    ),
                  ],
                ),
              ))),
    );
  }
}
