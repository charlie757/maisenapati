import 'package:flutter/material.dart';
import 'package:sarkar/helper.dart/custombtn.dart';

class TestScreen extends StatefulWidget {
  const TestScreen({super.key});

  @override
  State<TestScreen> createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          children: [
            Container(
              height: 130,
              padding: const EdgeInsets.only(right: 5, left: 4),
              color: const Color(0xffdac19f),
              width: double.infinity,
              alignment: Alignment.centerLeft,
              child: Image.asset(
                'assets/icons/12.webp',
                height: 130,
                width: 130,
                // fit: BoxFit.contain,
              ),
            ),
            Image.asset(
              'assets/icons/mobilebanner2.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 450,
            ),
            const SizedBox(
              height: 20,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'इस बार राज नहीं रिवाज बदलेगा',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'briyaniSemi',
                  color: Colors.black,
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 20, left: 15, right: 15),
              child: CustomBtn(
                title: 'प्रण ले',
                height: 50,
                width: double.infinity,
                onTap: () {
                  // provider.dialogBox(isMobile, isTablet, context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
