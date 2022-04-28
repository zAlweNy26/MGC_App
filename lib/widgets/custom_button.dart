import 'package:flutter/material.dart';

class CustomButton extends StatefulWidget {
  final Color? backgroundColor, borderColor, startColor, endColor;
  final bool onlyIcon;
  final IconData icon;
  final String text;
  final double radius, borderWidth;
  final EdgeInsets padding;
  final VoidCallback? onPressed;
  final TextStyle? textStyle;
  final FocusNode? focusNode;
  final ValueChanged<bool>? onFocusChanged, onHover;

  const CustomButton(
      {Key? key,
      required this.onPressed,
      this.text = "",
      this.icon = Icons.abc,
      this.onlyIcon = false,
      this.padding = const EdgeInsets.all(10),
      this.textStyle = const TextStyle(fontSize: 24, color: Colors.black),
      this.backgroundColor = Colors.transparent,
      this.radius = 50.0,
      this.borderWidth = 2,
      this.startColor,
      this.endColor,
      this.borderColor = Colors.transparent,
      this.focusNode,
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
    return widget.onlyIcon ? 
    Ink(
      width: widget.radius,
      height: widget.radius,
      decoration: ShapeDecoration(
        gradient: widget.startColor != null && widget.endColor != null ? 
          LinearGradient(colors: [widget.startColor!, widget.endColor!]) : 
          LinearGradient(colors: [widget.borderColor!, widget.borderColor!]),
        shape: const CircleBorder(side: BorderSide(color: Colors.transparent)),
        shadows: const [BoxShadow(
          color: Colors.grey, blurStyle: BlurStyle.solid,
          blurRadius: 5
        )]
      ),
      child: IconButton(
        padding: EdgeInsets.zero,
        splashRadius: widget.radius / 2,
        iconSize: widget.radius / 2,
        icon: Icon(
          widget.icon,
          size: 24,
          color: widget.backgroundColor,
        ),
        onPressed: widget.onPressed,
      ),
    ) : DecoratedBox(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(widget.radius),
        gradient: widget.startColor != null && widget.endColor != null ? 
          LinearGradient(colors: [widget.startColor!, widget.endColor!]) : 
          LinearGradient(colors: [widget.backgroundColor!, widget.backgroundColor!])
      ),
      child: ElevatedButton(
        style: ButtonStyle(
          alignment: Alignment.center,
          padding: MaterialStateProperty.all(widget.padding),
          elevation: MaterialStateProperty.all(0),
          shape: MaterialStateProperty.all(
              RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(widget.radius),
                  side: BorderSide(
                      color: widget.borderColor!, width: widget.borderWidth))),
          backgroundColor:
              MaterialStateProperty.all(widget.backgroundColor!),
        ),
        onPressed: widget.onPressed,
        focusNode: widget.focusNode,
        child: Text(
          widget.text,
          textAlign: TextAlign.center,
          style: widget.textStyle,
        ),
      ),
    );
  }
}
