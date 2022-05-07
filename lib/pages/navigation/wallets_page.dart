import 'dart:convert';
import 'package:dropdown_search/dropdown_search.dart';
import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:mgclinic/coin.dart';
import 'package:mgclinic/constants.dart';
import 'package:mgclinic/widgets/custom_input.dart';
import 'package:mgclinic/widgets/custom_tile.dart';
import 'package:http/http.dart' as http;
import 'package:qr_flutter/qr_flutter.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shimmer/shimmer.dart';

const apiKey = "229c128254698f92896c8f1b9036e248bcecb7e0";

class WalletsPage extends StatefulWidget {
  final SharedPreferences? sharedPreferences;

  const WalletsPage({Key? key, this.sharedPreferences}) : super(key: key);

  @override
  State<WalletsPage> createState() => _WalletsPageState();
}

class _WalletsPageState extends State<WalletsPage> {
  late final Future<List<Coin>> futureCoins;

  Future<List<Coin>> fetchCoins() async {
    List<Coin> coins = [];
    final data = await http.get(Uri.parse(
        'https://api.nomics.com/v1/currencies/ticker?key=$apiKey&ids=BTC,ETH,XMR,LTC,ADA,XRP&convert=EUR'));

    if (data.statusCode == 200) {
      for (var c in jsonDecode(data.body)) {
        Coin coin = Coin.fromJson(c);
        coins.add(coin);
      }
      return coins;
    } else {
      throw Exception('Failed to load album');
    }
  }

  @override
  void initState() {
    super.initState();
    futureCoins = fetchCoins();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;
    final prefs = widget.sharedPreferences ?? SharedPreferences.getInstance();

    return Column(
      children: [
        FittedBox(
            fit: BoxFit.scaleDown,
            child: Text("Receiving Addresses",
                style: Theme.of(context).textTheme.headlineMedium)),
        SizedBox(
          width: screen.width,
          height: screen.height - 152,
          child: FutureBuilder<List<Coin>>(
            future: futureCoins,
            builder: (context, snapshot) {
              if (snapshot.hasData) {
                return ListView.builder(
                    shrinkWrap: true,
                    itemCount: snapshot.data!.length + 1,
                    itemBuilder: (ctx, index) {
                      if (index == snapshot.data!.length) {
                        return Center(
                          child: IconButton(
                              iconSize: 40,
                              splashRadius: 32,
                              onPressed: () async => await showPlatformDialog(
                                  context: context,
                                  builder: (ctx) {
                                    return AlertDialog(
                                      insetPadding: EdgeInsets.zero,
                                      contentPadding: EdgeInsets.zero,
                                      clipBehavior: Clip.antiAliasWithSaveLayer,
                                      shape: RoundedRectangleBorder(
                                        borderRadius: BorderRadius.circular(10)
                                      ),
                                      content: Builder(
                                        builder: (ctx) => Container(
                                          width: screen.width * 0.8,
                                          height: screen.width * 0.8,
                                          padding: const EdgeInsets.all(10),
                                          child: Column(
                                            children: [
                                              DropdownSearch<String>(
                                                mode: Mode.MENU,
                                                showSearchBox: true,
                                                items: const ["Brazil", "Italia", "Tunisia", 'Canada'],
                                                dropdownSearchDecoration: InputDecoration(
                                                  labelStyle: Theme.of(context).textTheme.headlineSmall!.copyWith(color: primaryColor),
                                                  labelText: "Coin ID",
                                                ),
                                                dropdownSearchBaseStyle: Theme.of(context).textTheme.headlineSmall,
                                                onChanged: print,
                                              )
                                            ],
                                          ),
                                        ),
                                      ),
                                    );
                                  }),
                              icon: FaIcon(FontAwesomeIcons.plus,
                                  color: Theme.of(context).backgroundColor)),
                        );
                      }

                      final coin = snapshot.data![index];

                      return Dismissible(
                        key: UniqueKey(),
                        onDismissed: (dir) {
                          setState(() {});
                          // rimuovere da sharedpreferences
                        },
                        confirmDismiss: (DismissDirection direction) async {
                          if (direction == DismissDirection.startToEnd) {
                            return await showPlatformDialog(
                                context: context,
                                builder: (ctx) {
                                  return AlertDialog(
                                    title: const Text("Confirm"),
                                    content: const Text(
                                        "Are you sure you wish to delete this item?"),
                                    actions: <Widget>[
                                      TextButton(
                                          onPressed: () =>
                                              Navigator.of(ctx).pop(true),
                                          child: const Text("DELETE")),
                                      TextButton(
                                        onPressed: () =>
                                            Navigator.of(ctx).pop(false),
                                        child: const Text("CANCEL"),
                                      ),
                                    ],
                                  );
                                });
                          } else {
                            return true;
                          }
                        },
                        child: CustomTile(
                          onTap: () async => await showPlatformDialog(
                              context: context,
                              builder: (ctx) {
                                return AlertDialog(
                                  insetPadding: EdgeInsets.zero,
                                  contentPadding: EdgeInsets.zero,
                                  clipBehavior: Clip.antiAliasWithSaveLayer,
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(10)
                                  ),
                                  content: Builder(
                                    builder: (ctx) => Container(
                                      width: screen.width * 0.8,
                                      height: screen.width * 0.8,
                                      color: Colors.white,
                                      padding: const EdgeInsets.only(left: 10, right: 10, bottom: 10),
                                      child: Column(
                                        children: [
                                          Expanded(
                                            child: QrImage(
                                              backgroundColor: Colors.white,
                                              data: "bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh"
                                            ),
                                          ),
                                          SelectableText("bc1qxy2kgdygjrsqtzq2n0yrf2493p83kkfjhx0wlh", 
                                            textAlign: TextAlign.center,
                                            style: Theme.of(context).textTheme.titleMedium!.copyWith(color: appBlack)),
                                        ],
                                      ),
                                    ),
                                  ),
                                );
                              }),
                          padding: const EdgeInsets.all(10),
                          children: [
                            SizedBox(
                              width: 56,
                              height: 56,
                              child: SvgPicture.network(
                                coin.logoUrl,
                                semanticsLabel: coin.name,
                                width: 56,
                                height: 56,
                                placeholderBuilder: (BuildContext context) =>
                                    SizedBox(
                                        width: 56,
                                        height: 56,
                                        child: CircularProgressIndicator(
                                          color:
                                              Theme.of(context).backgroundColor,
                                        )),
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
                        ),
                        background: Container(
                          color: Colors.green,
                          alignment: Alignment.centerLeft,
                          child: Padding(
                            padding: const EdgeInsets.only(left: 26),
                            child: FaIcon(FontAwesomeIcons.pen,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                        ),
                        secondaryBackground: Container(
                          color: Colors.red,
                          alignment: Alignment.centerRight,
                          child: Padding(
                            padding: const EdgeInsets.only(right: 14),
                            child: FaIcon(FontAwesomeIcons.trash,
                                color:
                                    Theme.of(context).scaffoldBackgroundColor),
                          ),
                        ),
                      );
                    });
              } else if (snapshot.hasError) {
                return Text('${snapshot.error}');
              }
              return Shimmer.fromColors(
                baseColor: Colors.grey.shade400,
                highlightColor: Colors.grey,
                child: ListView.builder(
                    shrinkWrap: true,
                    itemCount: 6,
                    itemBuilder: (ctx, index) {
                      return Container(
                        width: 76,
                        height: 76,
                        padding: const EdgeInsets.all(10),
                        child: Row(
                          children: [
                            SizedBox(
                              width: 56,
                              height: 56,
                              child: CircularProgressIndicator(
                                color: Theme.of(context).backgroundColor,
                              ),
                            ),
                            const SizedBox(width: 20),
                            Expanded(
                              child: Padding(
                                padding:
                                    const EdgeInsets.symmetric(horizontal: 20),
                                child: Container(
                                  width: double.infinity,
                                  height: 24,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                            const SizedBox(width: 20),
                            FaIcon(FontAwesomeIcons.solidImage,
                                size: 32,
                                color: Theme.of(context).backgroundColor),
                          ],
                        ),
                      );
                    }),
              );
            },
          ),
        ),
      ],
    );
  }
}
