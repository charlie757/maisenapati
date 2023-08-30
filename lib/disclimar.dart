import 'package:flutter/material.dart';

class Disclaimer extends StatefulWidget {
  const Disclaimer({super.key});

  @override
  State<Disclaimer> createState() => _DisclaimerState();
}

class _DisclaimerState extends State<Disclaimer> {
  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(
        fontSize: 30, color: Colors.black, fontWeight: FontWeight.w400);

    final Style = TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400);
    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                header(headingStyle),
                const SizedBox(
                  height: 25,
                ),
                content(headingStyle, Style)
              ],
            ),
          ),
        ),
      ),
    );
  }

  header(style) {
    return Container(
      height: 100,
      width: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xffbd9766),
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Text(
        'मैं सेनापति राजस्थान - Main Senapati Rajasthan',
        style: style,
      ),
    );
  }

  content(headingStyle, Style) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Disclaimer', style: headingStyle),
          const SizedBox(
            height: 10,
          ),
          Text(
            'No warranties',
            style: headingStyle,
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            'मैं सेनापति राजस्थान - Main Senapati Rajasthan is provided “as is” without any representations or warranties, express or implied. This website makes no representations or warranties in relation to this website or the information and materials provided on this website.',
            style: Style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Without prejudice to the generality of the foregoing paragraph, the website does not warrant that:',
            style: Style,
          ),
          const SizedBox(
            height: 23,
          ),
          textWithDots(Style,
              'this website will be constantly available, or available at all; or'),
          const SizedBox(
            height: 7,
          ),
          textWithDots(Style,
              'the information on this website is complete, true, accurate or non-misleading.'),
          const SizedBox(
            height: 23,
          ),
          Text(
            'Nothing on this website constitutes, or is meant to constitute, advice of any kind.',
            style: Style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Limitations of liability',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              'The website will not be liable to you (whether under the law of contracts, the law of torts or otherwise) in relation to the contents of, or use of, or otherwise in connection with, this website',
              style: Style),
          const SizedBox(
            height: 23,
          ),
          textWithDots(Style, 'for any direct loss;'),
          const SizedBox(
            height: 7,
          ),
          textWithDots(
              Style, 'for any indirect, special or consequential loss; or'),
          const SizedBox(
            height: 7,
          ),
          textWithDots(Style,
              'for any business losses, loss of revenue, income, profits or anticipated savings, loss of contracts or business relationships, loss of reputation or goodwill, or loss or corruption of information or data.'),
          const SizedBox(
            height: 23,
          ),
          Text(
            'These limitations of liability apply even if the website has been expressly advised of the potential loss.',
            style: Style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Exceptions',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'Nothing in this website disclaimer will exclude or limit any warranty implied by law that it would be unlawful to exclude or limit; and nothing in this website disclaimer will exclude or limit this website’s liability in respect of any:',
            style: Style,
          ),
          const SizedBox(
            height: 23,
          ),
          textWithDots(Style,
              'fraud or fraudulent misrepresentation on the part of the website; or'),
          const SizedBox(
            height: 7,
          ),
          textWithDots(Style,
              'matter which it would be illegal or unlawful for the website to exclude or limit, or to attempt or purport to exclude or limit, its liability.'),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Reasonableness',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'By using this website, you agree that the exclusions and limitations of liability set out in this website disclaimer are reasonable.',
            style: Style,
          ),
          const SizedBox(
            height: 23,
          ),
          Text(
            'If you do not think they are reasonable, you must not use this website.',
            style: Style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Other parties',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'You accept that, as a political campaigning entity, the website has an interest in limiting the personal liability of its staff and volunteers. You agree that you will not bring any claim personally against the website’s staff or volunteers in respect of any losses you suffer in connection with the website.',
            style: Style,
          )
        ],
      ),
    );
  }

  textWithDots(style1, String text) {
    return Container(
      padding: const EdgeInsets.only(left: 6),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Padding(
            padding: EdgeInsets.only(top: 6),
            child: Icon(
              Icons.circle,
              size: 7,
            ),
          ),
          const SizedBox(
            width: 6,
          ),
          Flexible(
            child: Text(
              text,
              style: style1,
            ),
          )
        ],
      ),
    );
  }
}
