import 'package:flutter/material.dart';
import 'package:intellihr/HR/model/benifits_model.dart';


class BenefitsPage extends StatefulWidget {
  const BenefitsPage({Key? key}) : super(key: key);

  @override
  _BenefitsPageState createState() => _BenefitsPageState();
}

class _BenefitsPageState extends State<BenefitsPage> {
  late List<Benefit> benefitList;

  @override
  void initState() {
    super.initState();
    benefitList = [
      Benefit(
        icon: Icons.cases_outlined,
        title: "Paid Parental Leave",
        description:
            "We offer paid parental leave for all parents to support you and your family. 16 weeks. Birthing parents qualify for additional pregnancy leave entitlements before birth, covered under Stripe's medical leave policy for up to 8 weeks.",
      ),
      Benefit(
        icon: Icons.wysiwyg_sharp,
        title: "Growth through Learning",
        description:
            "We are voracious learners and teachers. Our Education team delivers an onboarding and product training curriculum for new Stripes, and hosts expert-led courses on things like project management fundamentals and macroeconomics.",
      ),
      Benefit(
        icon: Icons.travel_explore,
        title: "Generous Vacation",
        description:
            "21 days. Stripe office shuts down during the holidays. The number of allowable vacation days varies from year to year, depending on the holidays.",
      ),
      Benefit(
        icon: Icons.local_hospital,
        title: "Fertility Benefits",
        description:
            "A fully elective fertility program, reimbursed at 80% of incurred costs, up to an annual max of ₹10,000 and a lifetime max of ₹20,000.",
      ),
      Benefit(
        icon: Icons.emoji_emotions_rounded,
        title: "Wellness Benefits",
        description:
            "₹125 to spend each month on whatever makes you feel good, whether it's gum, yoga, meditation classes, or something in between.",
      ),
      Benefit(
        icon: Icons.bento_outlined,
        title: "Life Insurance",
        description:
            "2 x base annual earnings to a maximum of ₹5,00,000. Plus option for voluntary life insurance.",
      ),
      Benefit(
        icon: Icons.outbond_rounded,
        title: "Retirement Benefits",
        description:
            "50% match on employees' contribution up to ₹2,000. Administered through Fidelity.",
      ),
    ];
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 140, 212, 221),
      appBar: AppBar(
        backgroundColor: const Color.fromARGB(255, 140, 212, 221),
        title: const Text("Benefits"),
      ),
      body: GridView.builder(
        gridDelegate: const SliverGridDelegateWithMaxCrossAxisExtent(
          maxCrossAxisExtent: 400,
          childAspectRatio: 4 / 2,
          crossAxisSpacing: 20,
          mainAxisSpacing: 10,
        ),
        itemCount: benefitList.length,
        itemBuilder: (BuildContext ctx, index) {
          return Card(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Padding(
                  padding: const EdgeInsets.only(bottom: 20, left: 80),
                  child: Row(
                    children: [
                      Icon(
                        benefitList[index].icon,
                        color: Colors.amber,
                        size: 40,
                      ),
                      const SizedBox(
                        height: 10,
                        width: 20,
                      ),
                      Text(
                        benefitList[index].title,
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Padding(
                  padding: const EdgeInsets.fromLTRB(5, 5, 5, 20),
                  child: Text(
                    benefitList[index].description,
                    textAlign: TextAlign.justify,
                    style: const TextStyle(),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
