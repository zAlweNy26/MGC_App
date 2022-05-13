import 'package:flutter/material.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/widgets/custom_tile.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Find a clinic", style: Theme.of(context).textTheme.headlineMedium)
          ),
        ),
        Expanded(child: Container()),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 20),
          child: Container(
            decoration: BoxDecoration(
              border: Border.all(
                color: primaryColor,
                width: 2
              ),
              borderRadius: BorderRadius.circular(20)
            ),
            padding: const EdgeInsets.all(10),
            child: Column(
              children: [
                CustomTile(
                  children: [
                    Text("Mellieha (Malta)",
                          textAlign: TextAlign.start,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text("Monday 2pm - 6:30pm",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall),
                    ),
                  ],
                ),
                CustomTile(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  children: [
                    Text("San Gwann (Malta)",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text("Thursday 2pm - 6:30pm",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall),
                    ),
                  ],
                ),
                CustomTile(
                  children: [
                    Text("Xewkjia (Gozo)",
                        textAlign: TextAlign.start,
                        style: Theme.of(context)
                            .textTheme
                            .titleSmall),
                    const SizedBox(width: 5),
                    Expanded(
                      child: Text("Tuesday 2pm - 7:30pm\nFriday - by appointment",
                          textAlign: TextAlign.end,
                          style: Theme.of(context)
                              .textTheme
                              .titleSmall),
                    ),
                  ],
                ),
              ],
            ),
          ),
        )
      ]
    );
  }
}
