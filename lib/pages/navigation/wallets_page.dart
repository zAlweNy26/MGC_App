import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mgclinic/coin.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/widgets/custom_tile.dart';
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';

const apiKey = "229c128254698f92896c8f1b9036e248bcecb7e0";

class WalletsPage extends StatefulWidget {
  final SharedPreferences? sharedPreferences;

  const WalletsPage({Key? key, this.sharedPreferences}) : super(key: key);

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  final userPrefs = SharedPreferences.getInstance();
  List<Coin> coins = const [
    Coin(id: "XMR", name: "Monero"),
    Coin(id: "LTC", name: "Litecoin"),
    Coin(id: "BTC", name: "Bitcoin"),
    Coin(id: "ADA", name: "Cardano"),
    Coin(id: "TRTL", name: "TurtleCoin")
  ];
  List<TextEditingController> controllers = List.filled(5, TextEditingController());
  List<bool> enabledTextFields = List.filled(5, false);

  @override
  void initState() {
    super.initState();
    for (TextEditingController c in controllers) {
      c.text = "Wallet address";
    }
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Receiving Addresses",
                style: Theme.of(context).textTheme.headlineMedium)),
        ),
        Expanded(
          child: ListView.builder(
            itemCount: coins.length,
            itemBuilder: (ctx, index) {
              final coin = coins[index];
            
              return CustomTile(
                onTap: () async => await showPlatformDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      insetPadding: EdgeInsets.zero,
                      contentPadding: EdgeInsets.zero,
                      clipBehavior: Clip.antiAliasWithSaveLayer,
                      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
                      content: Builder(
                        builder: (ctx) => Container(
                          width: screen.width * 0.8,
                          height: screen.width * 0.8,
                          color: Colors.white,
                          padding: const EdgeInsets.only(
                              left: 10, right: 10, bottom: 10),
                          child: Column(
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                    icon: Icon(Icons.edit, color: appBlack),
                                    onPressed: () {
                                      setState(() {
                                        enabledTextFields[index] = !enabledTextFields[index];
                                      });
                                    }
                                  ),
                                  Expanded(
                                    child: TextField(
                                      style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(color: appBlack),
                                      controller: controllers[index],
                                      enabled: enabledTextFields[index],
                                      decoration: const InputDecoration(
                                        border: InputBorder.none
                                      ),
                                    ),
                                  ),
                                ],
                              ),
                              Expanded(
                                child: QrImage(
                                    backgroundColor: Colors.white,
                                    data:
                                        "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh"),
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  }
                ),
                padding: const EdgeInsets.all(10),
                children: [
                  SizedBox(
                    width: 56,
                    height: 56,
                    child: SvgPicture.asset(
                      "assets/coins/${coin.id.toLowerCase()}.svg",
                      semanticsLabel: coin.name,
                      width: 56,
                      height: 56
                    ),
                  ),
                  const SizedBox(width: 10),
                  Expanded(
                    child: Center(
                      child: Text("${coin.name} (${coin.id})",
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall),
                    ),
                  ),
                  const SizedBox(width: 10),
                  FaIcon(FontAwesomeIcons.qrcode,
                      size: 32,
                      color: Theme.of(context).backgroundColor),
                ],
              );
            }),
        ),
      ],
    );
  }
}
