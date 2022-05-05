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
      scrollPadding: const EdgeInsets.only(bottom: 76, left: 10, top: 10, right: 10),
      child: Column(
        children: [
          Text("Chats Page", style: Theme.of(context).textTheme.headlineMedium),
        ],
      )
    );
  }
}
