import 'dart:js';

import 'package:flutter/material.dart';
import 'package:sarkar/disclimar.dart';
import 'package:sarkar/privacypolicy.dart';

Widget fotterWidget(BuildContext context) {
  return Container(
    height: 60,
    color: Colors.black,
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Disclimar()));
          },
          child: const Text(
            'DISCLAIMER',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        Container(
          height: 30,
          child: const VerticalDivider(
            color: Colors.white,
            thickness: 1.5,
          ),
        ),
        GestureDetector(
          behavior: HitTestBehavior.opaque,
          onTap: () {
            Navigator.push(context,
                MaterialPageRoute(builder: (context) => PrivacyPolicy()));
          },
          child: const Text(
            'PRIVACY POLICY',
            style: TextStyle(fontSize: 15, color: Colors.white),
          ),
        ),
        const Spacer(),
        socialContainer(Color(0xff3B5998), 'assets/icons/fb.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer(Color(0xff55ACEE), 'assets/icons/twitter.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer(Color(0xffbb0000), 'assets/icons/yt.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer(Color(0xff125688), 'assets/icons/instra.png'),
      ],
    ),
  );
}

Widget socialContainer(Color color, String img) {
  return Container(
    height: 45,
    width: 45,
    alignment: Alignment.center,
    decoration:
        BoxDecoration(borderRadius: BorderRadius.circular(17), color: color),
    padding: EdgeInsets.all(5),
    child: Image.asset(
      img,
      // height: 25,
      // width: 25,
    ),
  );
}
