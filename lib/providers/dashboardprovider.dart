import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:mainsenapatirajasthan/utils/collectionreference.dart';
import 'package:mainsenapatirajasthan/utils/showcircleprogressdialog.dart';
import 'package:mainsenapatirajasthan/helper.dart/custombtn.dart';
import 'package:mainsenapatirajasthan/helper.dart/customtextfield.dart';
import 'package:url_launcher/url_launcher.dart';
import 'package:super_tooltip/super_tooltip.dart';

class DashboardProvider extends ChangeNotifier {
  // 0---default form
  // 1--- 2 buttons
  // 2-- otp
  // 3--- registerd
  //4-- spread
  // 5--- volunteer form
  // 6--- volunteer form submit msg
  //  final  controller = SuperTooltipController();

  late String verificationId;
  int timer = 10;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  int userIndex = 0;
  String id = '';
  String userVidhan = '';

  // validation variable
  bool nameValidation = false;
  bool phoneValidation = false;
  bool districtValidation = false;
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
  final districtController = TextEditingController();
  final vidhanController = TextEditingController();
  final otpController = TextEditingController();
  final ageController = TextEditingController();
  final gendorController = TextEditingController();
  final educationController = TextEditingController();
  final businessController = TextEditingController();
  String volunteer1SelectedValue = '';
  String volunteer2SelectedValue = '';
  String volunteer3SelectedValue = '';
  String volunteer4SelectedValue = '';

  List districtList = [];
  List vidhanList = [];
  List gendorList = ['पुरुष', 'महिला', 'अन्य'];
  int selectedGendor = -1;
  int selectedDistrict = -1;
  int selectedVidhan = -1;
  int selectedIndex = 0;
  bool isVidhanRead = true;

  // education
  List educationList = [
    'उच्चतर माध्यमिक (10वीं पास)',
    'उच्चतर माध्यमिक (12वीं पास)',
    'स्नातक (बैचलर्स डिग्री)',
    'स्नातकोत्तर (मास्टर्स डिग्री)',
    'डिप्लोमा',
    'पोस्ट ग्रेजुएशन',
    'डॉक्टरेट',
    'पेशेवर डिग्री / प्रमाणपत्र',
    'व्यावसायिक प्रशिक्षण / शिक्षा',
    'अन्य (कृपया नीचे विस्तार से बताएं)'
  ];
  int selectedEducation = -1;
  bool isReadEducation = true;

  List businessList = [
    'विद्यार्थी (छात्र)',
    'कर्मचारी (नौकरशाही)',
    'व्यवसायी (व्यापार)',
    'किसान (कृषि)',
    'शिक्षक (शिक्षा)',
    'डॉक्टर (मेडिकल)',
    'इंजीनियर (तकनीकी)',
    'महिला गृहिणी (घरेलू)',
    'स्वतंत्र पेशेवर (उद्यमिता)',
    'बेरोज़गार (असंगठित)',
    'पेंशनर (अनुभवी)',
    'पत्रकार (मीडिया)',
    'अध्यापक (शिक्षा)',
    'बच्चों की देखभाल (देखभाल)',
    'विपणन / बिक्री (बिज़नेस)',
    'वैद्यकीय पेशेवर (हेल्थकेयर)',
    'कला / संगीत (कला)',
    'सेना / पुलिस (सुरक्षा)',
    'सामाजिक कार्यकर्ता (समाज सेवा)',
    'वाणिज्यिक कर्मचारी (ऑफिस काम)',
    'अन्य (कृपया नीचे विस्तार से बताएं)'
  ];
  int selectedBusiness = -1;
  bool isReadBusiness = true;

  /// selected user details
  String currentUserDistrictId = '';
  int userWhstpCounter = 0;
  String currentUserId = '';
  bool currentVolunteerStatus = false;
  fetchDistrctData() async {
    districtList.clear();
    districtRef.orderBy('districtCode', descending: false).get().then((value) {
      districtList = value.docs;
    });
  }

  fetchVidhanData(disCode) async {
    vidhanList.clear();
    vidhanRef.where('districtCode', isEqualTo: disCode).get().then((value) {
      vidhanList = value.docs;
      notifyListeners();
    });
  }

  // FirebaseAuthentication firebaseAuthentication = FirebaseAuthentication();
  login(BuildContext context, isMobile, PhoneCodeSent codeSent) async {
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
        showErrorDialog(context, isMobile, 'अपना नंबर चेक करें');
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
      transitionDuration: const Duration(milliseconds: 400),
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
                      height: 15,
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
                        ? successfullyRegisteredVolunteer(context, isMobile)
                        : userIndex == 5
                            ? joinAsVolunteerWidget(
                                isMobile,
                                state,
                              )
                            : userIndex == 4
                                ? spreadWidget(state, context, isMobile)
                                : userIndex == 3
                                    ? registeredWidget(state)
                                    : userIndex == 0
                                        ? userFieldDetailsWidget(
                                            context, isMobile, state)
                                        : userIndex == 1
                                            ? chooseBtnToJoin(
                                                context,
                                                state,
                                              )
                                            : otpWidget(context, state),
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

  userFieldDetailsWidget(BuildContext context, isMobile, state1) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          CustomTextfield(
            onTap: () {},
            hintText: 'नाम *',
            controller: nameController,
            inputFormatters: [
              FilteringTextInputFormatter.deny(RegExp(r'\s\s'))
            ],
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
              districtAlertDialog(context, 'district', isMobile);
            },
            controller: districtController,
            isReadOnly: true,
            inputFormatters: [FilteringTextInputFormatter.deny(RegExp(r'\s'))],
            isValidation: districtValidation,
          ),
          const SizedBox(
            height: 15,
          ),
          CustomTextfield(
            onTap: () {
              isVidhanRead
                  ? null
                  : districtAlertDialog(context, 'vidhan', isMobile);
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
              onTap: () async {
                state1(() {});
                if (nameController.text.isEmpty) {
                  nameValidation = true;
                } else {
                  nameValidation = false;
                }
                if (phoneController.text.isEmpty ||
                    phoneController.text.length < 10) {
                  phoneValidation = true;
                } else {
                  phoneValidation = false;
                }
                if (districtController.text.isEmpty) {
                  districtValidation = true;
                } else {
                  districtValidation = false;
                }
                if (vidhanController.text.isEmpty) {
                  vidhanValidation = true;
                } else {
                  vidhanValidation = false;
                }
                if (ageController.text.isEmpty) {
                  ageValidation = true;
                }
                // else if (int.parse(ageController.text) < 18) {
                //   ageValidation = true;
                // }
                else {
                  ageValidation = false;
                }
                if (gendorController.text.isEmpty) {
                  gendorValidation = true;
                } else {
                  gendorValidation = false;
                }
                if (!nameValidation &&
                    !phoneValidation &&
                    !districtValidation &&
                    !vidhanValidation &&
                    !ageValidation &&
                    !gendorValidation) {
                  showCircleProgressDialog(context);
                  usersRef
                      .where('number', isEqualTo: phoneController.text)
                      .get()
                      .then((user) async {
                    if (user.docs.isEmpty) {
                      DocumentReference<Object?> doc = usersRef.doc();
                      id = doc.id;
                      notifyListeners();
                      await usersRef.doc(doc.id).set({
                        'name': nameController.text,
                        'number': phoneController.text,
                        'district': districtController.text,
                        'vidhan': vidhanController.text,
                        'age': ageController.text,
                        'gendor': gendorController.text,
                        'id': doc.id,
                        'isVerified': false,
                        'volunteerStatus': false,
                        'whstpJoinStatus': false,
                        'whstpCounter': '0',
                        'districtId': currentUserDistrictId,
                        'createdAt': FieldValue.serverTimestamp(),
                        'updateAt': '',
                      }).then((value) {
                        login(context, isMobile,
                            (verificationId, resendingToken) async {
                          userIndex = 2;
                          notifyListeners();
                          this.verificationId = verificationId;
                          print(this.verificationId);
                          state1(() {});
                          Get.back();
                        });
                        state1(() {});
                        notifyListeners();
                        // Get.back();
                      });
                    } else {
                      id = user.docs[0]['id'];
                      if (user.docs[0]['isVerified']) {
                        userIndex = 3;
                        state1(() {});
                        Get.back();
                      } else {
                        login(context, isMobile,
                            (verificationId, resendingToken) async {
                          userIndex = 2;
                          state1(() {});
                          notifyListeners();
                          this.verificationId = verificationId;
                          Get.back();
                        });
                        state1(() {});
                      }
                    }
                  });
                }
              }),
        ],
      ),
    );
  }

  otpWidget(BuildContext context, state1) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, bottom: 20, top: 20),
      child: Column(
        children: [
          CustomTextfield(
              textInputType: TextInputType.number,
              inputFormatters: [
                FilteringTextInputFormatter.deny(RegExp(r'\s')),
                LengthLimitingTextInputFormatter(6)
              ],
              isValidation: otpValidation,
              hintText: 'कृपया अपना ओटीपी दर्ज करें',
              controller: otpController,
              onTap: () {}),
          const SizedBox(
            height: 20,
          ),
          CustomBtn(
              title: 'ओटीपी दर्ज करें',
              height: 45,
              width: double.infinity,
              onTap: () async {
                if (otpController.text.isEmpty ||
                    otpController.text.length < 6) {
                  otpValidation = true;
                  state1(() {});
                  notifyListeners();
                } else {
                  otpValidation = false;
                  notifyListeners();
                  state1(() {});
                  PhoneAuthCredential phoneAuthCredential =
                      PhoneAuthProvider.credential(
                          verificationId: verificationId,
                          smsCode: otpController.text);
                  try {
                    showCircleProgressDialog(context);
                    await _auth.signInWithCredential(phoneAuthCredential);
                    if (phoneAuthCredential.providerId.isNotEmpty) {
                      // update the user
                      usersRef.doc(id).update({
                        'isVerified': true,
                        'updateAt': FieldValue.serverTimestamp()
                      }).then((value) {
                        userIndex = 1;
                        state1(() {});
                        notifyListeners();
                      });
                      state1(() {});
                    }
                    Get.back();
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
              })
        ],
      ),
    );
  }

  spreadWidget(state1, BuildContext context, isMobile) {
    return Padding(
        padding:
            const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
        child: Column(
          children: [
            Text(
              '$userVidhan विधानसभा के “मैं सेनापति राजस्थान” की टीम से जुड़ने के लिए नीचे दिए बटन पर क्लिक करें',
              textAlign: TextAlign.justify,
              style: const TextStyle(
                height: 1.4,
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
                height: MediaQuery.of(context).size.width < 500 ? 65 : 50,
                width: double.infinity,
                onTap: () {
                  showCircleProgressDialog(context);
                  // usersRef.doc(currentUserId).get().then((userValue) {

                  // });
                  whatsappRef
                      .where('nameHindi', isEqualTo: userVidhan)
                      .get()
                      .then((value) {
                    if (value.docs.isNotEmpty) {
                      whatsappRef
                          .doc(value.docs[0]['id'])
                          .collection('whatsLink')
                          .orderBy('createdAt', descending: false)
                          .limit(1)
                          .get()
                          .then((value1) {
                        usersRef
                            .doc(currentUserId.toString().removeAllWhitespace)
                            .update({
                          'whstpJoinStatus': true,
                          'whstpCounter': (userWhstpCounter + 1).toString()
                        }).then((value2) {
                          userWhstpCounter = userWhstpCounter + 1;
                          whatsappRef
                              .doc(value.docs[0]['id'])
                              .collection('whatsLink')
                              .doc(value1.docs[0]['id'])
                              .update({
                            'counter':
                                (int.parse(value1.docs[0]['counter']) + 1)
                                    .toString(),
                          }).then((value3) {
                            Get.back();
                            urlLauncher(value1.docs[0]['grplink']);
                            Get.back();
                          });
                        });
                      });
                    } else {
                      Get.back();
                      showErrorDialog(
                          context, isMobile, 'व्हाट्सएप ग्रुप उपलब्ध नहीं है');
                    }
                  });
                }),
            const SizedBox(
              height: 20,
            ),
            currentVolunteerStatus
                ? Container()
                : CustomBtn(
                    title: '“मैं सेनापति राजस्थान” बनना चाहता हूँ',
                    height: MediaQuery.of(context).size.width < 500 ? 65 : 50,
                    width: double.infinity,
                    onTap: () {
                      userIndex = 5;
                      state1(() {});
                    }),
          ],
        ));
  }

  registeredWidget(state1) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
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
                onTap: () {
                  showCircleProgressDialog(context);
                  usersRef
                      .where('number', isEqualTo: phoneController.text)
                      .get()
                      .then((value) {
                    Get.back();
                    userVidhan = value.docs[0]['vidhan'];
                    currentUserId = value.docs[0]['id'];
                    currentUserDistrictId = value.docs[0]['districtId'];
                    currentVolunteerStatus = value.docs[0]['volunteerStatus'];
                    userWhstpCounter = int.parse(value.docs[0]['whstpCounter']);
                    userIndex = 4;
                    state(() {});
                    state1(() {});
                  });
                  notifyListeners();
                })
          ],
        );
      }),
    );
  }

  chooseBtnToJoin(
    BuildContext context,
    state1,
  ) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20, top: 20, bottom: 20),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          CustomBtn(
            title: 'मैं अभियान को समर्थन देता हूँ',
            height: MediaQuery.of(context).size.width < 500 ? 65 : 50,
            width: MediaQuery.of(context).size.width * .7,
            onTap: () {
              showCircleProgressDialog(context);
              usersRef
                  .where('number', isEqualTo: phoneController.text)
                  .get()
                  .then((value) {
                Get.back();
                userVidhan = value.docs[0]['vidhan'];
                currentUserId = value.docs[0]['id'];
                currentUserDistrictId = value.docs[0]['districtId'];
                currentVolunteerStatus = value.docs[0]['volunteerStatus'];
                userWhstpCounter = int.parse(value.docs[0]['whstpCounter']);
                userIndex = 4;
                state1(() {});
              });
            },
          ),
          const SizedBox(
            height: 20,
          ),
          CustomBtn(
            title: '“मैं सेनापति राजस्थान”  बनना चाहता हूँ',
            height: MediaQuery.of(context).size.width < 500 ? 65 : 50,
            width: MediaQuery.of(context).size.width * .7,
            onTap: () {
              userIndex = 5;
              state1(() {});
            },
          )
        ],
      ),
    );
  }

  joinAsVolunteerWidget(
    isMobile,
    state1,
  ) {
    return StatefulBuilder(builder: (context, state) {
      return Padding(
        padding: const EdgeInsets.only(left: 20, right: 20),
        child: StatefulBuilder(builder: (context, state) {
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              CustomTextfield(
                onTap: () {
                  isReadEducation
                      ? educationDialogBox(context, isMobile, state1)
                      : null;
                },
                isReadOnly: isReadEducation,
                hintText: 'शैक्षणिक योग्यता *',
                controller: educationController,
                inputFormatters: [
                  FilteringTextInputFormatter.deny(RegExp(r'\s'))
                ],
                isValidation: volunteer1Validation,
              ),
              const SizedBox(
                height: 20,
              ),
              MouseRegion(
                cursor: SystemMouseCursors.grab,
                child: CustomTextfield(
                  onTap: () {
                    businessDialogBox(context, isMobile, state1);
                  },
                  hintText: 'व्यवसाय *',
                  isReadOnly: isReadBusiness,
                  controller: businessController,
                  inputFormatters: [
                    FilteringTextInputFormatter.deny(RegExp(r'\s'))
                  ],
                  isValidation: volunteer2Validation,
                ),
              ),
              const SizedBox(
                height: 20,
              ),
              const Text(
                'आपके पास कौन सा वाहन है?',
                style: TextStyle(
                    fontSize: 17,
                    height: 1.4,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 10,
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      GestureDetector(
                        behavior: HitTestBehavior.opaque,
                        onTap: () {
                          volunteer1SelectedValue = 'दोपहिया';
                          notifyListeners();
                          state(() {});
                        },
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
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
                                    fontFamily: 'kadwaRegular',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          ),
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
                        child: MouseRegion(
                          cursor: SystemMouseCursors.click,
                          child: Row(
                            children: [
                              stringRadioBtn(volunteer1SelectedValue,
                                  'चारपहिया', volunteer3Validation),
                              const SizedBox(
                                width: 8,
                              ),
                              const Text(
                                'चारपहिया',
                                style: TextStyle(
                                    fontFamily: 'kadwaRegular',
                                    fontSize: 14,
                                    fontWeight: FontWeight.w400,
                                    color: Colors.white,
                                    decoration: TextDecoration.none),
                              ),
                            ],
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  GestureDetector(
                    behavior: HitTestBehavior.opaque,
                    onTap: () {
                      volunteer1SelectedValue = 'इनमे से कोई नही';
                      state(() {});
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer1SelectedValue,
                              'इनमे से कोई नही', volunteer3Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'इनमे से कोई नही',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    height: 1.4,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 10,
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer2SelectedValue, 'हां',
                              volunteer4Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'हां',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer2SelectedValue, 'ना',
                              volunteer4Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'ना',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    height: 1.4,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                children: [
                  GestureDetector(
                    onTap: () {
                      volunteer3SelectedValue = 'हां';
                      state(() {});
                      notifyListeners();
                    },
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer3SelectedValue, 'हां',
                              volunteer5Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'हां',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer3SelectedValue, 'ना',
                              volunteer5Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'ना',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontSize: 14,
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    height: 1.4,
                    letterSpacing: .8,
                    fontWeight: FontWeight.w600,
                    color: Colors.white,
                    decoration: TextDecoration.none),
              ),
              const SizedBox(
                height: 10,
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer4SelectedValue, 'हां',
                              volunteer6Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'हां',
                            style: TextStyle(
                                fontFamily: 'kadwaRegular',
                                fontWeight: FontWeight.w400,
                                fontSize: 14,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                    child: MouseRegion(
                      cursor: SystemMouseCursors.click,
                      child: Row(
                        children: [
                          stringRadioBtn(volunteer4SelectedValue, 'ना',
                              volunteer6Validation),
                          const SizedBox(
                            width: 8,
                          ),
                          const Text(
                            'ना',
                            style: TextStyle(
                                fontSize: 14,
                                fontFamily: 'kadwaRegular',
                                fontWeight: FontWeight.w400,
                                color: Colors.white,
                                decoration: TextDecoration.none),
                          ),
                        ],
                      ),
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
                  onTap: () {
                    if (educationController.text.isEmpty) {
                      volunteer1Validation = true;
                      state1(() {});
                      notifyListeners();
                    } else {
                      volunteer1Validation = false;
                      state1(() {});
                      notifyListeners();
                    }
                    if (businessController.text.isEmpty) {
                      volunteer2Validation = true;
                      state1(() {});
                      notifyListeners();
                    } else {
                      volunteer2Validation = false;
                      state1(() {});
                      notifyListeners();
                    }
                    if (volunteer1SelectedValue.isEmpty) {
                      volunteer3Validation = true;
                      state1(() {});
                    } else {
                      volunteer3Validation = false;
                      state1(() {});
                    }
                    if (volunteer2SelectedValue.isEmpty) {
                      volunteer4Validation = true;
                      state1(() {});
                    } else {
                      volunteer4Validation = false;
                      state1(() {});
                    }
                    if (volunteer3SelectedValue.isEmpty) {
                      volunteer5Validation = true;
                      state1(() {});
                    } else {
                      volunteer5Validation = false;
                      state1(() {});
                    }
                    if (volunteer4SelectedValue.isEmpty) {
                      volunteer6Validation = true;
                      state1(() {});
                    } else {
                      volunteer6Validation = false;
                      state1(() {});
                    }
                    if (!volunteer1Validation &&
                        !volunteer2Validation &&
                        !volunteer3Validation &&
                        !volunteer4Validation &&
                        !volunteer5Validation &&
                        !volunteer6Validation) {
                      showCircleProgressDialog(context);
                      usersRef
                          .where('number', isEqualTo: phoneController.text)
                          .get()
                          .then((value) {
                        usersRef
                            .doc(value.docs[0]['id'])
                            .update({'volunteerStatus': true});
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
                          'education': educationController.text,
                          'occupation': businessController.text,
                          'vehicle_type': volunteer1SelectedValue,
                          'govt_statisfaction': volunteer2SelectedValue,
                          'congress_worker': volunteer3SelectedValue,
                          'onground_work': volunteer4SelectedValue,
                          'id': id
                        }).then((value) {
                          userIndex = 6;
                          Get.back();
                          state(() {});
                          state1(() {});
                        });
                      });
                    }
                  })
            ],
          );
        }),
      );
    });
  }

  successfullyRegisteredVolunteer(BuildContext context, isMobile) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          const Text(
            'एक बेहतर राजनीति की ओर आपका लिया गया ये कदम सराहनीय है। “मैं सेनापति राजस्थान” टीम आपसे जल्द हीं संपर्क करेगी।',
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
              }),
          // const SizedBox(
          //   height: 20,
          // ),
          // CustomBtn(
          //     title: 'व्हाट्सएप ग्रुप में जुड़ें',
          //     height: 45,
          //     width: double.infinity,
          //     onTap: () {
          //       showCircleProgressDialog(context);
          //       // usersRef.doc(currentUserId).get().then((userValue) {

          //       // });
          //       whatsappRef
          //           .where('nameHindi', isEqualTo: userVidhan)
          //           .get()
          //           .then((value) {
          //         if (value.docs.isNotEmpty) {
          //           whatsappRef
          //               .doc(value.docs[0]['id'])
          //               .collection('whatsLink')
          //               .orderBy('createdAt', descending: false)
          //               .limit(1)
          //               .get()
          //               .then((value1) {
          //             usersRef
          //                 .doc(currentUserId.toString().removeAllWhitespace)
          //                 .update({
          //               'whstpJoinStatus': true,
          //               'whstpCounter': (userWhstpCounter + 1).toString()
          //             }).then((value2) {
          //               userWhstpCounter = userWhstpCounter + 1;
          //               whatsappRef
          //                   .doc(value.docs[0]['id'])
          //                   .collection('whatsLink')
          //                   .doc(value1.docs[0]['id'])
          //                   .update({
          //                 'counter': (int.parse(value1.docs[0]['counter']) + 1)
          //                     .toString(),
          //               }).then((value3) {
          //                 Get.back();
          //                 urlLauncher(value1.docs[0]['grplink']);
          //                 Get.back();
          //               });
          //             });
          //           });
          //         } else {
          //           Get.back();
          //           showErrorDialog(
          //               context, isMobile, 'व्हाट्सएप ग्रुप उपलब्ध नहीं है');
          //         }
          //       });
          //     }),
        ],
      ),
    );
  }

  districtAlertDialog(
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
                            route == 'district'
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
                          padding: const EdgeInsets.only(bottom: 10),
                          physics: const ScrollPhysics(),
                          shrinkWrap: true,
                          itemCount: route == 'district'
                              ? districtList.length
                              : vidhanList.length,
                          itemBuilder: (context, index) {
                            return GestureDetector(
                              behavior: HitTestBehavior.opaque,
                              onTap: () {
                                if (route == 'district') {
                                  selectedDistrict = index;
                                  districtController.text =
                                      districtList[index]['nameHindi'];
                                  currentUserDistrictId =
                                      districtList[index]['id'];
                                  fetchVidhanData(
                                      districtList[index]['districtCode']);
                                  selectedIndex = index;
                                  isVidhanRead = false;
                                  vidhanController.clear();
                                  selectedVidhan = -1;
                                } else {
                                  selectedVidhan = index;
                                  vidhanController.text =
                                      vidhanList[index]['nameHindi'];
                                }
                                Get.back();
                              },
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
                                child: SizedBox(
                                  height: 30,
                                  child: Row(
                                    children: [
                                      Text(
                                        route == 'district'
                                            ? districtList[index]['nameHindi']
                                            : vidhanList[index]['nameHindi'],
                                        style: const TextStyle(
                                            fontSize: 17,
                                            fontFamily: 'kadwaRegular'),
                                      ),
                                      const Spacer(),
                                      radioBtn(
                                          index,
                                          route == 'district'
                                              ? selectedDistrict
                                              : selectedVidhan)
                                    ],
                                  ),
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

  educationDialogBox(BuildContext context, isMobile, state1) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 50,
                    minHeight: 300,
                    maxWidth:
                        isMobile ? MediaQuery.of(context).size.width - 50 : 300,
                    minWidth: isMobile
                        ? MediaQuery.of(context).size.width - 50
                        : 300),
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
                            const Flexible(
                              child: Text(
                                'कृपया अपना शैक्षणिक योग्यता भरे *',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
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
                            itemCount: educationList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  educationController.text =
                                      index == 9 ? '' : educationList[index];
                                  selectedEducation = index;
                                  isReadEducation = index == 9 ? false : true;
                                  state(() {});
                                  state1(() {});
                                  Get.back();
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    // height: 30,
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            educationList[index],
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        radioBtn(index, selectedEducation)
                                      ],
                                    ),
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
        });
  }

  businessDialogBox(BuildContext context, isMobile, state1) {
    showDialog(
        context: context,
        builder: (context) {
          return StatefulBuilder(builder: (context, state) {
            return AlertDialog(
              contentPadding: const EdgeInsets.all(0),
              insetPadding: EdgeInsets.zero,
              clipBehavior: Clip.antiAliasWithSaveLayer,
              shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10)),
              content: Container(
                padding: const EdgeInsets.only(top: 10, bottom: 10),
                constraints: BoxConstraints(
                    maxHeight: MediaQuery.of(context).size.height - 50,
                    minHeight: 300,
                    maxWidth:
                        isMobile ? MediaQuery.of(context).size.width - 50 : 300,
                    minWidth: isMobile
                        ? MediaQuery.of(context).size.width - 50
                        : 300),
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
                            const Flexible(
                              child: Text(
                                'कृपया अपना व्यवसाय भरे *',
                                style:
                                    TextStyle(fontSize: 15, color: Colors.grey),
                              ),
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
                            itemCount: businessList.length,
                            itemBuilder: (context, index) {
                              return GestureDetector(
                                behavior: HitTestBehavior.opaque,
                                onTap: () {
                                  businessController.text =
                                      index == 20 ? '' : businessList[index];
                                  selectedBusiness = index;
                                  isReadBusiness = index == 20 ? false : true;
                                  state(() {});
                                  state1(() {});
                                  Get.back();
                                },
                                child: MouseRegion(
                                  cursor: SystemMouseCursors.click,
                                  child: Container(
                                    padding: const EdgeInsets.only(
                                        top: 4, bottom: 4),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Flexible(
                                          child: Text(
                                            businessList[index],
                                            style:
                                                const TextStyle(fontSize: 17),
                                          ),
                                        ),
                                        // const Spacer(),
                                        radioBtn(index, selectedBusiness)
                                      ],
                                    ),
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
                              child: MouseRegion(
                                cursor: SystemMouseCursors.click,
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

  showErrorDialog(BuildContext context, isMobile, String title) {
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
              padding: const EdgeInsets.only(top: 10, left: 20, right: 20),
              constraints: BoxConstraints(
                  maxHeight: 100,
                  minHeight: 100,
                  maxWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 200,
                  minWidth:
                      isMobile ? MediaQuery.of(context).size.width - 50 : 200),
              child: Column(
                children: [
                  Text(title),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomBtn(
                      title: "ठीक है",
                      height: 45,
                      width: 100,
                      onTap: () {
                        Get.back();
                        Get.back();
                      })
                ],
              ),
            ),
          );
        });
  }

  urlLauncher(String url) async {
    if (await canLaunch(url)) {
      await launch(url);
    } else {
      throw 'Could not launch $url';
    }
  }
}
