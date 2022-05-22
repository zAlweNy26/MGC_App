import 'package:flutter/material.dart';
import 'package:mgclinic/coin.dart';
import 'package:mgclinic/widgets/coin_tale.dart';
import 'package:shared_preferences/shared_preferences.dart';

class WalletsPage extends StatefulWidget {
  final SharedPreferences? sharedPreferences;

  const WalletsPage({Key? key, this.sharedPreferences}) : super(key: key);

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  Map<TextEditingController, Coin> coins = {
    TextEditingController(text: "Wallet Address"): const Coin(id: "XMR", name: "Monero"),
    TextEditingController(text: "Wallet Address"): const Coin(id: "LTC", name: "Litecoin"),
    TextEditingController(text: "Wallet Address"): const Coin(id: "BTC", name: "Bitcoin"),
    TextEditingController(text: "Wallet Address"): const Coin(id: "ADA", name: "Cardano"),
    TextEditingController(text: "Wallet Address"): const Coin(id: "TRTL", name: "TurtleCoin")
  };

  @override
  Widget build(BuildContext context) {
    final userPrefs = widget.sharedPreferences;

    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.only(left: 5, right: 5, top: 5),
          child: FittedBox(
              fit: BoxFit.scaleDown,
              child: Text("Receiving Addresses",
                  style: Theme.of(context).textTheme.headlineMedium)),
        ),
        for (MapEntry<TextEditingController, Coin> pair in coins.entries)
          Expanded(
            child: CoinTale(
              padding: const EdgeInsets.all(10),
              coin: "assets/coins/${pair.value.id.toLowerCase()}.svg",
              controller: pair.key,
              title: "${pair.value.name} (${pair.value.id})",
              subtitle: pair.key.text
            ),
          )
      ],
    );
  }
}
