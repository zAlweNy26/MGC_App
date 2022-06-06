import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_email_sender/flutter_email_sender.dart';
import 'package:intl/intl.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/fee.dart';
import 'package:mgclinic/widgets/custom_button.dart';
import 'package:mgclinic/widgets/custom_input.dart';
import 'package:mgclinic/widgets/custom_switch.dart';
import 'package:mgclinic/widgets/number_captcha.dart';
import 'package:time_picker_widget/time_picker_widget.dart';

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
  List<Clinic> clinics = const [
    Clinic(name: "Mellieha (Monday)", availableDays: [DateTime.monday], openHour: 15, closeHour: 18, closeMinute: 30),
    Clinic(name: "San Gwann (Thursday)", availableDays: [DateTime.thursday], openHour: 14, closeHour: 18, closeMinute: 30),
    Clinic(name: "Gozo (Tuesday)", availableDays: [DateTime.tuesday], openHour: 8, closeHour: 19),
  ];

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: Column(crossAxisAlignment: CrossAxisAlignment.stretch, children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Book an appointment",
                  style: Theme.of(context).textTheme.titleLarge)),
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
                      items: clinics.map((e) => e.name).toList(),
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
                        border: InputBorder.none,
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
                        border: InputBorder.none,
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
                      if (clinic.isEmpty) return;
                      showDatePicker(
                        context: context, 
                        initialDate: DateTime.now().add(const Duration(days: 7)),
                        firstDate: DateTime.now().add(const Duration(days: 7)),
                        lastDate: DateTime.now().add(const Duration(days: 365)),
                        initialEntryMode: DatePickerEntryMode.calendarOnly,
                        builder: (context, child) {
                          return Theme(
                            data: Theme.of(context).copyWith(
                              colorScheme: ColorScheme.light(
                                primary: primaryColor,
                                onPrimary: Theme.of(context).scaffoldBackgroundColor,
                                onSurface: Theme.of(context).backgroundColor,
                              ),
                              textTheme: TextTheme(overline: Theme.of(context).textTheme.headlineSmall),
                              textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: primaryColor)),
                            ),
                            child: child!,
                          );
                        },
                        selectableDayPredicate: (date) {
                          Clinic clinic = clinics.firstWhere((e) => e.name == this.clinic);
                          return !clinic.availableDays.contains(date.weekday);
                        },
                      ).then((date) {
                        if (date != null) {
                          showCustomTimePicker(
                            context: context, 
                            onFailValidation: (context) => showMessage(context, 'Unavailable selection !'),
                            initialTime: const TimeOfDay(hour: 14, minute: 0),
                            builder: (context, child) {
                              return MediaQuery(
                                data: MediaQuery.of(context).copyWith(alwaysUse24HourFormat: false),
                                child: Theme(
                                  data: Theme.of(context).copyWith(
                                    colorScheme: ColorScheme.light(
                                      primary: primaryColor,
                                      onPrimary: Theme.of(context).backgroundColor,
                                    ),
                                    timePickerTheme: TimePickerThemeData(
                                      hourMinuteTextColor: MaterialStateColor.resolveWith((states) =>
                                        states.contains(MaterialState.selected)
                                          ? primaryColor
                                          : Theme.of(context).backgroundColor),
                                      dayPeriodTextColor: MaterialStateColor.resolveWith((states) =>
                                        states.contains(MaterialState.selected)
                                          ? primaryColor
                                          : Theme.of(context).backgroundColor),
                                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                                      dialTextColor: MaterialStateColor.resolveWith((states) =>
                                        states.contains(MaterialState.selected)
                                          ? Theme.of(context).scaffoldBackgroundColor
                                          : Theme.of(context).backgroundColor),
                                    ),
                                    textTheme: TextTheme(overline: Theme.of(context).textTheme.headlineSmall),
                                    textButtonTheme: TextButtonThemeData(style: TextButton.styleFrom(primary: primaryColor)),
                                  ),
                                  child: child!,
                                ),
                              );
                            },
                            selectableTimePredicate: (time) {
                              if (time != null) {
                                Clinic clinic = clinics.firstWhere((e) => e.name == this.clinic);
                                bool isInHoursRange =time.hour >= clinic.openHour && time.hour <= clinic.closeHour;
                                bool isInMinutesRange = time.minute >= clinic.openMinute && time.minute <= clinic.closeMinute;
                                return time.hour != clinic.closeHour ? isInHoursRange : (isInHoursRange && isInMinutesRange);
                              }
                              return false;
                            }
                          ).then((time) {
                            if (time != null) {
                              setState(() {
                                dateTime = DateFormat("dd/MM/yyyy").format(date) + 
                                  " at ${time.replacing(hour: time.hourOfPeriod).toString().replaceAll("TimeOfDay", "").substring(1, 6)} " +
                                  (time.hour <= 12 ? "am" : "pm");
                                dateTimeController.text = dateTime;
                              });
                            }
                          });
                        }
                      });
                      /*CustomBottomPicker.dateTime(
                          title: "Select a date and time :",
                          dismissable: true,
                          use24hFormat: true,
                          minuteInterval: 30,
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
                      .show(context);*/
                    },
                  ),
                  SizedBox(height: screen.width * 0.05),
                  /*CustomSwitch(
                    onSaved: (val) => rememberDetails = val ?? false,
                    borderColor: primaryColor,
                    selectedIconColor: primaryColor,
                    isRequired: false,
                    trailing: Text(
                      "Remember my details",
                      style: Theme.of(context).textTheme.bodySmall,
                    ),
                  ),*/
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
                            recognizer: TapGestureRecognizer()
                            ..onTap = () async {
                              await showDialog(
                                context: context, 
                                builder: (ctx) => AlertDialog(
                                  title: const Text("Terms and Conditions"),
                                  content: Text(
                                    "* You will be asked detailed information of your personal and family health, present and past, in order to gain an understanding of your complaint. Your answers and comments will be dealt with, strictly confidentially and will be stored in a off-line database for seven (7) years. This is a legal requirement. * You have the right to peruse, copy and/or destroy your clinical record (before the seven years) as long as you request so in formal writing. * A chiropractic practitioner will need to look at your (undressed) back therefore you may be asked to expose parts of your body. You will NEVER be asked to reveal intimate areas. * Patients under the age of 18 years, seeking chiropractic help, MUST be accompanied by an adult who will remain in the clinic room at all times during the consultation.",
                                    style: Theme.of(context).textTheme.labelMedium,
                                  ),
                                  actions: [
                                    TextButton(
                                      child: const Text("Close"),
                                      onPressed: () => Navigator.pop(ctx),
                                    ),
                                  ],
                                ),
                              );
                            },
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
                          onPressed: () async {
                            bool isValid = await CustomNumberCaptcha.show(context, accentColor: primaryColor);
                            if (_bookKey.currentState!.validate() && isValid) {
                              _bookKey.currentState!.save();
                              final Email sendEmail = Email(
                                body: '',
                                subject: 'Appointment Booking',
                                recipients: ["maltagozochiropractic@hotmail.com"]
                              );
                              await FlutterEmailSender.send(sendEmail);
                            }
                          },
                          text: "Book",
                          textStyle: Theme.of(context).textTheme.titleMedium,
                          backgroundColor: primaryColor
                        ),
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

  showMessage(BuildContext context, String message) => showDialog(
    context: context,
    builder: (context) {
      return AlertDialog(
        contentPadding: EdgeInsets.zero,
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(height: 16),
            const Icon(Icons.warning, color: Colors.amber, size: 56),
            const SizedBox(height: 12),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              child: Text(
                message,
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headlineSmall,
              ),
            ),
            const SizedBox(height: 12),
            InkWell(
              onTap: () => Navigator.of(context).pop(),
              child: Container(
                alignment: Alignment.center,
                width: double.infinity,
                padding: const EdgeInsets.symmetric(vertical: 16),
                child: Text('Ok', style: Theme.of(context).textTheme.headlineSmall),
              ),
            ),
          ],
        ),
      );
    }
  );
}
