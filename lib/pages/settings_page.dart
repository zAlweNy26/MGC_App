import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flymeet/constants.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:package_info_plus/package_info_plus.dart';
import 'package:settings_ui/settings_ui.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SettingsPage extends StatefulWidget {
  final SharedPreferences sharedPreferences;
  final PackageInfo? packageInfo;

  const SettingsPage({Key? key, required this.sharedPreferences, this.packageInfo})
      : super(key: key);

  @override
  State<SettingsPage> createState() => _SettingsPageState();
}

class _SettingsPageState extends State<SettingsPage> {
  @override
  Widget build(BuildContext context) {
    final pInfo = widget.packageInfo;
    Size screen = MediaQuery.of(context).size;

    return Scaffold(
      body: Container(
          height: screen.height,
          width: screen.width,
          padding: MediaQuery.of(context).viewPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  IconButton(
                      splashRadius: 24,
                      onPressed: () => Navigator.pop(context),
                      icon: FaIcon(FontAwesomeIcons.arrowLeftLong,
                          size: 24, color: Theme.of(context).backgroundColor)),
                  Center(
                    child: Text("Settings",
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.headlineMedium),
                  ),
                  IconButton(
                      splashRadius: 24,
                      onPressed: () => Navigator.pushNamed(context, '/info'),
                      icon: FaIcon(FontAwesomeIcons.circleInfo,
                          size: 24, color: Theme.of(context).backgroundColor)),
                ],
              ),
              SettingsList(
                lightTheme: SettingsThemeData(
                    settingsListBackground: appWhite,
                    settingsSectionBackground: appWhite,
                    titleTextColor: mainLight,
                    trailingTextColor: mainLight,
                    leadingIconsColor: mainLight),
                darkTheme: SettingsThemeData(
                    settingsListBackground: appBlack,
                    settingsSectionBackground: appBlack,
                    titleTextColor: mainLight,
                    trailingTextColor: mainLight,
                    leadingIconsColor: mainLight),
                shrinkWrap: true,
                brightness: Theme.of(context).brightness,
                applicationType: ApplicationType.both,
                physics: const BouncingScrollPhysics(),
                sections: [
                  SettingsSection(
                    title: Text('General',
                        style: Theme.of(context)
                            .textTheme
                            .bodyLarge!
                            .copyWith(fontWeight: FontWeight.bold)),
                    tiles: [
                      SettingsTile.navigation(
                        leading: const Icon(Icons.language),
                        title: Text('Language',
                            style: Theme.of(context).textTheme.bodyMedium),
                        value: Text('English',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: mainLight,
                                    fontWeight: FontWeight.bold)),
                      ),
                      SettingsTile.navigation(
                        leading: const Icon(Icons.format_paint),
                        title: Text('Theme', style: Theme.of(context).textTheme.bodyMedium),
                        value: Text('System',
                            style: Theme.of(context)
                                .textTheme
                                .labelMedium!
                                .copyWith(
                                    color: mainLight,
                                    fontWeight: FontWeight.bold)),
                      ),
                    ],
                  ),
                  CustomSettingsSection(
                    child: Column(
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(vertical: 20),
                          child: SvgPicture.asset(
                            "assets/new_email.svg",
                            width: 48, 
                            semanticsLabel: "App logo"
                          ),
                        ),
                        Text(
                          widget.packageInfo != null ? "${pInfo!.appName} v${pInfo.version} (${pInfo.buildNumber})" : "App v1.0.0 (1)",
                          style: Theme.of(context).textTheme.bodyMedium
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ],
          )),
    );
  }
}
