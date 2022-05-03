import 'package:flutter/material.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';

class ChatsPage extends StatefulWidget {
  const ChatsPage({Key? key}) : super(key: key);

  @override
  State<ChatsPage> createState() => _ChatsPageState();
}

class _ChatsPageState extends State<ChatsPage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
      scrollPadding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 76), 
      child: Column(
        children: [
          Text("Chats Page", style: Theme.of(context).textTheme.headlineLarge),
        ],
      )
    );
  }
}
