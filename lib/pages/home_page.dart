import 'package:adaptive_theme/adaptive_theme.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/pages/navigation/booking_page.dart';
import 'package:mgclinic/pages/navigation/info_page.dart';
import 'package:mgclinic/pages/navigation/locations_page.dart';
import 'package:mgclinic/pages/navigation/wallets_page.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:shared_preferences/shared_preferences.dart';

class HomePage extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final PackageInfo packageInfo;

  const HomePage(
      {Key? key,
      required this.sharedPreferences,
      required this.packageInfo})
      : super(key: key);

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int currentPage = 1;
  bool isDark = false;
  static const List<Widget> navPages = [
    BookingPage(),
    InfoPage(),
    LocationsPage(),
    WalletsPage()
  ];
  final pagesController = PageController(initialPage: 1);
  final _scaffoldKey = GlobalKey<ScaffoldState>();

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    EdgeInsets partialPadding = MediaQuery.of(context).viewPadding;

    AppBar myAppBar = AppBar(
      centerTitle: true,
      backgroundColor: primaryColor,
      elevation: 5,
      leading: IconButton(
        tooltip: "Open sidebar menu",
        splashRadius: 24,
        icon: FaIcon(
          FontAwesomeIcons.bars,
          color: Theme.of(context).scaffoldBackgroundColor),
        onPressed: () => _scaffoldKey.currentState!.openDrawer()
      ),
      actions: [
        Padding(
          padding: const EdgeInsets.only(right: 10),
          child: IconButton(
            splashRadius: 24,
              onPressed: () {
                if (AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark) {
                  AdaptiveTheme.of(context).setLight();
                } else {
                  AdaptiveTheme.of(context).setDark();
                }
              },
              tooltip: "Change current theme",
              icon: FaIcon(
                  AdaptiveTheme.of(context).mode == AdaptiveThemeMode.dark
                      ? FontAwesomeIcons.solidSun
                      : FontAwesomeIcons.solidMoon,
                  color: Theme.of(context).backgroundColor)),
        ),
      ],
      title: Text("Malta & Gozo Clinic",
          style: Theme.of(context).textTheme.titleMedium),
    );

    return Scaffold(
      key: _scaffoldKey,
      body: SizedBox(
          height: screen.height - myAppBar.preferredSize.height - 52, // 52 = bottomnavbar height
          width: screen.width - partialPadding.left - partialPadding.right,
          child: PageView(
              physics: const BouncingScrollPhysics(),
              onPageChanged: (value) => setState(() => currentPage = value),
              controller: pagesController,
              children: navPages)),
      appBar: myAppBar,
      drawer: Drawer(
        elevation: 10,
        semanticLabel: "Sidebar menu",
        backgroundColor: secondaryColor,
        child: ListView(
          children: [
            ListTile(
              contentPadding: const EdgeInsets.symmetric(horizontal: 5),
              trailing: IconButton(
                onPressed: () => Navigator.pop(context),
                splashRadius: 24,
                iconSize: 24,
                padding: const EdgeInsets.all(0),
                tooltip: "Go back",
                icon: FaIcon(FontAwesomeIcons.arrowRightLong, color: Theme.of(context).scaffoldBackgroundColor),
              ),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidCircleQuestion, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: () => print("faq"),
              title: Text("F.A.Q.",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidFileLines, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: () => print("details"),
              title: Text("Fees details",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidCommentDots, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: () => print("feedbacks"),
              title: Text("Feedbacks",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidClock, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: () => print("clinic"),
              title: Text("Clinics hours",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),                                                                                                                         
            ListTile(
              leading: FaIcon(FontAwesomeIcons.solidStarHalfStroke, color: Theme.of(context).scaffoldBackgroundColor),
              onTap: () => Navigator.pushNamed(context, "/conditions"),
              title: Text("Conditions",
              style: Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.bold)),
            ),
          ],
        ),
      ),
      extendBody: true,
      bottomNavigationBar: CurvedNavigationBar(
        color: primaryColor,
        height: 52,
        backgroundColor: Colors.transparent,
        animationDuration: const Duration(milliseconds: 250),
        index: currentPage,
        items: [
          Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset("assets/nav/booking.svg", width: 28, height: 28)),
          Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset("assets/nav/info.svg", width: 28, height: 28)),
          Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset("assets/nav/locations.svg", width: 28, height: 28)),
          Padding(
              padding: const EdgeInsets.all(4),
              child: SvgPicture.asset("assets/nav/wallets.svg", width: 28, height: 28)),
        ],
        onTap: (index) {
          setState(() => currentPage = index);
          pagesController.animateToPage(index,
              duration: const Duration(milliseconds: 250),
              curve: Curves.easeInOut);
        },
      ),
    );
  }
}
