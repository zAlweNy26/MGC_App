import 'package:bottom_picker/resources/arrays.dart';
import 'package:bottom_picker/resources/context_extension.dart';
import 'package:bottom_picker/widgets/bottom_picker_button.dart';
import 'package:bottom_picker/widgets/close_icon.dart';
import 'package:bottom_picker/widgets/simple_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mgclinic/widgets/custom_cupertinodatetimepicker.dart';

// ignore: must_be_immutable
class CustomBottomPicker extends StatefulWidget {
  ///The dateTime picker mode
  ///[CupertinoDatePickerMode.date] or [CupertinoDatePickerMode.dateAndTime] or [CupertinoDatePickerMode.time]
  ///
  late CupertinoDatePickerMode datePickerMode;

  ///the bottom picker type
  ///```dart
  ///{
  ///simple,
  ///dateTime
  ///}
  ///```
  late BOTTOM_PICKER_TYPE bottomPickerType;

  CustomBottomPicker({
    Key? key,
    required this.title,
    required this.items,
    this.titleStyle = const TextStyle(),
    this.dismissable = false,
    this.onChange,
    this.onSubmit,
    this.minuteInterval = 1,
    this.hourInterval = 1,
    this.onClose,
    this.bottomPickerTheme = BOTTOM_PICKER_THEME.blue,
    this.gradientColors,
    this.iconColor = Colors.white,
    this.selectedItemIndex = 0,
    this.buttonText,
    this.buttonTextStyle,
    this.displayButtonIcon = true,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.itemExtent = 35.0,
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.black,
    this.layoutOrientation = LAYOUT_ORIENTATION.ltr,
    this.buttonAlignement = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
  }) : super(key: key) {
    dateOrder = null;
    bottomPickerType = BOTTOM_PICKER_TYPE.simple;
    assert(items != null && items!.isNotEmpty);
    assert(selectedItemIndex >= 0);
    if (selectedItemIndex > 0) {
      assert(selectedItemIndex < items!.length);
    }
  }

  CustomBottomPicker.date({
    Key? key,
    required this.title,
    this.titleStyle = const TextStyle(),
    this.dismissable = false,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BOTTOM_PICKER_THEME.blue,
    this.gradientColors,
    this.iconColor = Colors.white,
    this.initialDateTime,
    this.minDateTime,
    this.maxDateTime,
    this.minuteInterval = 1,
    this.hourInterval = 1,
    this.buttonText,
    this.buttonTextStyle,
    this.displayButtonIcon = true,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.dateOrder = DatePickerDateOrder.ymd,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.black,
    this.layoutOrientation = LAYOUT_ORIENTATION.ltr,
    this.buttonAlignement = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
  }) : super(key: key) {
    datePickerMode = CupertinoDatePickerMode.date;
    bottomPickerType = BOTTOM_PICKER_TYPE.dateTime;
    use24hFormat = false;
    itemExtent = 0;
  }

  CustomBottomPicker.dateTime({
    Key? key,
    required this.title,
    this.titleStyle = const TextStyle(),
    this.dismissable = false,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BOTTOM_PICKER_THEME.blue,
    this.gradientColors,
    this.iconColor = Colors.white,
    this.initialDateTime,
    this.minDateTime,
    this.maxDateTime,
    this.minuteInterval = 1,
    this.hourInterval = 1,
    this.use24hFormat = false,
    this.buttonText,
    this.buttonTextStyle,
    this.displayButtonIcon = true,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.dateOrder = DatePickerDateOrder.ymd,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.black,
    this.layoutOrientation = LAYOUT_ORIENTATION.ltr,
    this.buttonAlignement = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
  }) : super(key: key) {
    datePickerMode = CupertinoDatePickerMode.dateAndTime;
    bottomPickerType = BOTTOM_PICKER_TYPE.dateTime;
    itemExtent = 0;
  }

  CustomBottomPicker.time({
    Key? key,
    required this.title,
    this.titleStyle = const TextStyle(),
    this.dismissable = false,
    this.onChange,
    this.onSubmit,
    this.onClose,
    this.bottomPickerTheme = BOTTOM_PICKER_THEME.blue,
    this.gradientColors,
    this.iconColor = Colors.white,
    this.initialDateTime,
    this.minDateTime,
    this.minuteInterval = 1,
    this.hourInterval = 1,
    this.maxDateTime,
    this.use24hFormat = false,
    this.buttonText,
    this.buttonTextStyle,
    this.displayButtonIcon = true,
    this.buttonSingleColor,
    this.backgroundColor = Colors.white,
    this.pickerTextStyle = const TextStyle(
      fontSize: 14,
      color: Colors.black,
    ),
    this.displayCloseIcon = true,
    this.closeIconColor = Colors.black,
    this.layoutOrientation = LAYOUT_ORIENTATION.ltr,
    this.buttonAlignement = MainAxisAlignment.center,
    this.height,
    this.displaySubmitButton = true,
  }) : super(key: key) {
    datePickerMode = CupertinoDatePickerMode.time;
    bottomPickerType = BOTTOM_PICKER_TYPE.dateTime;
    dateOrder = null;
    itemExtent = 0;
  }

  ///The title of the bottom picker
  ///it's required for all bottom picker types
  ///
  final String title;

  ///The text style applied on the title
  ///by default it applies simple text style
  ///
  final TextStyle titleStyle;

  ///defines whether the bottom picker is dismissable or not
  ///by default it's set to false
  ///
  final bool dismissable;

  ///list of items (List of text) used to create simple item picker (required)
  ///and should not be empty or null
  ///
  ///for date/dateTime/time items parameter is not available
  ///
  late List<Text>? items;

  ///Nullable function, invoked when navigating between picker items
  ///whether it's date picker or simple item picker it will return a value DateTime or int(index)
  ///
  final Function(dynamic)? onChange;

  ///Nullable function invoked  when clicking on submit button
  ///if the picker  type is date/time/dateTime it will return DateTime value
  ///else it will return the index of the selected item
  ///
  final Function(dynamic)? onSubmit;

  ///Invoked when clicking on the close button
  ///
  final Function? onClose;

  ///set the theme of the bottom picker (the button theme)
  ///possible values
  ///```
  ///{
  ///blue,
  ///orange,
  ///temptingAzure,
  ///heavyRain,
  ///plumPlate,
  ///morningSalad
  ///}
  ///```
  final BOTTOM_PICKER_THEME bottomPickerTheme;

  ///to set a custom button theme color use this list
  ///when it's not null it will be applied
  ///
  final List<Color>? gradientColors;

  ///define the icon color on the button
  ///by default it's White
  ///
  final Color iconColor;

  ///used for simple bottom picker
  ///by default it's 0, needs to be in the range [0, this.items.length-1]
  ///otherwise an exception will be thrown
  ///for date and time picker type this parameter is not available
  ///
  late int selectedItemIndex;

  ///The initial date time applied on the date and time picker
  ///by default it's null
  ///
  DateTime? initialDateTime;

  ///the max date time on the date picker
  ///by default it's null
  DateTime? maxDateTime;

  ///the minimum date & time applied on the date picker
  ///by default it's null
  ///
  DateTime? minDateTime;

  ///define whether the time uses 24h or 12h format
  ///by default it's false (12h format)
  ///
  late bool use24hFormat;

  ///the text that will be applied to the button
  ///if the text is null the button will be rendered with an icon
  final String? buttonText;

  ///the button text style, will be applied on the button's text
  final TextStyle? buttonTextStyle;

  ///display button icon
  ///by default it's true
  ///if you want to display a text you can set [displayButtonIcon] to false
  final bool displayButtonIcon;

  ///a single color will be applied to the button instead of the gradient
  ///themes
  ///
  final Color? buttonSingleColor;

  ///the bottom picker background color,
  ///by default it's white
  ///
  final Color backgroundColor;

  ///the minutes interval,
  ///by default it's 1
  ///
  final int minuteInterval;

  ///the hours interval,
  ///by default it's 1
  ///
  final int hourInterval;

  ///date order applied on date picker or date time picker
  ///by default it's YYYY/MM/DD
  late DatePickerDateOrder? dateOrder;

  ///the picker text style applied on all types of bottom picker
  ///by default `TextStyle(fontSize: 14)`
  final TextStyle pickerTextStyle;

  ///define the picker item extent available only for list items picker
  ///by default it's 35
  late double itemExtent;

  ///indicate whether the close icon will be rendred or not
  /// by default `displayCloseIcon = true`
  final bool displayCloseIcon;

  ///the close icon color
  ///by default `closeIconColor = Colors.black`
  final Color closeIconColor;

  ///the layout orientation of the bottom picker
  ///by default the orientation is set to LTR
  ///```
  ///LAYOUT_ORIENTATION.ltr,
  ///LAYOUT_ORIENTATION.rtl
  ///```
  final LAYOUT_ORIENTATION layoutOrientation;

  ///THe alignement of the bottom picker button
  ///by default it's `MainAxisAlignment.center`
  final MainAxisAlignment buttonAlignement;

  ///bottom picker main widget height
  ///if it's null the bottom picker will get the height from
  ///[bottomPickerHeight] extension on context
  final double? height;

  ///indicates if the submit button will be displayed or not
  ///by default the submit button is shown
  final bool displaySubmitButton;

  ///display the bottom picker popup
  ///[context] the app context to display the popup
  ///
  void show(BuildContext context) {
    showModalBottomSheet(
      context: context,
      isDismissible: dismissable,
      enableDrag: false,
      constraints: BoxConstraints(
        maxWidth: context.bottomPickerWidth,
      ),
      backgroundColor: Colors.transparent,
      builder: (context) {
        return BottomSheet(
          backgroundColor: Colors.transparent,
          enableDrag: false,
          onClosing: () {},
          builder: (context) {
            return this;
          },
        );
      },
    );
  }

  @override
  _BottomPickerState createState() => _BottomPickerState();
}

class _BottomPickerState extends State<CustomBottomPicker> {
  late int selectedItemIndex;
  late DateTime selectedDateTime;

  @override
  void initState() {
    super.initState();
    if (widget.bottomPickerType == BOTTOM_PICKER_TYPE.simple) {
      selectedItemIndex = widget.selectedItemIndex;
    } else {
      selectedDateTime = widget.initialDateTime ?? DateTime.now();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      height: widget.height ?? context.bottomPickerHeight,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: const BorderRadius.only(
          topRight: Radius.circular(20),
          topLeft: Radius.circular(20),
        ),
      ),
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(
                left: 20,
                right: 20,
                top: 20,
                bottom: 20,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: widget.layoutOrientation == LAYOUT_ORIENTATION.rtl
                    ? _displayRTLOrientationLayout()
                    : _displayLTROrientationLayout(),
              ),
            ),
            Expanded(
              child: widget.bottomPickerType == BOTTOM_PICKER_TYPE.simple
                  ? SimplePicker(
                      items: widget.items!,
                      onChange: (int index) {
                        selectedItemIndex = index;
                        widget.onChange?.call(index);
                      },
                      selectedItemIndex: widget.selectedItemIndex,
                      textStyle: widget.pickerTextStyle,
                      itemExtent: widget.itemExtent,
                    )
                  : CustomDatePicker(
                      initialDateTime: widget.initialDateTime,
                      maxDateTime: widget.maxDateTime,
                      minDateTime: widget.minDateTime,
                      mode: widget.datePickerMode,
                      minuteInterval: widget.minuteInterval,
                      hourInterval: widget.hourInterval,
                      onDateChanged: (DateTime date) {
                        selectedDateTime = date;
                        widget.onChange?.call(date);
                      },
                      use24hFormat: widget.use24hFormat,
                      dateOrder: widget.dateOrder,
                      textStyle: widget.pickerTextStyle,
                    ),
            ),
            if (widget.displaySubmitButton)
              Padding(
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 20,
                ),
                child: Row(
                  mainAxisAlignment: widget.buttonAlignement,
                  children: [
                    BottomPickerButton(
                      onClick: () {
                        widget.onSubmit?.call(
                          widget.bottomPickerType == BOTTOM_PICKER_TYPE.simple
                              ? selectedItemIndex
                              : selectedDateTime,
                        );
                        Navigator.pop(context);
                      },
                      iconColor: widget.iconColor,
                      text: widget.buttonText,
                      textStyle: widget.buttonTextStyle,
                      displayIcon: widget.displayButtonIcon,
                      solidColor: widget.buttonSingleColor,
                    ),
                  ],
                ),
              ),
          ],
        ),
      ),
    );
  }

  ///render list widgets for RTL orientation
  List<Widget> _displayRTLOrientationLayout() {
    return [
      CloseIcon(
        onPress: _closeBottomPicker,
        iconColor: widget.closeIconColor,
      ),
      Text(
        widget.title,
        style: widget.titleStyle,
        textAlign: TextAlign.end,
      ),
    ];
  }

  ///render list widgets for LTR orientation
  List<Widget> _displayLTROrientationLayout() {
    return [
      Text(
        widget.title,
        style: widget.titleStyle,
      ),
      CloseIcon(
        onPress: _closeBottomPicker,
        iconColor: widget.closeIconColor,
      ),
    ];
  }

  void _closeBottomPicker() {
    Navigator.pop(context);
    widget.onClose?.call();
  }
}

class CustomDatePicker extends StatelessWidget {
  final CupertinoDatePickerMode mode;
  final Function(DateTime) onDateChanged;
  final DateTime? initialDateTime;
  final DateTime? maxDateTime;
  final DateTime? minDateTime;
  final bool use24hFormat;
  final DatePickerDateOrder? dateOrder;
  final TextStyle textStyle;
  final int minuteInterval, hourInterval;

  const CustomDatePicker({
    Key? key,
    required this.initialDateTime,
    required this.maxDateTime,
    required this.minDateTime,
    required this.mode,
    required this.onDateChanged,
    required this.use24hFormat,
    required this.textStyle,
    required this.minuteInterval,
    required this.hourInterval,
    this.dateOrder,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CupertinoTheme(
      data: CupertinoThemeData(
        textTheme: CupertinoTextThemeData(
          dateTimePickerTextStyle: textStyle,
        ),
      ),
      child: CustomCupertinoDatePicker(
        mode: mode,
        onDateTimeChanged: onDateChanged,
        initialDateTime: DateTime(initialDateTime!.year, initialDateTime!.month, initialDateTime!.day, initialDateTime!.hour, 0),
        maximumDate: maxDateTime,
        minimumDate: DateTime(minDateTime!.year, minDateTime!.month, minDateTime!.day, minDateTime!.hour, 0),
        use24hFormat: use24hFormat,
        minuteInterval: minuteInterval,
        hourInterval: hourInterval,
        dateOrder: dateOrder,
      ),
    );
  }
}
