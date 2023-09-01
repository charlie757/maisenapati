import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

class PrivacyPolicy extends StatefulWidget {
  const PrivacyPolicy({super.key});

  @override
  State<PrivacyPolicy> createState() => _PrivacyPolicyState();
}

class _PrivacyPolicyState extends State<PrivacyPolicy> {
  @override
  Widget build(BuildContext context) {
    final headingStyle = TextStyle(
        fontSize: 27, color: Colors.black, fontWeight: FontWeight.w400);

    final style = TextStyle(
        fontSize: 15, color: Colors.black, fontWeight: FontWeight.w400);

    return Scaffold(
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.only(bottom: 30),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              header(headingStyle),
              const SizedBox(
                height: 25,
              ),
              content(headingStyle, style)
            ],
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
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Text(
        'मैं सेनापति राजस्थान - Main Senapati Rajasthan',
        style: style,
      ),
    );
  }

  content(headingStyle, style) {
    return Padding(
      padding: const EdgeInsets.only(left: 30, right: 30),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text('Privacy Policy', style: headingStyle),
          const SizedBox(
            height: 10,
          ),
          Text.rich(TextSpan(
              text: 'Your privacy is important to ',
              style: style,
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        urlLauncher('https://mainsenapatirajasthan.in/');
                      },
                    text: 'https://mainsenapatirajasthan.in/',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontWeight: FontWeight.w400,
                        fontSize: 15),
                    children: [
                      TextSpan(
                          text:
                              ' (hereinafter referred to as the “website”). This privacy statement provides information about the personal information that the website collects, and the ways in which the website uses that personal information.',
                          style: style)
                    ])
              ])),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Personal information collection',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
              'The website may collect and use the following kinds of personal information:',
              style: style),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style,
              'information about your use of this website (including browsing patterns and behaviour);'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style,
              'information that you provide using for the purpose of registering with the website (including contact details);'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style,
              'information about transactions carried out over this website;'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style,
              'information that you provide for the purpose of subscribing to the website services (including SMS and email alerts); and any other information that you send to fellow users and webmaster.'),
          const SizedBox(
            height: 23,
          ),
          Text(
            'Using personal information',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'The website may use your personal information to:',
            style: style,
          ),
          const SizedBox(
            height: 23,
          ),
          textWithDots(style, 'administer this website;'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style, 'personalize the website for you;'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(
              style, 'enable your access to and use of the website services;'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style, 'publish information about you on the website;'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style, 'send you marketing communications.'),
          const SizedBox(
            height: 20,
          ),
          textWithDots(style,
              'Where the website discloses your personal information to its agents or subcontractors for these purposes, the agent or sub-contractor in question will be obligated to use that personal information in accordance with the terms of this privacy statement.'),
          const SizedBox(
            height: 15,
          ),
          Text(
            'In addition to the disclosures reasonably necessary for the purposes identified elsewhere above, the website may disclose your personal information to the extent that it is required to do so by law, in connection with any legal proceedings or prospective legal proceedings, and in order to establish, exercise or defend its legal rights.',
            style: style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Securing your data',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'The website will take reasonable technical and organisational precautions to prevent the loss, misuse or alteration of your personal information.',
            style: style,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'The website will store all the personal information you provide on its secure servers.',
            style: style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Updating this statement',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'The website may update this privacy policy by posting a new version on this website.',
            style: style,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'You should check this page occasionally to ensure you are familiar with any changes.',
            style: style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Other websites',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text(
            'This website contains links to other websites.',
            style: style,
          ),
          const SizedBox(
            height: 20,
          ),
          Text(
            'The website is not responsible for the privacy policies or practices of any third party.',
            style: style,
          ),
          const SizedBox(
            height: 25,
          ),
          Text(
            'Contact Webmaster',
            style: headingStyle,
          ),
          const SizedBox(
            height: 15,
          ),
          Text.rich(TextSpan(
              text:
                  'If you have any questions about this privacy policy or the website’s treatment of your personal information, please write to: ',
              style: style,
              children: [
                TextSpan(
                    recognizer: TapGestureRecognizer()
                      ..onTap = () {
                        final Uri params = Uri(
                          scheme: 'mailto',
                          path: 'admin@mainsenapatirajasthan.in',
                        );
                        urlLauncher(params.toString());
                      },
                    text: 'admin@mainsenapatirajasthan.in',
                    style: const TextStyle(
                        color: Colors.blue,
                        fontSize: 15,
                        fontWeight: FontWeight.w400))
              ]))
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

  urlLauncher(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
