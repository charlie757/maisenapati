import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:sarkar/helper.dart/custombtn.dart';
import 'package:sarkar/helper.dart/customtextfield.dart';
import 'package:sarkar/spreadcampagin.dart';
import 'package:sarkar/utils/collectionreference.dart';
import 'package:sarkar/utils/showcircleprogressdialog.dart';
import 'package:sarkar/volunteer.dart';

class DashboardProvider extends ChangeNotifier {
  // 0---default form
  // 1--- 2 buttons
  // 2-- otp
  // 3--- registerd
  //4-- spread
  // 5--- volunteer form
  // 6--- volunteer form submit msg
  late String verificationId;
  int timer = 10;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int userIndex = 0;
  String id = '';
  String userVidhan = '';

  // validation variable
  bool nameValidation = false;
  bool phoneValidation = false;
  bool jilaValidation = false;
  bool vidhanValidation = false;
  bool ageValidation = false;
  bool gendorValidation = false;
  bool otpValidation = false;
  bool volunteer1Validation = false;
  bool volunteer2Validation = false;
  bool volunteer3Validation = false;
  bool volunteer4Validation = false;
  bool volunteer5Validation = false;
  bool volunteer6Validation = false;

  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final jilaController = TextEditingController();
  final vidhanController = TextEditingController();
  final otpController = TextEditingController();
  final ageController = TextEditingController();
  final gendorController = TextEditingController();
  final secondForm1Controller = TextEditingController();
  final secondForm2Controller = TextEditingController();
  String volunteer1SelectedValue = '';
  String volunteer2SelectedValue = '';
  String volunteer3SelectedValue = '';
  String volunteer4SelectedValue = '';

  List gendorList = ['पुरुष', 'महिला', 'अन्य'];
  int selectedGendor = -1;
  List districtList = [];
  int selectedJila = -1;
  int selectedVidhan = -1;
  int selectedIndex = 0;
  bool isVidhanRead = true;
  fetchDistrctData() async {
    districtList.clear();
    district.get().then((value) {
      districtList = value.docs;
    });
  }

  login(BuildContext context, PhoneCodeSent codeSent) async {
    await _auth.verifyPhoneNumber(
      phoneNumber: '+91 ${phoneController.text}',
      timeout: Duration(seconds: timer),
      verificationCompleted: (phoneAuthCredential) async {
        Get.back();
      },
      verificationFailed: (verificationFailed) async {
        print(phoneController.text);
        Get.back();
        print(verificationFailed.phoneNumber);
        ScaffoldMessenger.of(context).showSnackBar((const SnackBar(
            // width: 200,
            content: Text(
          "Please check your number",
          style: TextStyle(fontSize: 16),
        ))));
        // showDialogBox = false;
        // notifyListeners();
      },
      codeSent: codeSent,
      codeAutoRetrievalTimeout: (verificationId) async {},
    );
  }

  Verify(BuildContext context) async {
    PhoneAuthCredential phoneAuthCredential =
        await PhoneAuthProvider.credential(
            verificationId: verificationId, smsCode: otpController.text);
    // currentuser();
    signInWithPhoneAuthCredential(phoneAuthCredential, context);
  }

  void signInWithPhoneAuthCredential(
      PhoneAuthCredential phoneAuthCredential, BuildContext context) async {
    try {
      final authCredential =
          await _auth.signInWithCredential(phoneAuthCredential);
      if (phoneAuthCredential.providerId.isNotEmpty) {}
    } on FirebaseAuthException catch (e) {
      Get.back();
      print(e.message);
      ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
          content: Text('Please enter the correct otp number',
              style: TextStyle(fontSize: 16))));
      // setState(() {
      //   // showLoading = false;
      // });
    }
  }

  dialogBox(isMobile, isTablet, BuildContext context) {
    showGeneralDialog(
      barrierLabel: "Label",
      barrierDismissible: true,
      barrierColor: Colors.black.withOpacity(0.5),
      transitionDuration: const Duration(milliseconds: 700),
      context: context,
      pageBuilder: (context, anim1, anim2) {
        return StatefulBuilder(builder: (context, state) {
          return Align(
            alignment: Alignment.center,
            child: Container(
              width: isMobile ? MediaQuery.of(context).size.width : 400,
              margin: const EdgeInsets.only(left: 12, right: 12, bottom: 10),
              decoration: BoxDecoration(
                color: const Color(0xff213865),
                borderRadius: BorderRadius.circular(10),
              ),
              child: SingleChildScrollView(
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    const SizedBox(
                      height: 5,
                    ),
                    Align(
                      alignment: Alignment.centerRight,
                      child: Padding(
                        padding: const EdgeInsets.only(right: 15, top: 8),
                        child: GestureDetector(
                            behavior: HitTestBehavior.opaque,
                            onTap: () {
                              Get.back();
                            },
                            child: Image.asset(
                              'assets/icons/cross.png',
                              height: 25,
                              width: 25,
                            )),
                      ),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    Container(
                      height: 1,
                      decoration: const BoxDecoration(color: Colors.white24),
                    ),
                    const SizedBox(
                      height: 10,
                    ),
                    const Text(
                      'इस बार राज नहीं\nरिवाज बदलेगा',
                      textAlign: TextAlign.center,
                      style: TextStyle(
                        decoration: TextDecoration.none,
                        color: Colors.white,
                        fontWeight: FontWeight.w700,
                        fontSize: 23,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    userIndex == 6
                        ? successfullyRegisteredVolunteer()
                        : userIndex == 5
                            ? joinAsVolunteerWidget(() {
                                if (secondForm1Controller.text.isEmpty) {
                                  volunteer1Validation = true;
                                  state(() {});
                                  notifyListeners();
                                } else {
                                  volunteer1Validation = false;
                                  state(() {});
                                  notifyListeners();
                                }
                                if (secondForm2Controller.text.isEmpty) {
                                  volunteer2Validation = true;
                                  state(() {});
                                  notifyListeners();
                                } else {
                                  volunteer2Validation = false;
                                  state(() {});
                                  notifyListeners();
                                }
                                if (volunteer1SelectedValue.isEmpty) {
                                  volunteer3Validation = true;
                                  state(() {});
                                } else {
                                  volunteer3Validation = false;
                                  state(() {});
                                }
                                if (volunteer2SelectedValue.isEmpty) {
                                  volunteer4Validation = true;
                                  state(() {});
                                } else {
                                  volunteer4Validation = false;
                                  state(() {});
                                }
                                if (volunteer3SelectedValue.isEmpty) {
                                  volunteer5Validation = true;
                                  state(() {});
                                } else {
                                  volunteer5Validation = false;
                                  state(() {});
                                }
                                if (volunteer4SelectedValue.isEmpty) {
                                  volunteer6Validation = true;
                                  state(() {});
                                } else {
                                  volunteer6Validation = false;
                                  state(() {});
                                }
                                if (!volunteer1Validation &&
                                    !volunteer2Validation &&
                                    !volunteer3Validation &&
                                    !volunteer4Validation &&
                                    !volunteer5Validation &&
                                    !volunteer6Validation) {
                                  showCircleProgressDialog(context);
                                  usersRef
                                      .where('number',
                                          isEqualTo: phoneController.text)
                                      .get()
                                      .then((value) {
                                    final id = usersRef
                                        .doc(value.docs[0]['id'])
                                        .collection('volunteer')
                                        .doc()
                                        .id;
                                    usersRef
                                        .doc(value.docs[0]['id'])
                                        .collection('volunteer')
                                        .doc(id)
                                        .set({
                                      'volntr1': secondForm1Controller.text,
                                      'volntr2': secondForm2Controller.text,
                                      'volntr3': volunteer1SelectedValue,
                                      'volntr4': volunteer2SelectedValue,
                                      'volntr5': volunteer3SelectedValue,
                                      'volntr6': volunteer4SelectedValue,
                                      'volntrId': id
                                    }).then((value) {
                                      userIndex = 6;
                                      Get.back();
                                      state(() {});
                                      notifyListeners();
                                    });
                                  });
                                }
                              })
                            : userIndex == 4
                                ? spreadWidget(() {})
                                : userIndex == 3
                                    ? registeredWidget(() {
                                        showCircleProgressDialog(context);
                                        usersRef
                                            .where('number',
                                                isEqualTo: phoneController.text)
                                            .get()
                                            .then((value) {
                                          Get.back();
                                          userVidhan = value.docs[0]['vidhan'];
                                          userIndex = 4;
                                          state(() {});
                                        });
                                        notifyListeners();
                                      })
                                    : userIndex == 0
                                        ? userFieldDetailsWidget(
                                            context, isMobile, () async {
                                            state(() {});
                                            if (nameController.text.isEmpty) {
                                              nameValidation = true;
                                            } else {
                                              nameValidation = false;
                                            }
                                            if (phoneController.text.isEmpty ||
                                                phoneController.text.length <
                                                    10) {
                                              phoneValidation = true;
                                            } else {
                                              phoneValidation = false;
                                            }
                                            if (jilaController.text.isEmpty) {
                                              jilaValidation = true;
                                            } else {
                                              jilaValidation = false;
                                            }
                                            if (vidhanController.text.isEmpty) {
                                              vidhanValidation = true;
                                            } else {
                                              vidhanValidation = false;
                                            }
                                            if (ageController.text.isEmpty) {
                                              ageValidation = true;
                                            } else {
                                              ageValidation = false;
                                            }
                                            if (gendorController.text.isEmpty) {
                                              gendorValidation = true;
                                            } else {
                                              gendorValidation = false;
                                            }
                                            if (!nameValidation &&
                                                !phoneValidation &&
                                                !jilaValidation &&
                                                !vidhanValidation &&
                                                !ageValidation &&
                                                !gendorValidation) {
                                              showCircleProgressDialog(context);
                                              usersRef
                                                  .where('number',
                                                      isEqualTo:
                                                          phoneController.text)
                                                  .get()
                                                  .then((user) async {
                                                if (user.docs.isEmpty) {
                                                  DocumentReference<Object?>
                                                      doc = usersRef.doc();
                                                  id = doc.id;
                                                  notifyListeners();
                                                  await usersRef
                                                      .doc(doc.id)
                                                      .set({
                                                    'name': nameController.text,
                                                    'number':
                                                        phoneController.text,
                                                    'jila': jilaController.text,
                                                    'vidhan':
                                                        vidhanController.text,
                                                    'age': ageController.text,
                                                    'gendor':
                                                        gendorController.text,
                                                    'id': doc.id,
                                                    'isVerified': false
                                                  }).then((value) {
                                                    login(context, (verificationId,
                                                        resendingToken) async {
                                                      userIndex = 2;
                                                      notifyListeners();
                                                      this.verificationId =
                                                          verificationId;
                                                      print(
                                                          this.verificationId);
                                                      state(() {});
                                                      Get.back();
                                                    });
                                                    state(() {});
                                                    notifyListeners();
                                                    // Get.back();
                                                  });
                                                } else {
                                                  id = user.docs[0]['id'];
                                                  if (user.docs[0]
                                                      ['isVerified']) {
                                                    userIndex = 3;
                                                    state(() {});
                                                    Get.back();
                                                  } else {
                                                    login(context, (verificationId,
                                                        resendingToken) async {
                                                      userIndex = 2;
                                                      state(() {});
                                                      notifyListeners();
                                                      this.verificationId =
                                                          verificationId;
                                                      print(
                                                          this.verificationId);
                                                      Get.back();
                                                    });
                                                    state(() {});
                                                  }
                                                }
                                              });
                                            }
                                          })
                                        : userIndex == 1
                                            ? chooseBtnToJoin(context, () {
                                                showCircleProgressDialog(
                                                    context);
                                                usersRef
                                                    .where('number',
                                                        isEqualTo:
                                                            phoneController
                                                                .text)
                                                    .get()
                                                    .then((value) {
                                                  Get.back();
                                                  userVidhan =
                                                      value.docs[0]['vidhan'];
                                                  userIndex = 4;
                                                  state(() {});
                                                });
                                              }, () {
                                                userIndex = 5;
                                                state(() {});
                                              })
                                            : otpWidget(context, () async {
                                                if (otpController
                                                        .text.isEmpty ||
                                                    otpController.text.length <
                                                        6) {
                                                  otpValidation = true;
                                                  state(() {});
                                                  notifyListeners();
                                                } else {
                                                  otpValidation = false;
                                                  notifyListeners();
                                                  state(() {});
                                                  PhoneAuthCredential
                                                      phoneAuthCredential =
                                                      PhoneAuthProvider
                                                          .credential(
                                                              verificationId:
                                                                  verificationId,
                                                              smsCode:
                                                                  otpController
                                                                      .text);
                                                  try {
                                                    showCircleProgressDialog(
                                                        context);
                                                    await _auth
                                                        .signInWithCredential(
                                                            phoneAuthCredential);
                                                    if (phoneAuthCredential
                                                        .providerId
                                                        .isNotEmpty) {
                                                      // update the user
                                                      usersRef.doc(id).set({
                                                        'name':
                                                            nameController.text,
                                                        'number':
                                                            phoneController
                                                                .text,
                                                        'jila':
                                                            jilaController.text,
                                                        'vidhan':
                                                            vidhanController
                                                                .text,
                                                        'age':
                                                            ageController.text,
                                                        'gendor':
                                                            gendorController
                                                                .text,
                                                        'id': id,
                                                        'isVerified': true
                                                      }).then((value) {
                                                        userIndex = 1;
                                                        state(() {});
                                                        notifyListeners();
                                                      });
                                                      state(() {});
                                                    }
                                                    Get.back();
                                                  } on FirebaseAuthException catch (e) {
                                                    Get.back();
                                                    print(e.message);
                                                    ScaffoldMessenger.of(
                                                            context)
                                                        .showSnackBar(const SnackBar(
                                                            content: Text(
                                                                'Please enter the correct otp number',
                                                                style: TextStyle(
                                                                    fontSize:
                                                                        16))));
                                                    // setState(() {
                                                    //   // showLoading = false;
                                                    // });
                                                  }
                                                }
                                              }),
                    const SizedBox(
                      height: 20,
                    ),
                  ],
                ),
              ),
            ),
          );
        });
      },
      transitionBuilder: (context, anim1, anim2, child) {
        return SlideTransition(
          position: Tween(begin: const Offset(0, -1), end: const Offset(0, 0))
              .animate(anim1),
          child: child,
        );
      },
    );
  }

  userFieldDetailsWidget(BuildContext context, isMobile, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          CustomTextfield(
            onTap: () {},
            hintText: 'नाम *',
            controller: nameController,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            isValidation: nameValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            onTap: () {},
            hintText: 'फ़ोन नंबर *',
            controller: phoneController,
            textInputType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
              FilteringTextInputFormatter.digitsOnly,
              LengthLimitingTextInputFormatter(10)
            ],
            isValidation: phoneValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            hintText: 'ज़िला का नाम*',
            onTap: () {
              jilaAlertDialog(context, 'jila', isMobile);
            },
            controller: jilaController,
            isReadOnly: true,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            isValidation: jilaValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            onTap: () {
              isVidhanRead
                  ? null
                  : jilaAlertDialog(context, 'vidhan', isMobile);
            },
            hintText: 'विधानसभा *',
            isReadOnly: isVidhanRead,
            controller: vidhanController,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            isValidation: vidhanValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            onTap: () {},
            hintText: 'कृपया अपनी आयु दर्ज करे *',
            controller: ageController,
            textInputType: TextInputType.phone,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s')),
              FilteringTextInputFormatter.digitsOnly
            ],
            isValidation: ageValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            onTap: () {
              gendorAlertDialog(context, isMobile);
            },
            isReadOnly: true,
            hintText: 'कृपया अपना लिंग भरे *',
            controller: gendorController,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            isValidation: gendorValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomBtn(
              title: 'प्रण ले',
              height: 45,
              width: double.infinity,
              onTap: onTap),
        ],
      ),
    );
  }

  otpWidget(BuildContext context, Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          CustomTextfield(
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              isValidation: otpValidation,
              hintText: 'कृपया अपना ओटीपी दर्ज करें',
              controller: otpController,
              onTap: () {}),
          const SizedBox(
            height: 15,
          ),
          CustomBtn(
              title: 'ओटीपी दर्ज करें',
              height: 45,
              width: double.infinity,
              onTap: onTap)
        ],
      ),
    );
  }

  spreadWidget(Function() onTap) {
    return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: Column(
          children: [
            Text(
              '$userVidhan विधानसभा के मैं सेनापति राजस्थान की टीम से जुड़ने के लिए नीचे दिए बटन पर क्लिक करें',
              textAlign: TextAlign.center,
              style: const TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 18,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBtn(
                title: 'व्हाट्सएप ग्रुप में जुड़ें',
                height: 45,
                width: double.infinity,
                onTap: onTap)
          ],
        ));
  }

  registeredWidget(Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: StatefulBuilder(builder: (context, state) {
        return Column(
          children: [
            const Text(
              'आप पहले से पंजीकृत हैं',
              textAlign: TextAlign.center,
              style: TextStyle(
                decoration: TextDecoration.none,
                color: Colors.white,
                fontWeight: FontWeight.w700,
                fontSize: 23,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBtn(
                title: 'आगे बढे',
                height: 45,
                width: double.infinity,
                onTap: onTap)
          ],
        );
      }),
    );
  }

  chooseBtnToJoin(BuildContext context, Function() onTap1, Function() onTap2) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBtn(
              title: 'मैं अभियान को समर्थन देता हूँ',
              height: 50,
              width: MediaQuery.of(context).size.width * .7,
              onTap: onTap1),
          const SizedBox(
            height: 20,
          ),
          CustomBtn(
            title: 'मैं सेनापति राजस्थान बनना चाहता हूँ',
            height: 50,
            width: MediaQuery.of(context).size.width * .7,
            onTap: onTap2,
          )
        ],
      ),
    );
  }

  joinAsVolunteerWidget(Function() onTap) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: StatefulBuilder(builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            CustomTextfield(
              onTap: () {},
              hintText: 'शैक्षणिक योग्यता *',
              controller: secondForm1Controller,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              isValidation: volunteer1Validation,
            ),
            const SizedBox(
              height: 20,
            ),
            CustomTextfield(
              onTap: () {},
              hintText: 'व्यवसाय *',
              controller: secondForm2Controller,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s'))
              ],
              isValidation: volunteer2Validation,
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'आपके पास कौन सा वाहन है?',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer1SelectedValue = 'दोपहिया';
                    notifyListeners();
                    state(() {});
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(volunteer1SelectedValue, 'दोपहिया',
                          volunteer3Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'दोपहिया',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer1SelectedValue = 'चारपहिया';
                    state(() {});
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(volunteer1SelectedValue, 'चारपहिया',
                          volunteer3Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'चारपहिया',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'क्या आप वर्तमान सरकार की योजनाओं से संतुष्ट हैं?',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer2SelectedValue = 'हां';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer2SelectedValue, 'हां', volunteer4Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'हां',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer2SelectedValue = 'ना';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer2SelectedValue, 'ना', volunteer4Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'ना',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'क्या आप कांग्रेस के विधायक प्रत्याशी के कंधे से कंधा मिलाकर अपने बूथ को मजबूत करने को तैयार हैं?',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  onTap: () {
                    volunteer3SelectedValue = 'हां';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer3SelectedValue, 'हां', volunteer5Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'हां',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer3SelectedValue = 'ना';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer3SelectedValue, 'ना', volunteer5Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'ना',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              'क्या आप आने वाले चुनाव में मिली ज़िम्मेदारी को बेहतर भविष्य के लिए निष्ठापूर्वक निभाने हेतु तैयार हैं?',
              style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w400,
                  color: Colors.white,
                  decoration: TextDecoration.none),
            ),
            const SizedBox(
              height: 8,
            ),
            Row(
              children: [
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer4SelectedValue = 'हां';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer4SelectedValue, 'हां', volunteer6Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'हां',
                        style: TextStyle(
                            fontWeight: FontWeight.w400,
                            fontSize: 14,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                ),
                const SizedBox(
                  width: 20,
                ),
                GestureDetector(
                  behavior: HitTestBehavior.opaque,
                  onTap: () {
                    volunteer4SelectedValue = 'ना';
                    state(() {});
                    notifyListeners();
                  },
                  child: Row(
                    children: [
                      stringRadioBtn(
                          volunteer4SelectedValue, 'ना', volunteer6Validation),
                      const SizedBox(
                        width: 8,
                      ),
                      const Text(
                        'ना',
                        style: TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w400,
                            color: Colors.white,
                            decoration: TextDecoration.none),
                      ),
                    ],
                  ),
                )
              ],
            ),
            const SizedBox(
              height: 20,
            ),
            CustomBtn(
                title: 'आवेदन करें',
                height: 45,
                width: double.infinity,
                onTap: onTap)
          ],
        );
      }),
    );
  }

  successfullyRegisteredVolunteer() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const Text(
            'एक बेहतर राजनीति की ओर आपका लिया गया ये कदम सराहनीय है। मैं सेनापति राजस्थान टीम आपसे जल्द हीं संपर्क करेगी।',
            textAlign: TextAlign.center,
            style: TextStyle(
              decoration: TextDecoration.none,
              color: Colors.white,
              fontWeight: FontWeight.w700,
              fontSize: 23,
            ),
          ),
          const SizedBox(
            height: 20,
          ),
          CustomBtn(
              title: 'धन्यवाद',
              height: 45,
              width: double.infinity,
              onTap: () {
                Get.back();
              })
        ],
      ),
    );
  }

  jilaAlertDialog(
    BuildContext context,
    String route,
    isMobile,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              padding: const EdgeInsets.only(top: 10),
              constraints: BoxConstraints(
                  maxHeight: MediaQuery.of(context).size.height - 50,
                  minHeight: 300,
                  maxWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 300,
                  minWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 300),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          Text(
                            route == 'jila'
                                ? 'ज़िला का नाम *'
                                : 'विधानसभा का नाम *',
                            style: const TextStyle(
                                fontSize: 15, color: Colors.grey),
                          ),
                          unselectedRadioBtn()
                          // radioBtn()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, sp) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: route == 'jila'
                              ? districtList.length
                              : districtList[selectedIndex]['vidhan'].length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (route == 'jila') {
                                  selectedJila = index;
                                  jilaController.text =
                                      districtList[index]['name'];
                                  selectedIndex = index;
                                  isVidhanRead = false;
                                  vidhanController.clear();
                                  selectedVidhan = -1;
                                } else {
                                  selectedVidhan = index;
                                  vidhanController.text =
                                      districtList[selectedIndex]['vidhan']
                                          [index];
                                }
                                Get.back();
                              },
                              child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(
                                      route == 'jila'
                                          ? districtList[index]['name']
                                          : districtList[selectedIndex]
                                              ['vidhan'][index],
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    radioBtn(
                                        index,
                                        route == 'jila'
                                            ? selectedJila
                                            : selectedVidhan)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  gendorAlertDialog(
    BuildContext context,
    isMobile,
  ) {
    showDialog(
        context: context,
        builder: (context) {
          return AlertDialog(
            contentPadding: const EdgeInsets.all(0),
            insetPadding: EdgeInsets.zero,
            clipBehavior: Clip.antiAliasWithSaveLayer,
            shape:
                RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
            content: Container(
              padding: const EdgeInsets.only(top: 10),
              constraints: BoxConstraints(
                  maxHeight: 170,
                  minHeight: 170,
                  maxWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 300,
                  minWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 300),
              child: SingleChildScrollView(
                physics: const ScrollPhysics(),
                child: Padding(
                  padding: const EdgeInsets.only(left: 15, right: 15),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Text(
                            'कृपया अपना लिंग भरे *',
                            style: TextStyle(fontSize: 15, color: Colors.grey),
                          ),
                          unselectedRadioBtn()
                          // radioBtn()
                        ],
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      ListView.separated(
                          separatorBuilder: (context, sp) {
                            return const SizedBox(
                              height: 10,
                            );
                          },
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: gendorList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                gendorController.text = gendorList[index];
                                selectedGendor = index;
                                Get.back();
                              },
                              child: Container(
                                height: 30,
                                child: Row(
                                  children: [
                                    Text(
                                      gendorList[index],
                                      style: const TextStyle(fontSize: 17),
                                    ),
                                    const Spacer(),
                                    radioBtn(index, selectedGendor)
                                  ],
                                ),
                              ),
                            );
                          }),
                    ],
                  ),
                ),
              ),
            ),
          );
        });
  }

  stringRadioBtn(String selected, value, error) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        border: Border.all(
            color: error == true
                ? Colors.red
                : selected == value
                    ? const Color(0xffbd9766)
                    : const Color(0xff2596be)),
        shape: BoxShape.circle,
        // color: Colors.black,
      ),
      padding: const EdgeInsets.all(2),
      child: selected == value
          ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffbd9766)),
            )
          : Container(),
    );
  }

  radioBtn(index, selected) {
    return Container(
      height: 18,
      width: 18,
      decoration: BoxDecoration(
        border: Border.all(
            color: selected == index
                ? const Color(0xffbd9766)
                : const Color(0xff213865)),
        shape: BoxShape.circle,
        // color: Colors.black,
      ),
      padding: const EdgeInsets.all(2),
      child: selected == index
          ? Container(
              decoration: const BoxDecoration(
                  shape: BoxShape.circle, color: Color(0xffbd9766)),
            )
          : Container(),
    );
  }

  unselectedRadioBtn() {
    return Container(
        height: 18,
        width: 18,
        decoration: BoxDecoration(
          border: Border.all(color: Colors.grey),
          shape: BoxShape.circle,
          // color: Colors.black,
        ),
        padding: const EdgeInsets.all(2),
        child: Container(
          decoration:
              const BoxDecoration(shape: BoxShape.circle, color: Colors.grey),
        ));
  }
}
