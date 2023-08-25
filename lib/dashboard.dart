import 'dart:async';
import 'dart:io';

import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:infinite_carousel/infinite_carousel.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sarkar/helper.dart/custombtn.dart';
import 'package:sarkar/helper.dart/customtextfield.dart';
import 'package:sarkar/spreadcampagin.dart';
import 'package:sarkar/utils/collectionreference.dart';
import 'package:sarkar/utils/showcircleprogressdialog.dart';
import 'package:sarkar/volunteer.dart';
import 'package:sarkar/widget/fotter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final formKey = GlobalKey<FormState>();
  bool isSubmit = false;
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final jilaController = TextEditingController();
  final vidhanController = TextEditingController();
  final otpController = TextEditingController();
  String id = '';
  setForm1Data() async {
    DocumentReference<Object?> doc = usersRef.doc();
    if (formKey.currentState!.validate()) {
      showCircleProgressDialog(context);
      id = doc.id;
      setState(() {});
      await usersRef.doc(doc.id).set({
        'name': nameController.text,
        'number': phoneController.text,
        'jila': jilaController.text,
        'vidhan': vidhanController.text,
        'id': doc.id
      }).then((value) {
        Navigator.pop(context);
        isSubmit = true;
        setState(() {});
      });
      Navigator.pop(context);
    }
  }

  bool validate = false;
  bool loading = false;
  // AuthService auth = AuthService();
  bool showDialogBox = false;

  late String verificationId;
  int timer = 10;
  final FirebaseAuth _auth = FirebaseAuth.instance;

  login(BuildContext context) async {
    showDialogBox = true;

    // notifyListeners();
    await _auth.verifyPhoneNumber(
      phoneNumber: "+91" + phoneController.text.toString().trim(),
      timeout: Duration(seconds: timer),
      verificationCompleted: (phoneAuthCredential) async {
        showDialogBox = false;
        // notifyListeners();
      },
      verificationFailed: (verificationFailed) async {
        ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            content: Text(
          "Please check your number",
          style: TextStyle(fontSize: 16),
        ))));
        showDialogBox = false;
        // notifyListeners();
      },
      codeSent: (verificationId, resendingToken) async {
        // Get.to(OTPScreen(verificationId, phoneController.text, timer),
        //     fullscreenDialog: true);
        // Navigator.push(
        //   context,
        //   PageRouteBuilder(
        //     fullscreenDialog: true,
        //     pageBuilder: (c, a1, a2) =>
        //         OTPScreen(verificationId, phoneController.text, timer),
        //     transitionsBuilder: (c, anim, a2, child) =>
        //         FadeTransition(opacity: anim, child: child),
        //     transitionDuration: const Duration(milliseconds: 400),
        //   ),
        // );
        this.verificationId = verificationId;
        showDialogBox = false;
        // notifyListeners();
      },
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  @override
  Widget build(BuildContext context) {
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return Scaffold(
      // backgroundColor: const Color(0xfffbffe8),
      body: Stack(
        children: [
          Column(
            children: [
              Expanded(
                child: Image.asset(
                  'assets/icons/2.jpg',
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  fit: BoxFit.cover,
                ),
              ),
              // const Spacer(),
              fotterWidget(context)
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(
              right: 20,
              left: 20,
              top: 10,
            ),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Image.asset(
                  'assets/icons/logo.png',
                  height: 80,
                  width: 80,
                  // fit: BoxFit.cover,
                ),
                const Spacer(),
                !isSubmit
                    ? Padding(
                        padding: const EdgeInsets.only(top: 15),
                        child: CustomBtn(
                          title: 'प्रण ले',
                          height: 50,
                          width: 100,
                          onTap: () {
                            dialogBox();
                          },
                        ),
                      )
                    : isMobile || isTablet
                        ? Column(
                            // mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBtn(
                                title: 'Spread the campaign',
                                height: 50,
                                width: 280,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Volunteer()));
                                },
                              ),
                              const SizedBox(
                                height: 20,
                              ),
                              CustomBtn(
                                title: 'Join as an volunteer',
                                height: 50,
                                width: 280,
                                isLoading: true,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SpreadCampagin(id)));
                                },
                              )
                            ],
                          )
                        : Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              CustomBtn(
                                title: 'Spread the campaign',
                                height: 50,
                                width: 280,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) => Volunteer()));
                                },
                              ),
                              const SizedBox(
                                width: 20,
                              ),
                              CustomBtn(
                                title: 'Join as an volunteer',
                                height: 50,
                                width: 280,
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              SpreadCampagin(id)));
                                },
                              )
                            ],
                          )
              ],
            ),
          ),
        ],
      ),
    );
  }

  Verify() async {
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otpController.text);
    // currentuser();
    signInWithPhoneAuthCredential(
      phoneAuthCredential,
    );
  }

  void signInWithPhoneAuthCredential(
    PhoneAuthCredential phoneAuthCredential,
  ) async {
    setState(() {
      // showLoading = true;
    });

    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);

      setState(() {
        // showLoading = true;
      });

      if (authCredential.user != null) {
        // CheckDataExit(loginViewModal);
      }
    } on FirebaseAuthException catch (e) {
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter the correct otp number',
              style: TextStyle(fontSize: 16))));
      setState(() {
        // showLoading = false;
      });
    }
  }

  dialogBox() {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return Align(
          alignment: Alignment.topCenter,
          child: Container(
            width: 300,
            margin: const EdgeInsets.only(
              top: 50,
              left: 12,
              right: 12,
            ),
            padding:
                const EdgeInsets.only(top: 50, left: 20, right: 20, bottom: 20),
            decoration: BoxDecoration(
              color: const Color(0xff213865),
              borderRadius: BorderRadius.circular(10),
            ),
            child: Form(
              key: formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Text(
                    'कांग्रेस सरकार के कुशासन का अंत करने के लिए प्रण लें',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.white,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    hintText: 'नाम *',
                    controller: nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  CustomTextfield(
                    hintText: 'फ़ोन नंबर *',
                    controller: phoneController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
                      FilteringTextInputFormatter.digitsOnly,
                      LengthLimitingTextInputFormatter(10)
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    hintText: 'ज़िला का नाम*',
                    controller: jilaController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomTextfield(
                    hintText: 'विधानसभा *',
                    controller: vidhanController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s'))
                    ],
                    validator: (val) {
                      if (val.isEmpty) {
                        return '';
                      }
                    },
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  CustomBtn(
                    title: 'प्रण ले',
                    height: 45,
                    width: double.infinity,
                    onTap: () {
                      setState(() {
                        // login(context);
                        setForm1Data();
                        // isSubmit = true;
                      });
                    },
                  )
                ],
              ),
            ),
          ),
        );
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position:
              Tween(begin: Offset(0, -1), end: Offset(0, 0)).animate(anim1),
          child: child,
        );
      },
    );
  }
}
