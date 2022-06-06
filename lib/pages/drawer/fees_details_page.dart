import 'package:flutter/material.dart';
import 'package:mgclinic/fee.dart';
import 'package:mgclinic/widgets/custom_datatable.dart';

class FeesDetailsPage extends StatefulWidget {
  const FeesDetailsPage({Key? key}) : super(key: key);

  @override
  State<FeesDetailsPage> createState() => _FeesDetailsPageState();
}

class _FeesDetailsPageState extends State<FeesDetailsPage> {
  List<Fee> fees = [
    const Fee(title: "Spinal Screening", subtitle: "(5- 15mins)", price: "Free", description: "Screening of spinal and pelvic joints range of motion. Leg length symmetry."),
    const Fee(title: "First Consultation", subtitle: "(30 - 40mins)", price: "€ 50", description: "Case history, neuro-orthopaedic and physical examination. A treatment will be given, if suitable."),
    const Fee(title: "Follow Up", subtitle: "(15 - 20mins)", price: "", details: [
      Details(title: "Regular", price: "€ 38", description: "Patient's record logging. Treatment."),
      Details(title: "Senior", price: "€ 30"),
      Details(title: "Student", price: "€ 25", description: "Patient's record logging. Management will change according to age and condition."),
      Details(title: "Under 16", price: "€ 20"),
    ]),
    const Fee(title: "Deep Tissue", subtitle: "(40mins)", price: "€ 60", description: "Muscle stripping and passive stretching. Trigger point therapy."),
  ];

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          Padding(
            padding: const EdgeInsets.all(5),
            child: FittedBox(
                fit: BoxFit.scaleDown,
                child: Text("Fees details",
                    style: Theme.of(context).textTheme.titleLarge)),
          ),
          CustomDataTable(
            headingTextStyle: Theme.of(context).textTheme.headlineSmall,
            columns: const [  
              DataColumn(label: Expanded(child: Text('Type', textAlign: TextAlign.center))),  
              DataColumn(label: Expanded(child: Text('Price', textAlign: TextAlign.center))),  
              DataColumn(label: Expanded(child: Text('Description', textAlign: TextAlign.center))),  
            ],
            rows: [ 
              for (Fee fee in fees) 
                DataRow(cells: [  
                  DataCell(
                    Column(
                      children: [
                        RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: fee.title,
                            style: Theme.of(context).textTheme.titleSmall,
                            children: [
                              TextSpan(
                                text: "\n${fee.subtitle}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ),
                        if (fee.details.isNotEmpty) const SizedBox(height: 5),
                        for (Details detail in fee.details)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(detail.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                          ),
                      ],
                    )
                  ),
                  DataCell(
                    Column(
                      children: [
                        Center(child: Text(fee.price, style: Theme.of(context).textTheme.titleSmall)),
                        if (fee.details.isNotEmpty) const SizedBox(height: 25),
                        for (Details detail in fee.details)
                          Padding(
                            padding: const EdgeInsets.symmetric(vertical: 5),
                            child: Text(detail.price, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                          ),
                      ],
                    )
                  ),  
                  DataCell(
                    Column(
                      children: [
                        Center(
                          child: Text(fee.description,
                            style: Theme.of(context).textTheme.bodySmall,
                            maxLines: 5,
                            softWrap: true,
                          ),
                        ),
                        if (fee.details.isNotEmpty) const SizedBox(height: 30),
                        for (var i = 0; i < fee.details.length; i++) 
                          fee.details[i].description.isNotEmpty ?
                            Text(fee.details[i].description, style: Theme.of(context).textTheme.bodySmall) : 
                            (i != fee.details.length - 1 ? Column(
                              children: const [
                                SizedBox(height: 10),
                                Divider(),
                              ],
                            ) : Container()), 
                      ],
                    )
                  ),  
                ])
            ],  
          ),
        ],
      ),
    );
  }
}
