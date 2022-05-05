import 'package:flutter/material.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';

class SearchPage extends StatefulWidget {
  const SearchPage({Key? key}) : super(key: key);

  @override
  State<SearchPage> createState() => _SearchPageState();
}

class _SearchPageState extends State<SearchPage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
      scrollPadding: const EdgeInsets.only(bottom: 76, left: 10, top: 10, right: 10),
      child: Column(
        children: [
          Text("Search Page", style: Theme.of(context).textTheme.headlineMedium),
        ],
      )
    );
  }
}
