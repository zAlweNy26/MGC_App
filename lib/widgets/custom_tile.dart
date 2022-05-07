import 'package:flutter/material.dart';

class CustomTile extends StatefulWidget {
  final EdgeInsets padding;
  final List<Widget> children;
  final VoidCallback? onTap;

  const CustomTile({
    Key? key,
    required this.children,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  _CustomTileState createState() => _CustomTileState();
}

class _CustomTileState extends State<CustomTile> {
  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: widget.onTap,
      child: Padding(
        padding: widget.padding,
        child: Row(
          children: widget.children
        ),
      )
    );
  }
}
