import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:lottie/lottie.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:mainsenapatirajasthan/utils/routes.dart';
import 'package:url_launcher/url_launcher.dart';

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
            socialContainer('assets/lottie/lottie4.json', () {
              urlLauncher('https://www.facebook.com/MainSenapatiRajasthan/');
            }),
            const SizedBox(
              width: 10,
            ),
            socialContainer('assets/lottie/lottie5.json', () {
              urlLauncher('https://twitter.com/mainsenapatiraj');
            }),
            const SizedBox(
              width: 10,
            ),
            // socialContainer('assets/lottie/lottie7.json', () {
            //   urlLauncher('https://www.threads.net/@mainsenapatirajasthan');
            // }),
            // const SizedBox(
            //   width: 10,
            // ),
            socialContainer('assets/lottie/lottie6.json', () {
              urlLauncher('https://www.instagram.com/mainsenapatirajasthan/');
            }),
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
        socialContainer('assets/lottie/lottie4.json', () {
          urlLauncher('https://www.facebook.com/MainSenapatiRajasthan/');
        }),
        const SizedBox(
          width: 15,
        ),
        socialContainer('assets/lottie/lottie5.json', () {
          urlLauncher('https://twitter.com/mainsenapatiraj');
        }),
        // const SizedBox(
        //   width: 15,
        // ),
        // socialContainer('assets/lottie/lottie7.json', () {
        //   urlLauncher('https://www.threads.net/@mainsenapatirajasthan');
        // }),
        const SizedBox(
          width: 15,
        ),
        socialContainer('assets/lottie/lottie6.json', () {
          urlLauncher('https://www.instagram.com/mainsenapatirajasthan/');
        }),
        const Spacer(),
        const Text(
          'Copyright © 2023 - All Rights Reserved.',
          style: TextStyle(color: Colors.white, fontSize: 15),
        ),
      ],
    ),
  );
}

Widget socialContainer(String img, Function() onTap) {
  return MouseRegion(
    cursor: SystemMouseCursors.click,
    child: GestureDetector(
      behavior: HitTestBehavior.opaque,
      onTap: onTap,
      child: Container(
        height: 45,
        width: 45,
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(17),
          // color: const Color(0xff2596be)
        ),
        // padding: EdgeInsets.all(10),
        child: Lottie.asset(
          img,
          // height: 25,
          // width: 25,
          fit: BoxFit.cover,
        ),
      ),
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
