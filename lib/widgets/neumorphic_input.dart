import 'package:flutter_neumorphic/flutter_neumorphic.dart';
import 'package:flymeet/constants.dart';

class NeumorphicInput extends StatefulWidget {
  final String hintLabel;
  final TextInputType inputType;
  final TextEditingController editingController;
  final IconData? prefixIcon, suffixIcon;
  final bool obscure;

  const NeumorphicInput(
      {Key? key,
      required this.editingController,
      this.prefixIcon,
      this.suffixIcon,
      this.hintLabel = "",
      this.obscure = false,
      this.inputType = TextInputType.text})
      : super(key: key);

  @override
  State<NeumorphicInput> createState() => _NeumorphicInputState();
}

class _NeumorphicInputState extends State<NeumorphicInput> {
  /*final FocusNode _focusTF = FocusNode();
  bool textFocused = false;

  @override
  void initState() {
    super.initState();
    _focusTF.addListener(_onFocusChanged);
  }

  @override
  void dispose() {
    super.dispose();
    _focusTF.removeListener(_onFocusChanged);
    _focusTF.dispose();
  }

  void _onFocusChanged() => textFocused = !textFocused;

  @override
  Widget build(BuildContext context) {
    return Neumorphic(
      style: NeumorphicStyle(
          color: Colors.transparent,
          boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
          border:
              NeumorphicBorder(width: textFocused ? 2 : 0, color: mainLight)),
      child: TextField(
        decoration: InputDecoration(
          labelText: widget.hintLabel
        ),
        enableSuggestions: false,
        onTap: () => _focusTF.requestFocus(),
        focusNode: _focusTF,
      ),
    );
  }*/

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 20, top: 0, right: 0, bottom: 10),
          child: Text(widget.hintLabel, style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context), size: 20))
        ),
        Neumorphic(
          padding: const EdgeInsets.all(5),
          style: NeumorphicStyle(
            boxShape: NeumorphicBoxShape.roundRect(BorderRadius.circular(50)),
          ),
          child: TextField(
            obscureText: widget.obscure,
            controller: widget.editingController,
            keyboardType: widget.inputType,
            style: themedStyle(invert: !NeumorphicTheme.isUsingDark(context), size: 20),
            decoration: InputDecoration(
              prefixIcon: (widget.prefixIcon != null ? Icon(widget.prefixIcon) : null),
              prefixIconColor: mainLight,
              suffixIcon: (widget.suffixIcon != null ? Icon(widget.suffixIcon) : null),
              suffixIconColor: mainLight,
              hintText: widget.hintLabel,
              border: InputBorder.none,
              focusedBorder: InputBorder.none,
              enabledBorder: InputBorder.none,
              errorBorder: InputBorder.none,
              disabledBorder: InputBorder.none,
            ),
          ),
        ),
      ],
    );
  }
}
