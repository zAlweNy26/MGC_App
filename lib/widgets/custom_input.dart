import 'package:flutter/material.dart';
import 'package:flymeet/constants.dart';

class CustomInputField extends StatefulWidget {
  final double width, borderRadius;
  final Color backgroundColor, textColor;
  final String? placeholder, fontFamily;
  final IconData? prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets textPadding;
  final Duration duration;
  final VoidCallback? onClickSuffix;
  final TextBaseline? textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final int? maxLength, minLines, maxLines;
  final ValueChanged<String>? onChanged, onSubmitted;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;

  const CustomInputField(
      {Key? key,
      required this.width,
      required this.inputType,
      this.prefixIcon,
      this.controller,
      this.suffixIcon,
      this.duration = const Duration(milliseconds: 500),
      this.textPadding = const EdgeInsets.symmetric(horizontal: 15, vertical: 13),
      this.obscureText = false,
      this.backgroundColor = Colors.white,
      this.borderRadius = 100,
      this.textColor = Colors.black,
      this.placeholder = "",
      this.isShadow = true,
      this.onClickSuffix,
      this.textBaseline,
      this.fontFamily,
      this.fontStyle = FontStyle.normal,
      this.fontWeight = FontWeight.normal,
      this.autofocus = false,
      this.autocorrect = false,
      this.enabled = true,
      this.maxLength,
      this.maxLines,
      this.minLines,
      this.onChanged,
      this.onTap,
      this.onSubmitted})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isFocus = false, isObscured = true;

  final _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _focusNode.addListener(() {
      setState(() {
        isFocus = _focusNode.hasFocus;
      });
    });
  }

  @override
  void dispose() {
    _focusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: widget.width,
      child: Material(
        color: widget.backgroundColor,
        elevation: 5,
        borderRadius: BorderRadius.circular(widget.borderRadius),
        child: TextFormField(
          validator: (val) {
            if (val == null || val.isEmpty) {
              return 'Required';
            }
            return null;
          },
          style: Theme.of(context).textTheme.bodyText2,
          controller: widget.controller,
          obscureText: widget.obscureText && isObscured,
          keyboardType: widget.inputType,
          cursorColor: mainLight,
          autofocus: widget.autofocus,
          autocorrect: widget.autocorrect,
          focusNode: _focusNode,
          enabled: widget.enabled,
          onChanged: widget.onChanged,
          onTap: () {
            setState(() {
              isFocus = true;
            });
            if (widget.onTap != null) widget.onTap!();
          },
          onFieldSubmitted: (t) {
            setState(() {
              isFocus = false;
            });
            if (widget.onSubmitted != null) widget.onSubmitted!(t);
          },
          textInputAction: TextInputAction.done,
          decoration: InputDecoration(
            contentPadding: widget.textPadding,
            hintText: "Your ${widget.placeholder}...",
            focusedBorder: OutlineInputBorder(
                borderRadius: const BorderRadius.all(Radius.circular(100)),
                borderSide: BorderSide(width: 2, color: mainLight)),
            border: InputBorder.none,
            prefixIcon: widget.prefixIcon != null
                ? Icon(widget.prefixIcon,
                    color: isFocus ? mainLight : Colors.grey)
                : null,
            suffixIcon: widget.obscureText ? 
              IconButton(
                splashRadius: 1,
                onPressed: () => setState(
                  () => isObscured = !isObscured,
                ),
                icon: Icon(
                  isObscured ? Icons.visibility_outlined : Icons.visibility_off_outlined, 
                  color: isFocus ? mainLight : Colors.grey)
              ) : (widget.suffixIcon != null ? IconButton(
                onPressed: widget.onClickSuffix,
                icon: Icon(widget.suffixIcon, color: isFocus ? mainLight : Colors.grey)
              )
              : null),
          ),
        ),
      ),
    );
  }
}
