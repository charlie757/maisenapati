import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sarkar/disclimar.dart';
import 'package:sarkar/privacypolicy.dart';
import 'package:sarkar/utils/routes.dart';

Widget fotterWidget(BuildContext context) {
  bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
  bool isTablet = ResponsiveBreakpoints.of(context).isTablet;

  return isMobile || isTablet
      ? mobileTabletDesign(context)
      : webDesign(context);
}

Widget mobileTabletDesign(BuildContext context) {
  return Container(
    height: 115,
    color: const Color(0xffbd9766),
    padding: const EdgeInsets.only(left: 20, right: 20, top: 5, bottom: 5),
    child: Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            GestureDetector(
              onTap: () {
                Get.toNamed(
                  Routes.disclaimer,
                );
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'DISCLAIMER',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
            const SizedBox(
              height: 30,
              child: VerticalDivider(
                color: Colors.white,
                thickness: 1.5,
              ),
            ),
            GestureDetector(
              behavior: HitTestBehavior.opaque,
              onTap: () {
                Get.toNamed(
                  Routes.privacy,
                );
              },
              child: const MouseRegion(
                cursor: SystemMouseCursors.click,
                child: Text(
                  'PRIVACY POLICY',
                  style: TextStyle(fontSize: 15, color: Colors.white),
                ),
              ),
            ),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            socialContainer('assets/icons/facebook.png'),
            const SizedBox(
              width: 10,
            ),
            socialContainer('assets/icons/twitter.png'),
            const SizedBox(
              width: 10,
            ),
            socialContainer('assets/icons/youtube.png'),
            const SizedBox(
              width: 10,
            ),
            socialContainer('assets/icons/instagram.png'),
          ],
        ),
        const SizedBox(
          height: 5,
        ),
        const Text(
          'Copyright © 2023 - All Rights Reserved.',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget webDesign(BuildContext context) {
  return Container(
    height: 60,
    color: const Color(0xffbd9766),
    padding: const EdgeInsets.only(left: 20, right: 20),
    child: Row(
      children: [
        GestureDetector(
          onTap: () {
            Get.toNamed(
              Routes.disclaimer,
            );
          },
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              'DISCLAIMER',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
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
            Get.toNamed(
              Routes.privacy,
            );
          },
          child: const MouseRegion(
            cursor: SystemMouseCursors.click,
            child: Text(
              'PRIVACY POLICY',
              style: TextStyle(fontSize: 15, color: Colors.white),
            ),
          ),
        ),
        const Spacer(),
        socialContainer('assets/icons/facebook.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer('assets/icons/twitter.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer('assets/icons/youtube.png'),
        const SizedBox(
          width: 15,
        ),
        socialContainer('assets/icons/instagram.png'),
        const Spacer(),
        const Text(
          'Copyright © 2023 - All Rights Reserved.',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget socialContainer(String img) {
  return Container(
    height: 45,
    width: 45,
    alignment: Alignment.center,
    decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(17),
        color: const Color(0xff2596be)),
    // padding: EdgeInsets.all(10),
    child: Image.asset(
      img,
      height: 25,
      width: 25,
      fit: BoxFit.cover,
    ),
  );
}
