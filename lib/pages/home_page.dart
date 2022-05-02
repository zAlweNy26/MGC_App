import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flymeet/constants.dart';
import 'package:flymeet/pages/chats_page.dart';
import 'package:flymeet/pages/profile_page.dart';
import 'package:flymeet/pages/search_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  static const List<Widget> navPages = [
    ChatsPage(),
    SearchPage(),
    ProfilePage()
  ];
  final pagesController = PageController(initialPage: 1);

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: SizedBox(
        height: screen.height,
        width: screen.width,
        child: PageView(
          physics: const BouncingScrollPhysics(),
          onPageChanged: (value) => setState(() => currentPage = value),
          controller: pagesController,
          children: navPages
        )
      ),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: mainLight,
        height: 56,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 300),
        index: currentPage,
        items: [
          Padding(
              padding: const EdgeInsets.all(8),
              child: FaIcon(FontAwesomeIcons.solidComments,
                  size: 24, color: Theme.of(context).scaffoldBackgroundColor)),
          Padding(
              padding: const EdgeInsets.all(8),
              child: FaIcon(FontAwesomeIcons.house,
                  size: 24, color: Theme.of(context).scaffoldBackgroundColor)),
          Padding(
              padding: const EdgeInsets.all(8),
              child: FaIcon(FontAwesomeIcons.solidUser,
                  size: 24, color: Theme.of(context).scaffoldBackgroundColor)),
        ],
        onTap: (index) {
          setState(() => currentPage = index);
          pagesController.animateToPage(index, duration: const Duration(milliseconds: 300), curve: Curves.easeInOut);
        },
      ),
    );
  }
}
