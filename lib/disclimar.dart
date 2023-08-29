import 'package:flutter/material.dart';

class Disclimar extends StatefulWidget {
  const Disclimar({super.key});

  @override
  State<Disclimar> createState() => _DisclimarState();
}

class _DisclimarState extends State<Disclimar> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding:
              const EdgeInsets.only(left: 30, right: 30, top: 30, bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: const [
              Text(
                'Disclaimer',
                style: TextStyle(
                    fontSize: 20,
                    color: Colors.black,
                    fontWeight: FontWeight.w700),
              ),
              SizedBox(
                height: 15,
              ),
              Text(
                  "No warranties\nnhi sahega rajasthan (hereinafter referred to as the “website”) is provided “as is” without any representations or warranties, express or implied. This website makes no representations or warranties in relation to this website or the information and materials provided on this website.\n\nWithout prejudice to the generality of the preceding paragraph, the website does not warrant that: \n\nThis website will be constantly available, or available at all; or the information on this website is complete, true, accurate or non-misleading.\nNothing on this website constitutes, or is meant to constitute, advice of any kind.\n\nLimitations of liability\nThe website will not be liable to you (whether under the law of contracts, the law of torts or otherwise) in relation to the contents of, or use of, or otherwise in connection with, this website\n\nfor any direct loss;\nfor any indirect, special, or consequential loss; or\nfor any business losses, loss of revenue, income, profits, or anticipated savings, loss of contracts or business relationships, loss of reputation or goodwill, or loss or corruption of information or data.\nThese limitations of liability apply even if the website has been expressly advised of the potential loss.\n\nExceptions\nNothing in this website disclaimer will exclude or limit any warranty implied by law that it would be unlawful to exclude or limit, and nothing in this website disclaimer will exclude or limit this website’s liability in respect of any:\n\nfraud or fraudulent misrepresentation on the part of the website; or matter which it would be illegal or unlawful for the website to exclude or limit, or to attempt or purport to exclude or limit, its liability. Reasonableness\nBy using this website, you agree that the exclusions and limitations of liability set out in this website disclaimer are reasonable.\n\nIf you do not think they are reasonable, you must not use this website.\nOther parties\nYou accept that, as a political campaigning entity, the website has an interest in limiting the personal liability of its staff and volunteers. You agree that you will not bring any claim personally against the website’s staff or volunteers regarding any losses you suffer in connection with the website.")
            ],
          ),
        ),
      ),
    );
  }
}
