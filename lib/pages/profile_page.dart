import 'package:flutter/material.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 76), 
      child: Column(
        children: [
          Text("Profile Page", style: Theme.of(context).textTheme.headlineLarge),
        ],
      )
    );
  }
}
