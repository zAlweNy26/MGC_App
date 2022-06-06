// You have generated a new plugin project without
// specifying the `--platforms` flag. A plugin project supports no platforms is generated.
// To add platforms, run `flutter create -t plugin --platforms <platforms> .` under the same
// directory. You can also find a detailed instruction on how to add platforms in the `pubspec.yaml` at https://flutter.dev/docs/development/packages-and-plugins/developing-packages#plugin-platforms.

import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomNumberCaptcha {
  static Future<bool> show(
    context, {
    String titleText = 'Enter correct number',
    String placeholderText = 'Enter number...',
    String checkCaption = 'Check',
    String invalidText = 'Invalid Code',
    Color? accentColor,
    Color? backgroundColor,
  }) async {
    bool? result = await showDialog(
      context: context,
      builder: (context) {
        return CustomNumberCaptchaDialog(
          titleText,
          placeholderText,
          checkCaption,
          invalidText,
          accentColor: accentColor,
          backgroundColor: backgroundColor,
        );
      },
    );
    if (result == true) {
      return true;
    }
    return false;
  }
}

class CustomNumberCaptchaDialog extends StatefulWidget {
  const CustomNumberCaptchaDialog(
    this.titleText,
    this.placeholderText,
    this.checkCaption,
    this.invalidText, {
    Key? key,
    this.accentColor,
    this.backgroundColor,
  }) : super(key: key);

  final String titleText;
  final String placeholderText;
  final String checkCaption;
  final String invalidText;
  final Color? accentColor, backgroundColor;

  @override
  State<CustomNumberCaptchaDialog> createState() => _CustomNumberCaptchaDialogState();
}

class _CustomNumberCaptchaDialogState extends State<CustomNumberCaptchaDialog> {
  final TextEditingController textController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  String code = '';

  bool? isValid;

  @override
  initState() {
    generateCode();
    super.initState();
  }

  void generateCode() {
    Random random = Random();
    code = (random.nextInt(9000) + 1000).toString();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Container(
        width: MediaQuery.of(context).size.width * 0.75,
        padding: const EdgeInsets.all(20),
        decoration: BoxDecoration(
          color: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          borderRadius: const BorderRadius.all(Radius.circular(10)),
        ),
        child: Material(
          color: widget.backgroundColor ?? Theme.of(context).scaffoldBackgroundColor,
          child: Form(
            key: _formKey,
            child: Column(
              mainAxisSize: MainAxisSize.min,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 10),
                  child: Text(
                    widget.titleText,
                    style: TextStyle(
                      fontSize: 20,
                      fontWeight: FontWeight.bold,
                      color: widget.accentColor ?? Colors.blue,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    NumberCaptcha(code),
                    SizedBox(
                      height: 40,
                      width: 40,
                      child: Material(
                        child: InkWell(
                          onTap: () {
                            generateCode();
                          },
                          child: Icon(
                            Icons.refresh,
                            color: widget.accentColor ?? Colors.blue,
                          ),
                        ),
                        color: Colors.transparent,
                      ),
                    ),
                  ],
                ),
                const SizedBox(height: 10),
                Container(
                  padding: const EdgeInsets.only(right: 5),
                  decoration: BoxDecoration(
                    border: Border.all(
                      color: isValid == false
                          ? Colors.red
                          : widget.accentColor ?? Colors.blue,
                    ),
                    borderRadius: const BorderRadius.all(
                      Radius.circular(5),
                    ),
                  ),
                  child: Row(
                    children: <Widget>[
                      Expanded(
                        child: TextField(
                          controller: textController,
                          autofocus: true,
                          inputFormatters: [
                            FilteringTextInputFormatter.allow(RegExp(r'[0-9]')),
                          ],
                          style: Theme.of(context).textTheme.headlineSmall,
                          decoration: InputDecoration(
                            isDense: true,
                            contentPadding: const EdgeInsets.all(10),
                            border: InputBorder.none,
                            hintText: widget.placeholderText,
                          ),
                          keyboardType: TextInputType.phone,
                          onSubmitted: (String value) {
                            isValid = null;
                            if (textController.text == code) {
                              isValid = true;
                              Navigator.pop(context, true);
                            } else {
                              isValid = false;
                              setState(() {});
                            }
                          },
                        ),
                      ),
                      Container(
                        height: 30,
                        decoration: BoxDecoration(
                          color: widget.accentColor ?? Colors.blue,
                          borderRadius: const BorderRadius.all(Radius.circular(5)),
                        ),
                        child: Material(
                          child: InkWell(
                            onTap: () {
                              isValid = null;
                              if (textController.text == code) {
                                isValid = true;
                                Navigator.pop(context, true);
                              } else {
                                generateCode();
                                isValid = false;
                                setState(() {});
                              }
                            },
                            child: Padding(
                              padding: const EdgeInsets.symmetric(
                                horizontal: 10,
                              ),
                              child: Center(
                                child: Text(
                                  widget.checkCaption,
                                  style: TextStyle(color: Theme.of(context).scaffoldBackgroundColor),
                                ),
                              ),
                            ),
                          ),
                          color: Colors.transparent,
                        ),
                      ),
                    ],
                  ),
                ),
                Visibility(
                  visible: isValid == false ? true : false,
                  child: Padding(
                    padding: const EdgeInsets.only(top: 0),
                    child: Row(
                      children: <Widget>[
                        Text(
                          widget.invalidText,
                          style: const TextStyle(color: Colors.red),
                          textAlign: TextAlign.left,
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NumberCaptcha extends StatefulWidget {
  const NumberCaptcha(this.code, {Key? key}) : super(key: key);

  final String code;

  @override
  State<NumberCaptcha> createState() => _NumberCaptchaState();
}

class _NumberCaptchaState extends State<NumberCaptcha> {
  final double width = 180;
  final double height = 40;
  final int dotCount = 100;
  final Color backgroundColor = Colors.white;

  Map getRandomData() {
    List list = widget.code.split("");
    double x = 0.0;
    double maxFontSize = 40.0;

    List mList = [];
    for (String item in list) {
      Color color = Color.fromARGB(
        255,
        Random().nextInt(255),
        Random().nextInt(255),
        Random().nextInt(255),
      );

      int fontWeight = Random().nextInt(9);

      TextSpan span = TextSpan(
        text: item,
        style: TextStyle(
          color: color,
          fontWeight: FontWeight.values[fontWeight],
          fontSize: maxFontSize - Random().nextInt(10),
        ),
      );

      TextPainter painter = TextPainter(
        text: span,
        textDirection: TextDirection.ltr,
      );

      painter.layout();

      double y = Random().nextInt(height.toInt()).toDouble() - painter.height;

      if (y < 0) {
        y = 0;
      }

      Map strMap = {"painter": painter, "x": x, "y": y};

      mList.add(strMap);

      x += painter.width + 3;
    }

    double offsetX = (width - x) / 2;
    List dotData = [];

    for (var i = 0; i < dotCount; i++) {
      int r = Random().nextInt(255);
      int g = Random().nextInt(255);
      int b = Random().nextInt(255);
      double x = Random().nextInt(width.toInt() - 5).toDouble();
      double y = Random().nextInt(height.toInt() - 5).toDouble();
      double dotWidth = Random().nextInt(6).toDouble();
      Color color = Color.fromARGB(255, r, g, b);
      Map dot = {"x": x, "y": y, "dotWidth": dotWidth, "color": color};
      dotData.add(dot);
    }

    Map checkCodeDrawData = {
      "painterData": mList,
      "offsetX": offsetX,
      "dotData": dotData,
    };
    return checkCodeDrawData;
  }

  @override
  Widget build(BuildContext context) {
    double maxWidth = 0.0;
    Map drawData = getRandomData();

    maxWidth = getTextSize(
      "8" * widget.code.length,
      TextStyle(fontWeight: FontWeight.values[8], fontSize: 25),
    ).width;

    return Container(
      color: backgroundColor,
      width: maxWidth > width ? maxWidth : width,
      height: height,
      child: CustomPaint(
        painter: HBCheckCodePainter(drawData: drawData),
      ),
    );
  }

  Size getTextSize(String text, TextStyle style) {
    final TextPainter textPainter = TextPainter(
      text: TextSpan(text: text, style: style),
      maxLines: 1,
      textDirection: TextDirection.ltr,
    )..layout(minWidth: 0, maxWidth: double.infinity);

    return textPainter.size;
  }
}

class HBCheckCodePainter extends CustomPainter {
  final Map drawData;
  HBCheckCodePainter({
    required this.drawData,
  });

  final Paint _paint = new Paint()
    ..color = Colors.grey
    ..strokeCap = StrokeCap.square
    ..isAntiAlias = true
    ..strokeWidth = 1.0
    ..style = PaintingStyle.fill;

  @override
  void paint(Canvas canvas, Size size) {
    List mList = drawData["painterData"];

    double offsetX = drawData["offsetX"];

    canvas.translate(offsetX, 0);

    for (var item in mList) {
      TextPainter painter = item["painter"];
      double x = item["x"];
      double y = item["y"];
      painter.paint(
        canvas,
        Offset(x, y),
      );
    }

    canvas.translate(-offsetX, 0);
    List dotData = drawData["dotData"];
    for (var item in dotData) {
      double x = item["x"];
      double y = item["y"];
      double dotWidth = item["dotWidth"];
      Color color = item["color"];
      _paint.color = color;
      canvas.drawOval(Rect.fromLTWH(x, y, dotWidth, dotWidth), _paint);
    }
  }

  @override
  bool shouldRepaint(CustomPainter oldDelegate) {
    return this != oldDelegate;
  }
}
