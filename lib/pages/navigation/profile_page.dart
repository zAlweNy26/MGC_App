import 'package:flutter/material.dart';
import 'package:flymeet/widgets/padded_scrollview.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class ProfilePage extends StatefulWidget {
  const ProfilePage({Key? key}) : super(key: key);

  @override
  State<ProfilePage> createState() => _ProfilePageState();
}

class _ProfilePageState extends State<ProfilePage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
      scrollPadding: const EdgeInsets.only(bottom: 76),
      boxPadding: const EdgeInsets.only(top: 5, left: 10, right: 10),
      absoluteChild: Align(
        alignment: Alignment.centerRight,
        child: IconButton(
          splashRadius: 24,
          onPressed: () => Navigator.pushNamed(context, '/settings'), 
          icon: FaIcon(
            FontAwesomeIcons.gear,
            size: 24, 
            color: Theme.of(context).backgroundColor
          )
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Align(
            alignment: Alignment.center,
            child: Text(
              "Profile Page",
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.headlineMedium
            ),
          )
          /*Expanded(
            child: Material(
              shadowColor: Theme.of(context).backgroundColor,
              elevation: 3,
              clipBehavior: Clip.antiAlias,
              color: Theme.of(context)
                  .scaffoldBackgroundColor,
              shape: RoundedRectangleBorder(
                  borderRadius:
                      BorderRadius.circular(10)),
              child: Stack(
                children: [
                  CountryCodePicker(
                    emptySearchBuilder: (bc) {
                      return Center(
                        child: Padding(
                          padding:
                              const EdgeInsets.all(10),
                          child: Text(
                            "No country with\nthis name was found",
                            textAlign: TextAlign.center,
                            style: Theme.of(context)
                                .textTheme
                                .titleSmall,
                          ),
                        ),
                      );
                    },
                    boxDecoration: BoxDecoration(
                        borderRadius:
                            BorderRadius.circular(10),
                        border: Border.all(
                            width: 2, color: mainLight),
                        color: Theme.of(context)
                            .scaffoldBackgroundColor),
                    textStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    dialogTextStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    searchStyle: Theme.of(context)
                        .textTheme
                        .bodyMedium,
                    closeIcon: const Icon(
                        Icons.close_rounded,
                        size: 24),
                    dialogSize: Size(
                        screen.width * 0.75,
                        (screen.height -
                                partialPadding.top -
                                partialPadding.bottom) *
                            0.75),
                    barrierColor: Colors.transparent,
                    padding: const EdgeInsets.only(
                        top: 17.5, bottom: 5.5),
                    initialSelection: "IT",
                    onChanged: (cc) => setState(
                        () => countryCode = cc),
                    showCountryOnly: true,
                    showOnlyCountryWhenClosed: true,
                    alignLeft: true,
                  ),
                  Padding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 10),
                    child: Text(
                      "Nationality",
                      style: Theme.of(context)
                          .textTheme
                          .titleSmall
                          ?.copyWith(
                              color: mainLight,
                              fontSize: 13),
                    ),
                  )
                ],
              )))*/
        ],
      ),
    );
  }
}
