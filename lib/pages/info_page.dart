import 'package:flutter/material.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: PaddedScrollView(
          scrollPadding: const EdgeInsets.all(0),
          boxPadding: const EdgeInsets.only(top: 5, left: 10, right: 10, bottom: 10),
          absoluteChild: Align(
            alignment: Alignment.centerLeft,
            child: IconButton(
              splashRadius: 24,
              onPressed: () => Navigator.pop(context), 
              icon: FaIcon(
                FontAwesomeIcons.arrowLeftLong,
                size: 24, 
                color: Theme.of(context).backgroundColor
              )
            ),
          ),
          child: Column(
            children: [
              Align(
                alignment: Alignment.center,
                child: Text(
                  "Info Page",
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.headlineMedium
                ),
              )
            ],
          )
        ),
      )
    );
  }
}
