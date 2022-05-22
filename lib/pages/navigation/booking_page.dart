import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/widgets/custom_button.dart';
import 'package:mgclinic/widgets/custom_input.dart';
import 'package:mgclinic/widgets/custom_switch.dart';
import 'package:mgclinic/widgets/filterable_bottompicker.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  final dateTimeController = TextEditingController();
  final _bookKey = GlobalKey<FormState>();
  String email = "",
      firstName = "",
      lastName = "",
      phoneNumber = "",
      dateTime = "",
      clinic = "",
      clinicError = "",
      appointmentType = "",
      appointmentError = "";
  bool privacyAccepted = false, rememberDetails = false;

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Book an appointment",
                  style: Theme.of(context).textTheme.headlineMedium)),
        ),
        Padding(
          padding: const EdgeInsets.all(10),
          child: Form(
              key: _bookKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomInputField(
                    onSaved: (val) => email = val ?? "",
                    inputType: TextInputType.emailAddress,
                    prefixIcon: Icons.email_outlined,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    placeholder: "Email",
                  ),
                  SizedBox(height: screen.width * 0.05),
                  Row(children: [
                    Expanded(
                        child: CustomInputField(
                      onSaved: (val) => firstName = val ?? "",
                      inputType: TextInputType.name,
                      placeholder: "First Name",
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    )),
                    SizedBox(width: screen.width * 0.05),
                    Expanded(
                        child: CustomInputField(
                      onSaved: (val) => lastName = val ?? "",
                      inputType: TextInputType.name,
                      placeholder: "Last Name",
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    )),
                  ]),
                  SizedBox(height: screen.width * 0.05),
                  CustomInputField(
                    onSaved: (val) => phoneNumber = val ?? "",
                    inputType: TextInputType.phone,
                    prefixIcon: Icons.phone,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    placeholder: "Phone Number",
                  ),
                  SizedBox(height: screen.width * 0.05),
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shadowColor: Theme.of(context).backgroundColor,
                    elevation: 3,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(20),
                    child: DropdownSearch<String>(
                      mode: Mode.BOTTOM_SHEET,
                      items: const ["Mellieha (Monday)", "San Gwann (Thursday)", "Gozo (Tuesday)"],
                      dropdownBuilder: (ctx, text) {
                        return Text(text ?? "Choose a clinic...", style: Theme.of(context).textTheme.labelMedium);
                      },
                      popupItemBuilder: (ctx, text, selected) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
                        );
                      },
                      onChanged: (val) => setState(() => clinic = val ?? ""),
                      popupTitle: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Choose a clinic :", style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor)),
                      ),
                      maxHeight: 175,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.location_pin,
                              color: Theme.of(context).backgroundColor),
                        labelText:
                            "Clinic ${clinicError.isNotEmpty ? "- Required" : ""}",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor),
                        errorStyle: const TextStyle(height: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor),
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: "Choose a clinic...",
                      ),
                      validator: (String? item) {
                        if (item == null) {
                          setState(() {
                            clinicError = "Required";
                          });
                          return "";
                        } else {
                          setState(() {
                            clinicError = "";
                          });
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screen.width * 0.05),
                  Material(
                    color: Theme.of(context).scaffoldBackgroundColor,
                    shadowColor: Theme.of(context).backgroundColor,
                    elevation: 3,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    borderRadius: BorderRadius.circular(20),
                    child: DropdownSearch<String>(
                      enabled: clinic.isNotEmpty,
                      mode: Mode.BOTTOM_SHEET,
                      items: const ["Free spinal check (5-10 mins)", "First consultation (30-45 mins)", 
                        "Follow up (15-20 mins)", "Deep tissue work (40 mins)"],
                      dropdownBuilder: (ctx, text) {
                        return Text(text ?? "Choose a type...", style: Theme.of(context).textTheme.labelMedium);
                      },
                      popupItemBuilder: (ctx, text, selected) {
                        return Padding(
                          padding: const EdgeInsets.all(10),
                          child: Text(text, style: Theme.of(context).textTheme.labelMedium),
                        );
                      },
                      popupTitle: Padding(
                        padding: const EdgeInsets.all(10),
                        child: Text("Choose the type :", style: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor)),
                      ),
                      maxHeight: 220,
                      dropdownSearchDecoration: InputDecoration(
                        contentPadding: const EdgeInsets.all(0),
                        prefixIcon: Icon(Icons.local_hospital_rounded,
                              color: Theme.of(context).backgroundColor),
                        labelText:
                            "Appointment Type ${appointmentError.isNotEmpty ? "- Required" : ""}",
                        labelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor),
                        errorStyle: const TextStyle(height: 0),
                        floatingLabelBehavior: FloatingLabelBehavior.always,
                        floatingLabelStyle: Theme.of(context)
                            .textTheme
                            .titleSmall
                            ?.copyWith(color: primaryColor),
                        hintStyle: Theme.of(context).textTheme.labelMedium,
                        hintText: "Choose the type...",
                      ),
                      onChanged: (val) => setState(() => appointmentType = val ?? ""),
                      validator: (String? item) {
                        if (item == null) {
                          setState(() {
                            appointmentError = "Required";
                          });
                          return "";
                        } else {
                          setState(() {
                            appointmentError = "";
                          });
                          return null;
                        }
                      },
                    ),
                  ),
                  SizedBox(height: screen.width * 0.05),
                  CustomInputField(
                    enabled: false,
                    controller: dateTimeController,
                    onSaved: (val) => dateTime = val ?? "",
                    inputType: TextInputType.datetime,
                    placeholder: "Appointment Date & Time",
                    hint: "Choose a date and time...",
                    prefixIcon: Icons.event_available,
                    backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                    onTap: () {
                      CustomBottomPicker.dateTime(
                          title: "Select a date and time :",
                          dismissable: true,
                          use24hFormat: true,
                          minuteInterval: 10,
                          hourInterval: 2,
                          pickerTextStyle: Theme.of(context)
                              .textTheme
                              .labelSmall!
                              .copyWith(fontSize: 16),
                          iconColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          closeIconColor: Theme.of(context).backgroundColor,
                          displaySubmitButton: true,
                          buttonSingleColor: primaryColor,
                          titleStyle: Theme.of(context)
                              .textTheme
                              .titleSmall!
                              .copyWith(color: primaryColor),
                          buttonText: "Confirm",
                          buttonTextStyle:
                              Theme.of(context).textTheme.titleMedium,
                          onSubmit: (dt) => dateTimeController.text =
                              "${DateFormat("dd/MM/yyyy").format(dt)} at ${DateFormat("HH:mm").format(dt)}",
                          backgroundColor:
                              Theme.of(context).scaffoldBackgroundColor,
                          minDateTime:
                              DateTime.now().add(const Duration(days: 7)),
                          initialDateTime:
                              DateTime.now().add(const Duration(days: 7)),
                          maxDateTime:
                              DateTime.now().add(const Duration(days: 365)),
                          dateOrder: DatePickerDateOrder.dmy)
                      .show(context);
                    },
                  ),
                  SizedBox(height: screen.width * 0.05),
                  CustomSwitch(
                    onSaved: (val) => rememberDetails = val ?? false,
                    borderColor: primaryColor,
                    selectedIconColor: primaryColor,
                    isRequired: false,
                    trailing: Text(
                      "Remember my details",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),
                  CustomSwitch(
                    onSaved: (val) => privacyAccepted = val ?? false,
                    borderColor: primaryColor,
                    selectedIconColor: primaryColor,
                    trailing: RichText(
                      text: TextSpan(
                        text: "I have read and accept the",
                        style: Theme.of(context).textTheme.bodySmall,
                        children: [
                          TextSpan(
                              text: " Terms and Conditions",
                              style: Theme.of(context)
                                  .textTheme
                                  .bodySmall
                                  ?.copyWith(
                                      color: primaryColor,
                                      fontWeight: FontWeight.bold)),
                        ],
                      ),
                    ),
                  ),
                  SizedBox(height: screen.width * 0.05),
                  Row(
                    children: [
                      const Spacer(),
                      Flexible(
                        flex: 2,
                        fit: FlexFit.tight,
                        child: CustomButton(
                            onPressed: () {
                              if (_bookKey.currentState!.validate()) {
                                _bookKey.currentState!.save();
                                print("Email : $email");
                                print("Full Name : $firstName $lastName");
                              }
                            },
                            text: "Book",
                            textStyle: Theme.of(context).textTheme.titleMedium,
                            backgroundColor: primaryColor),
                      ),
                      const Spacer()
                    ],
                  )
                ],
              )),
        )
      ]),
    );
  }
}
