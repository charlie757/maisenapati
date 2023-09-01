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
        fontSize: 27, color: Colors.black, fontWeight: FontWeight.w400);

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
      height: 120,
      width: double.infinity,
      alignment: Alignment.center,
      color: const Color(0xffbd9766),
      padding: const EdgeInsets.only(
        left: 20,
        right: 20,
      ),
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
            'This campaign is organized and managed by the team associated with the website https://mainsenapatirajasthan.in/ and the Facebook page "मैं सेनापति राजस्थान - Main Senapati Rajasthan."',
            style: Style,
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Note: ',
            'This disclaimer is provided as per the guidelines set by the platform and does not contain any URL, foreign country reference, or brand name owned by Facebook Inc.  ',
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Official Name: ',
            'The campaign is organized by the team behind the website "मैं सेनापति राजस्थान - Main Senapati Rajasthan.',
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Transparency: ',
            'This campaign aims to provide transparent information to users about our activities, events, and initiatives related to Rajasthan. It is a platform to engage with the community, raise awareness, and foster discussions about matters relevant to the state.',
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Compliance: ',
            "We ensure that our content adheres to Facebook's Community Standards and Advertising Policies. The campaign is free from profanity, bad grammar, excessive symbols, characters, or punctuation.",
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'User Engagement: ',
            'We encourage users to actively participate, share their thoughts, and engage in constructive conversations through our Facebook page and website',
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Paid Promotion: ',
            'This campaign is not endorsed or sponsored by Facebook or any brand owned by Facebook Inc., such as Instagram and WhatsApp.',
          ),
          const SizedBox(
            height: 23,
          ),
          customTextRich(
            'Contact Information: ',
            'For any inquiries, feedback, or concerns related to this campaign, you can reach out to us through the contact details provided on our website.',
          ),
          const SizedBox(
            height: 23,
          ),
          Text(
            'We appreciate your interest in our campaign and look forward to fostering positive discussions and interactions within the community.',
            style: Style,
          ),
        ],
      ),
    );
  }

  customTextRich(String title, String des) {
    return Text.rich(TextSpan(
        text: title,
        style: const TextStyle(
            fontSize: 15, color: Colors.black, fontWeight: FontWeight.w600),
        children: [
          TextSpan(
              text: des,
              style: const TextStyle(
                  fontSize: 15,
                  color: Colors.black,
                  fontWeight: FontWeight.w400))
        ]));
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
