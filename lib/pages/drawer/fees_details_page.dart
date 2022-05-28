import 'package:flutter/material.dart';
import 'package:mgclinic/fee.dart';

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
      Details(title: "", price: ""),
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
          ListView.separated(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            padding: const EdgeInsets.all(10),
            itemBuilder: (context, index) {
              return Column(
                children: [
                  Row(
                    children: [
                      Expanded(
                        flex: 2,
                        child: RichText(
                          textAlign: TextAlign.center,
                          text: TextSpan(
                            text: fees[index].title,
                            style: Theme.of(context).textTheme.titleSmall,
                            children: [
                              TextSpan(
                                text: "\n${fees[index].subtitle}",
                                style: Theme.of(context).textTheme.bodySmall,
                              ),
                            ],
                          )
                        ),
                      ),
                      Expanded(
                        child: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 10),
                          child: Text(fees[index].price, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                        ),
                      ),
                      Flexible(
                        flex: 3,
                        child: Text(fees[index].description,
                          style: Theme.of(context).textTheme.bodySmall,
                          maxLines: 5,
                          softWrap: true,
                        ),
                      )
                    ],
                  ),
                  if (fees[index].details.isNotEmpty) ...[
                    for (var detail in fees[index].details) 
                    Row(
                      children: <Widget>[
                        Expanded(
                          flex: 2,
                          child: Column(
                            children: [
                              Text(detail.title, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                        Expanded(
                          child: Column(
                            children: [
                              Text(detail.price, textAlign: TextAlign.center, style: Theme.of(context).textTheme.titleSmall),
                            ],
                          ),
                        ),
                        Expanded(
                          flex: 3,
                          child: detail.title.isNotEmpty ? 
                            Center(child: Text(detail.description, style: Theme.of(context).textTheme.bodySmall)) :
                            const Divider(thickness: 2),
                        )
                      ],
                    )
                  ],
                ],
              );
            },
            separatorBuilder: (context, index) => const Divider(thickness: 2), 
            itemCount: fees.length
          )
        ],
      ),
    );
  }
}
