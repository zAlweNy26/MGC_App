import 'dart:io';

import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/custom_gesture_recognizer.dart';
import 'package:mgclinic/widgets/custom_tile.dart';
import 'package:webview_flutter/webview_flutter.dart';

class LocationsPage extends StatefulWidget {
  const LocationsPage({Key? key}) : super(key: key);

  @override
  State<LocationsPage> createState() => _LocationsPageState();
}

class _LocationsPageState extends State<LocationsPage> {
  @override
   void initState() {
     super.initState();
     if (Platform.isAndroid) WebView.platform = AndroidWebView();
   }
   
  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.stretch,
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Find a clinic", style: Theme.of(context).textTheme.titleLarge)
          ),
        ),
        //Expanded(child: Container()),
        Expanded(child: WebView(
          navigationDelegate: (navigation) {
            if (navigation.url.contains("google.com")) {
              return NavigationDecision.prevent;
            }
            return NavigationDecision.navigate;
          },
          gestureRecognizers: {
            Factory(() => PlatformViewVerticalGestureRecognizer()),
          },
          gestureNavigationEnabled: true,
          javascriptMode: JavascriptMode.unrestricted,
          initialUrl: "https://www.google.com/maps/d/embed?mid=1XY2pqaNvfVth-jHVqdK_aXyEqUQ&ehbc=2E312F",
        )),
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
