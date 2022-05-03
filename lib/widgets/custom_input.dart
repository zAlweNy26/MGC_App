import 'package:flutter/material.dart';
import 'package:flymeet/constants.dart';

class CustomInputField extends StatefulWidget {
  final double borderRadius;
  final Color backgroundColor, textColor;
  final String? placeholder, fontFamily;
  final IconData? prefixIcon, suffixIcon;
  final TextInputType inputType;
  final EdgeInsets textPadding;
  final VoidCallback? onClickSuffix;
  final TextBaseline? textBaseline;
  final FontStyle fontStyle;
  final FontWeight fontWeight;
  final bool autofocus, autocorrect, enabled, obscureText, isShadow;
  final int? maxLength, minLines, maxLines;
  final ValueChanged<String>? onChanged, onSubmitted;
  final ValueChanged<String?>? onSaved;
  final GestureTapCallback? onTap;
  final TextEditingController? controller;

  const CustomInputField(
      {Key? key,
      required this.inputType,
      this.prefixIcon,
      this.controller,
      this.suffixIcon,
      this.textPadding = const EdgeInsets.only(left: 10, bottom: 5, right: 10),
      this.obscureText = false,
      this.backgroundColor = Colors.transparent,
      this.borderRadius = 20,
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
      this.onSubmitted,
      this.onSaved})
      : super(key: key);

  @override
  _CustomInputFieldState createState() => _CustomInputFieldState();
}

class _CustomInputFieldState extends State<CustomInputField> {
  bool isFocus = false, isObscured = true;
  String errorText = "";

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
        obscuringCharacter: '*',
        readOnly: !widget.enabled,
        validator: (val) {
          if (val == null || val.isEmpty) {
            setState(() {
              errorText = "Required";
            });
            return "";
          }
          bool emailValid = RegExp(
                  r"^((([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+(\.([a-z]|\d|[!#\$%&'\*\+\-\/=\?\^_`{\|}~]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])+)*)|((\x22)((((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(([\x01-\x08\x0b\x0c\x0e-\x1f\x7f]|\x21|[\x23-\x5b]|[\x5d-\x7e]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(\\([\x01-\x09\x0b\x0c\x0d-\x7f]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF]))))*(((\x20|\x09)*(\x0d\x0a))?(\x20|\x09)+)?(\x22)))@((([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|\d|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))\.)+(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])|(([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])([a-z]|\d|-|\.|_|~|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])*([a-z]|[\u00A0-\uD7FF\uF900-\uFDCF\uFDF0-\uFFEF])))$")
              .hasMatch(val);
          bool pswValid = RegExp(
                  r"^(?=.*[a-z])(?=.*[A-Z])(?=.*\d)(?=.*[@$!%*?&])[A-Za-z\d@$!%*?&]{8,}$")
              .hasMatch(val);
          if ((!pswValid && widget.inputType == TextInputType.visiblePassword) ||
            (!emailValid && widget.inputType == TextInputType.emailAddress)) {
            setState(() {
              errorText = "Not valid";
            });
            return "";
          }
          setState(() {
            errorText = "";
          });
          return null;
        },
        style: Theme.of(context).textTheme.bodyMedium,
        controller: widget.controller,
        obscureText: widget.obscureText && isObscured,
        keyboardType: widget.inputType,
        cursorColor: mainLight,
        autofocus: widget.autofocus,
        autocorrect: widget.autocorrect,
        focusNode: _focusNode,
        onChanged: widget.onChanged,
        onSaved: widget.onSaved,
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
          floatingLabelBehavior: FloatingLabelBehavior.always,
          floatingLabelStyle: Theme.of(context)
              .textTheme
              .titleSmall
              ?.copyWith(color: mainLight),
          hintText: "Your ${widget.placeholder}...",
          focusedBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: BorderSide(width: 2, color: mainLight)),
          focusedErrorBorder: OutlineInputBorder(
              borderRadius:
                  BorderRadius.all(Radius.circular(widget.borderRadius)),
              borderSide: BorderSide(width: 2, color: mainLight)),
          border: InputBorder.none,
          /*prefix: widget.prefixIcon != null ? Padding(
            padding: const EdgeInsets.only(right: 10),
            child: Icon(
              widget.prefixIcon,
              color: isFocus ? mainLight : Theme.of(context).backgroundColor
            ),
          ) : null,*/
          prefixIcon: widget.prefixIcon != null
              ? Icon(widget.prefixIcon,
                  color:
                      isFocus ? mainLight : Theme.of(context).backgroundColor)
              : null,
          suffixIcon: widget.obscureText
              ? IconButton(
                  splashRadius: 1,
                  onPressed: () => setState(() => isObscured = !isObscured),
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
