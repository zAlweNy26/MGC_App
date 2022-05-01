import 'package:flutter/material.dart';

class CustomSwitch extends StatefulWidget {
  final Function? onChange;
  final bool isChecked, likeCheckBox;
  final double size;
  final double iconSize;
  final Color selectedColor;
  final Color selectedIconColor;
  final Color borderColor;
  final IconData checkIcon;

  const CustomSwitch({
    Key? key, 
    this.isChecked = false,
    this.likeCheckBox = false,
    this.onChange,
    this.size = 22,
    this.iconSize = 16,
    this.selectedColor = Colors.transparent,
    this.selectedIconColor = Colors.black,
    this.borderColor = Colors.grey,
    this.checkIcon = Icons.check
  }) : super(key: key);

  @override
  _CustomSwitchState createState() => _CustomSwitchState();
}

class _CustomSwitchState extends State<CustomSwitch> {
  bool _isSelected = false;

  @override
  void initState() {
    _isSelected = widget.isChecked;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          _isSelected = !_isSelected;
          if (widget.onChange != null) widget.onChange!(_isSelected);
        });
      },
      child: AnimatedContainer(
        margin: const EdgeInsets.all(5),
        duration: const Duration(milliseconds: 1000),
        curve: Curves.fastLinearToSlowEaseIn,
        decoration: BoxDecoration(
          color: _isSelected ? widget.selectedColor : Colors.transparent,
          borderRadius: BorderRadius.circular(5),
          border: Border.all(
            color: widget.borderColor,
            width: 2,
          )
        ),
        width: widget.size,
        height: widget.size,
        child: _isSelected
            ? Icon(
                Icons.check,
                color: widget.selectedIconColor,
                size: widget.iconSize,
              )
            : null,
      ),
    );
  }
}
