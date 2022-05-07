import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mgclinic/widgets/custom_tile.dart';
import 'package:mgclinic/widgets/padded_scrollview.dart';
import 'package:url_launcher/url_launcher.dart';

class InfoPage extends StatefulWidget {
  const InfoPage({Key? key}) : super(key: key);

  @override
  State<InfoPage> createState() => _InfoPageState();
}

class _InfoPageState extends State<InfoPage> {
  void _launchUrl(String url) async {
    if (!await launchUrl(Uri.parse(url))) throw 'Could not launch $url';
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return SingleChildScrollView(
      child: SizedBox(
        height: screen.height - 122,
        width: screen.width,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              child: CustomTile(
                onTap: () => _launchUrl("mailto:maltagozochiropractic@hotmail.com?subject=Info&body=Info"),
                padding: const EdgeInsets.all(10),
                children: [
                  FaIcon(FontAwesomeIcons.solidEnvelope, size: 64, color: Theme.of(context).backgroundColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("maltagozochiropractic@hotmail.com", style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomTile(
                onTap: () => _launchUrl("tel:+356-9964-8982"),
                padding: const EdgeInsets.all(10),
                children: [
                  FaIcon(FontAwesomeIcons.phone, size: 64, color: Theme.of(context).backgroundColor),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("+356 9964 8982", style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomTile(
                onTap: () => _launchUrl("https://t.me/maltaGozoChiropractic"),
                padding: const EdgeInsets.all(10),
                children: [
                  const FaIcon(FontAwesomeIcons.telegram, size: 64, color: Color(0xFF0088CC)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Telegram", style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomTile(
                onTap: () => _launchUrl("skype:Malta&GozoChiropractic?call"),
                padding: const EdgeInsets.all(10),
                children: [
                  const FaIcon(FontAwesomeIcons.skype, size: 64, color: Color(0xFF009EDC)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("Skype", style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  )
                ],
              ),
            ),
            Expanded(
              child: CustomTile(
                onTap: () => _launchUrl("whatsapp://wa.me/35699648982"),
                padding: const EdgeInsets.all(10),
                children: [
                  const FaIcon(FontAwesomeIcons.whatsapp, size: 64, color: Color(0xFF25D366)),
                  const SizedBox(width: 10),
                  Expanded(
                    child: FittedBox(
                      fit: BoxFit.scaleDown,
                      child: Text("WhatsApp", style: Theme.of(context).textTheme.headlineLarge),
                    ),
                  )
                ],
              ),
            ),
          ],
        ),
      )
    );
  }
}
