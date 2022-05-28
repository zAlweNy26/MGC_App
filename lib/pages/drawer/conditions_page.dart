import 'package:flutter/material.dart';

class ConditionsPage extends StatefulWidget {
  const ConditionsPage({Key? key}) : super(key: key);

  @override
  State<ConditionsPage> createState() => _ConditionsPageState();
}

class _ConditionsPageState extends State<ConditionsPage> {
  List<String> treatedConditions = [
    "Lower Back Pain",
    "Neck and Shoulders Pains",
    "Muscle Sprains & Joint Strains",
    "Headache (cervicogenic)",
    "Dizziness (cervicogenic)",
    "Postural Dysfunctions",
    "Pelvis misalignment"
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Container(
            color: Colors.green,
            padding: const EdgeInsets.all(5),
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Conditions we treat :",
                    style: Theme.of(context).textTheme.titleMedium)),
          ),
          ListView.builder(
            padding: const EdgeInsets.symmetric(vertical: 10),
            shrinkWrap: true,
            itemCount: treatedConditions.length,
            itemBuilder: (context, index) {
              return ListTile(
                leading: Image.asset("assets/logo.png", width: 48, height: 48),
                title: Text(treatedConditions[index], style: Theme.of(context).textTheme.bodyMedium),
              );
            },
          ),
          Container(
            color: Colors.red,
            padding: const EdgeInsets.all(5),
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Conditions we DO NOT treat :",
                    style: Theme.of(context).textTheme.titleMedium)),
          ),
          Padding(
            padding: const EdgeInsets.all(10),
            child: Text("*In-grown nails, *infections, *otitis, *hormonal dysfunctions, *neurological disorders, *calluses removal", style: Theme.of(context).textTheme.bodyMedium),
          )
        ],
      ),
    );
  }
}
