import 'package:flutter/material.dart';
import 'package:flutter_platform_widgets/flutter_platform_widgets.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:qr_flutter/qr_flutter.dart';

class CoinTale extends StatefulWidget {
  final EdgeInsets padding;
  final String coin, title, subtitle;
  final VoidCallback? onTap;
  final bool isEnabled, isTextFieldEnabled;

  const CoinTale({
    Key? key,
    required this.coin,
    required this.title,
    this.subtitle = "",
    this.isEnabled = true,
    this.isTextFieldEnabled = false,
    this.onTap,
    this.padding = const EdgeInsets.all(0),
  }) : super(key: key);

  @override
  _CoinTaleState createState() => _CoinTaleState();
}

class _CoinTaleState extends State<CoinTale> {
  late bool _isEnabled;

  @override
  void initState() {
    _isEnabled = widget.isEnabled;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Size screen = MediaQuery.of(context).size;

    return InkWell(
        onTap: _isEnabled
            ? () async => await showPlatformDialog(
                context: context,
                builder: (ctx) {
                  return AlertDialog(
                    insetPadding: EdgeInsets.zero,
                    contentPadding: EdgeInsets.zero,
                    clipBehavior: Clip.antiAliasWithSaveLayer,
                    shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10)),
                    content: Builder(
                      builder: (ctx) => Container(
                        width: screen.width * 0.8,
                        height: screen.width * 0.8,
                        color: Colors.white,
                        padding: const EdgeInsets.all(10),
                        child: QrImage(
                          backgroundColor: Colors.white,
                          data: widget.subtitle
                        )
                      ),
                    ),
                  );
                })
            : null,
        child: Padding(
          padding: widget.padding,
          child: Row(children: [
            Expanded(
              flex: 2,
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: SvgPicture.asset(
                  widget.coin,
                  semanticsLabel: widget.title,
                  width: 256,
                  height: 256,
                ),
              ),
            ),
            const SizedBox(width: 10),
            Expanded(
              flex: 6,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  FittedBox(
                  fit: BoxFit.scaleDown,
                  child: Text(widget.title,
                      style: Theme.of(context).textTheme.titleLarge)),
                  Text(widget.subtitle, textAlign: TextAlign.center,
                    overflow: TextOverflow.ellipsis,
                    style: Theme.of(context).textTheme.labelMedium),
                ],
              )
            ),
            const SizedBox(width: 10),
            Expanded(
              child: FittedBox(
                fit: BoxFit.scaleDown,
                child: FaIcon(FontAwesomeIcons.qrcode,
                    size: 48, color: Theme.of(context).backgroundColor),
              ),
            ),
          ]),
        ));
  }
}
