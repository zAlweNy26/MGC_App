import 'package:flutter/material.dart';
import 'package:mgclinic/widgets/padded_scrollview.dart';

class BookingPage extends StatefulWidget {
  const BookingPage({Key? key}) : super(key: key);

  @override
  State<BookingPage> createState() => _BookingPageState();
}

class _BookingPageState extends State<BookingPage> {
  @override
  Widget build(BuildContext context) {
    return PaddedScrollView(
        scrollPadding:
            const EdgeInsets.only(bottom: 72, left: 10, top: 10, right: 10),
        child: Column(
          children: [
            Text("Booking Page",
                style: Theme.of(context).textTheme.headlineMedium),
          ],
        ));
  }
}
