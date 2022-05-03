import 'package:flutter/material.dart';

class PaddedScrollView extends StatefulWidget {
  final EdgeInsets scrollPadding, boxPadding;
  final Widget? child, absoluteChild;

  const PaddedScrollView({
    Key? key,
    required this.scrollPadding,
    this.absoluteChild,
    this.boxPadding = const EdgeInsets.all(0),
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
      padding: widget.scrollPadding + partialPadding,
      child: ConstrainedBox(
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
        child: widget.absoluteChild != null ?
          Stack(
            children: [
              widget.absoluteChild!,
              Padding(
                padding: widget.boxPadding + partialPadding,
                child: widget.child,
              )
            ],
          )
        : Padding(
          padding: widget.boxPadding,
          child: widget.child,
        )
      ),
    );
  }
}
