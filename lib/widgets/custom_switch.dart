import 'package:flutter/material.dart';

class CustomSwitch extends FormField<bool> {

  CustomSwitch({
    Key? key, 
    FormFieldSetter<bool>? onSaved,
    bool initialValue = false,
    double size = 22,
    double iconSize = 16,
    Color selectedColor = Colors.transparent,
    Color selectedIconColor = Colors.black,
    Color borderColor = Colors.grey,
    IconData checkIcon = Icons.check,
    bool isRequired = true,
    Widget? trailing
  }) : super(key: key, 
    onSaved: onSaved,
    validator: (val) {
      if (val == null || val == !isRequired) {
        return "Required";
      }
    },
    initialValue: initialValue,
    builder: (FormFieldState<bool> state) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          state.hasError?
            Text(
              state.errorText!,
              style: Theme.of(state.context).textTheme.bodySmall!.copyWith(color: Colors.red, fontWeight: FontWeight.bold),
            ) :
            Container(),
          GestureDetector(
            onTap: () {
              state.didChange(!state.value!);
            },
            child: Row(
              children: [
                AnimatedContainer(
                  margin: const EdgeInsets.all(5),
                  duration: const Duration(milliseconds: 1000),
                  curve: Curves.fastLinearToSlowEaseIn,
                  decoration: BoxDecoration(
                    color: state.value! ? selectedColor : Colors.transparent,
                    borderRadius: BorderRadius.circular(5),
                    border: Border.all(
                      color: borderColor,
                      width: 2,
                    )
                  ),
                  width: size,
                  height: size,
                  child: state.value!
                      ? Icon(
                          Icons.check,
                          color: selectedIconColor,
                          size: iconSize,
                        )
                      : null,
                ),
                Flexible(child: trailing ?? Container())
              ],
            ),
          ),
        ],
      );
    }
  );
}