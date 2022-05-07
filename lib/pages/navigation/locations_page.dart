import 'package:flutter/material.dart';
import 'package:mgclinic/widgets/padded_scrollview.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
    scrollPadding:
        const EdgeInsets.only(bottom: 72, left: 10, top: 10, right: 10),
    child: Column(
      children: [
        Text("Locations Page",
            style: Theme.of(context).textTheme.headlineMedium),
      ],
    ));
  }
}
