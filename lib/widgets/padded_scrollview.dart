import 'package:flutter/material.dart';

class PaddedScrollView extends StatefulWidget {
  final EdgeInsets scrollPadding, boxPadding;
  final Widget? child, absoluteChild;
  final ScrollPhysics? physics;

  const PaddedScrollView({
    Key? key,
    required this.scrollPadding,
    required this.child,
    this.absoluteChild,
    this.boxPadding = const EdgeInsets.all(0),
    this.physics = const BouncingScrollPhysics()
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
      physics: widget.physics,
      padding: widget.scrollPadding + partialPadding,
      child: widget.absoluteChild != null ? Stack(
        children: [
          widget.absoluteChild!,
          ConstrainedBox(
            constraints: BoxConstraints(
              minWidth: screen.width -
                partialPadding.left -
                partialPadding.right -
                widget.scrollPadding.left -
                widget.scrollPadding.right,
              minHeight: screen.height - 
                partialPadding.top - 
                partialPadding.bottom - 
                widget.scrollPadding.top - 
                widget.scrollPadding.bottom
            ),
            child: Padding(
              padding: widget.boxPadding,
              child: widget.child,
            )
          ),
        ],
      ) :
      ConstrainedBox(
        constraints: BoxConstraints(
          minWidth: screen.width -
            partialPadding.left -
            partialPadding.right -
            widget.scrollPadding.left -
            widget.scrollPadding.right,
          minHeight: screen.height - 
            partialPadding.top - 
            partialPadding.bottom - 
            widget.scrollPadding.top - 
            widget.scrollPadding.bottom
        ),
        child: Padding(
          padding: widget.boxPadding,
          child: widget.child,
        )
      ),
    );
  }
}
