import 'package:flutter/material.dart';
import 'package:flymeet/constants.dart';

class CustomInputField extends StatefulWidget {
  final double borderRadius;
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
      required this.inputType,
      this.prefixIcon,
      this.controller,
      this.suffixIcon,
      this.duration = const Duration(milliseconds: 500),
      this.textPadding = const EdgeInsets.symmetric(horizontal: 15),
      this.obscureText = false,
      this.backgroundColor = Colors.transparent,
      this.borderRadius = 100,
      this.textColor = Colors.grey,
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
  String text = "", errorText = "";

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
    return Material(
      color: widget.backgroundColor,
      shadowColor: Theme.of(context).backgroundColor,
      elevation: 3,
      borderRadius: BorderRadius.circular(widget.borderRadius),
      child: TextFormField(
        validator: (val) {
          if (val == null || val.isEmpty) {
            setState(() {
              errorText = "Required";
            });
            return "";
          }
          bool emailValid = RegExp(
                  r"^[a-zA-Z0-9.a-zA-Z0-9.!#$%&'*+-/=?^_`{|}~]+@[a-zA-Z0-9]+\.[a-zA-Z]+")
              .hasMatch(val);
          if (!emailValid && widget.inputType == TextInputType.emailAddress) {
            setState(() {
              errorText = "Not valid";
            });
            return "";
          }
          bool pswValid = RegExp(
                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
              .hasMatch(val);
          if (!pswValid && widget.inputType == TextInputType.visiblePassword) {
            setState(() {
              errorText = "Not valid";
            });
            return "";
          }
          setState(() {
            errorText = "";
          });
          return "";
        },
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        obscureText: widget.obscureText && isObscured,
        keyboardType: widget.inputType,
        cursorColor: mainLight,
        autofocus: widget.autofocus,
        autocorrect: widget.autocorrect,
        focusNode: _focusNode,
        enabled: widget.enabled,
        onChanged: widget.onChanged ?? (t) => setState(() => text = t),
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
          labelText: widget.placeholder! +
              (errorText.isNotEmpty ? " - $errorText" : ""),
          errorStyle: const TextStyle(height: 0),
          floatingLabelBehavior: errorText.isNotEmpty
              ? FloatingLabelBehavior.always
              : FloatingLabelBehavior.auto,
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: mainLight),
          hintText: "Your ${widget.placeholder}...",
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: BorderSide(width: 2, color: mainLight)),
          border: InputBorder.none,
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon,
                  color:
                      isFocus ? mainLight : Theme.of(context).backgroundColor)
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  splashRadius: 1,
                  onPressed: () => setState(
                        () => isObscured = !isObscured,
                      ),
                  icon: Icon(
                      isObscured
                          ? Icons.visibility_outlined
                          : Icons.visibility_off_outlined,
                      color: isFocus
                          ? mainLight
                          : Theme.of(context).backgroundColor))
              : (widget.suffixIcon != null
                  ? IconButton(
                      onPressed: widget.onClickSuffix,
                      icon: Icon(widget.suffixIcon,
                          color: isFocus
                              ? mainLight
                              : Theme.of(context).backgroundColor))
                  : null),
        ),
      ),
    );
  }
}
