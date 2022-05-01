import 'package:flutter/material.dart';
import 'package:flymeet/constants.dart';

class CustomButton extends StatefulWidget {
  final Color? backgroundColor, borderColor, startColor, endColor;
  final bool onlyIcon;
  final double width, height;
  final Widget? icon;
  final String text;
  final double radius, borderWidth;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final ValueChanged<bool>? onFocusChanged, onHover;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      this.width = 300,
      this.height = 50,
      this.text = "",
      this.icon,
      this.onlyIcon = false,
      this.padding = const EdgeInsets.all(10),
      this.textStyle = const TextStyle(fontSize: 24, color: Colors.grey),
      this.backgroundColor = Colors.transparent,
      this.radius = 50.0,
      this.borderWidth = 2,
      this.startColor,
      this.endColor,
      this.borderColor = Colors.transparent,
      this.onFocusChanged,
      this.onHover})
      : super(key: key);

  @override
  _CustomButtonState createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton> {
  bool isFocus = false;

  @override
  Widget build(BuildContext context) {
    return widget.onlyIcon
      ? Material(
          clipBehavior: Clip.antiAlias,
          elevation: 3,
          borderRadius: BorderRadius.circular(widget.radius),
          child: IconButton(
            color: mainLight,
            onPressed: widget.onPressed,
            icon: widget.icon!,
          ),
        )
      : DecoratedBox(
        decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        /*boxShadow: const [BoxShadow(
          color: Color(0xFFCACACA),
          offset: Offset(20, 20),
          blurRadius: 60,
        ),
        BoxShadow(
          color: Colors.white,
          offset: Offset(-20, -20),
          blurRadius: 60
        )],*/
        gradient: widget.startColor != null && widget.endColor != null
            ? LinearGradient(
                colors: [widget.startColor!, widget.endColor!])
            : LinearGradient(colors: [
                widget.backgroundColor!,
                widget.backgroundColor!
              ])),
      child: ElevatedButton(
        style: ButtonStyle(
          elevation: MaterialStateProperty.all(0),
          padding: MaterialStateProperty.all(widget.padding),
          overlayColor: MaterialStateProperty.all(mainDark),
          shape: MaterialStateProperty.all(RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(widget.radius),
            side: BorderSide(
              color: widget.borderColor!,
              width: widget.borderWidth
            )
          )),
          backgroundColor: MaterialStateProperty.all(widget.backgroundColor!),
        ),
        onPressed: widget.onPressed,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: widget.textStyle,
        ),
      )
    );
  }
}
