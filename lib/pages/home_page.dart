import 'package:flutter/material.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: const Center(child: Text("Home Page"))
      ),
      extendBody: true,
    );
  }
}
