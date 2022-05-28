import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mgclinic/coin.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/widgets/coin_tale.dart';
import 'package:mgclinic/widgets/custom_input.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletsPage extends StatefulWidget {
  final SharedPreferences? sharedPreferences;

  const WalletsPage({Key? key, this.sharedPreferences}) : super(key: key);

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  late List<String> wallets;
  late SharedPreferences userPrefs;
  Map<Coin, TextEditingController> coins = {
    const Coin(id: "XMR", name: "Monero"): TextEditingController(text: "Wallet Address"),
    const Coin(id: "LTC", name: "Litecoin"): TextEditingController(text: "Wallet Address"),
    const Coin(id: "BTC", name: "Bitcoin"): TextEditingController(text: "Wallet Address"),
    const Coin(id: "ADA", name: "Cardano"): TextEditingController(text: "Wallet Address"),
    const Coin(id: "TRTL", name: "TurtleCoin"): TextEditingController(text: "Wallet Address")
  };

  @override
  void initState() {
    super.initState();
    userPrefs = widget.sharedPreferences!;
    wallets = userPrefs.getStringList("wallets") ?? List.from(coins.keys.map((coin) => "${coin.id}| "));
    for (String wallet in wallets) {
      if (wallet.isEmpty) continue;
      String walletCoin = wallet.split("|")[0];
      String walletAddress = wallet.split("|")[1];
      coins.forEach((coin, controller) {
        if (coin.id == walletCoin) {
          controller.text = walletAddress;
        }
      });
    }
  }

  @override
  Widget build(BuildContext context) {

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(5),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Receiving Addresses",
                  style: Theme.of(context).textTheme.titleLarge)),
        ),
        for (MapEntry<Coin, TextEditingController> pair in coins.entries)
          Expanded(
            child: Dismissible(
              key: Key(pair.key.id),
              background: Container(
                color: secondaryColor,
                alignment: Alignment.centerLeft,
                child: Padding(
                  padding: const EdgeInsets.only(left: 20),
                  child: FaIcon(FontAwesomeIcons.pen,
                      color:
                          Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              secondaryBackground: Container(
                color: secondaryColor,
                alignment: Alignment.centerRight,
                child: Padding(
                  padding: const EdgeInsets.only(right: 20),
                  child: FaIcon(FontAwesomeIcons.pen,
                      color:
                          Theme.of(context).scaffoldBackgroundColor),
                ),
              ),
              confirmDismiss: (DismissDirection direction) async {
                return await showPlatformDialog(
                  context: context,
                  builder: (ctx) {
                    return AlertDialog(
                      backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                      content: CustomInputField(
                        controller: pair.value,
                        inputType: TextInputType.text,
                        backgroundColor: Theme.of(context).scaffoldBackgroundColor,
                        placeholder: "Wallet Address",
                      ),
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20)),
                      contentPadding: const EdgeInsets.all(10),
                      actions: [
                        TextButton(
                          style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                            onPressed: () async {
                              setState(() => wallets[coins.keys.toList().indexOf(pair.key)] = "${pair.key.id}|${pair.value.text}");
                              await userPrefs.setStringList("wallets", wallets);
                              Navigator.of(ctx).pop(false);
                            },
                            child: const Text("CONFIRM")),
                        TextButton(
                          style: TextButton.styleFrom(shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(20))),
                          onPressed: () =>
                              Navigator.of(ctx).pop(false),
                          child: const Text("CANCEL"),
                        ),
                      ],
                    );
                  }
                );
              },
              child: CoinTale(
                padding: const EdgeInsets.all(10),
                coin: "assets/coins/${pair.key.id.toLowerCase()}.svg",
                title: "${pair.key.name} (${pair.key.id})",
                subtitle: wallets[coins.keys.toList().indexOf(pair.key)].split("|")[1],
              ),
            ),
          )
      ],
    );
  }
}
