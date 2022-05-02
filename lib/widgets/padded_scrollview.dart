import 'package:flutter/material.dart';

class PaddedScrollView extends StatefulWidget {
  final EdgeInsets padding;
  final Widget child;

  const PaddedScrollView({
    Key? key,
    required this.padding,
    required this.child
  }) : super(key: key);

  @override
  _PaddedScrollViewState createState() => _PaddedScrollViewState();
}

class _PaddedScrollViewState extends State<PaddedScrollView> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    EdgeInsets partialPadding = MediaQuery.of(context).viewPadding;

    return SingleChildScrollView(
      physics: const BouncingScrollPhysics(),
      padding: EdgeInsets.only(
        left: widget.padding.left + partialPadding.left,
        right: widget.padding.right + partialPadding.right,
        top: widget.padding.top + partialPadding.top,
        bottom: widget.padding.bottom + partialPadding.bottom
      ),
      child: ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screen.width -
            partialPadding.left -
            partialPadding.right -
            widget.padding.left -
            widget.padding.right,
          minHeight: screen.height - 
            partialPadding.top - 
            partialPadding.bottom - 
            widget.padding.top - 
            widget.padding.bottom
        ),
        child: widget.child
      ),
    );
  }
}
