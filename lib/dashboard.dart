import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:sarkar/helper.dart/custombtn.dart';
import 'package:sarkar/helper.dart/customtextfield.dart';
import 'package:sarkar/providers/dashboardprovider.dart';
import 'package:sarkar/widget/fotter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool validate = false;
  bool loading = false;
  // AuthService auth = AuthService();
  bool showDialogBox = false;

  sendOTP(String phoneNumber) async {
    phoneNumber;
    FirebaseAuth auth = FirebaseAuth.instance;
    ConfirmationResult confirmationResult = await auth.signInWithPhoneNumber(
      '+91 $phoneNumber',
    );
    print("OTP Sent to +91 $phoneNumber");
    // printMessage("OTP Sent to +91 $phoneNumber");
    return confirmationResult;
  }

  @override
  void initState() {
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.fetchDistrctData();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<DashboardProvider>(context);
    bool isMobile = ResponsiveBreakpoints.of(context).isMobile;
    bool isTablet = ResponsiveBreakpoints.of(context).isTablet;

    return isMobile || isTablet
        ? phoneDesign(isMobile, isTablet, provider)
        : webDesign(isMobile, isTablet, provider);
  }

  webDesign(isMobile, isTablet, DashboardProvider provider) {
    return Scaffold(
      backgroundColor: Colors.transparent,
      resizeToAvoidBottomInset: false,
      // bottomNavigationBar: fotterWidget(context),
      body: Padding(
        padding: const EdgeInsets.only(),
        child: SingleChildScrollView(
          physics: const ScrollPhysics(),
          scrollDirection: Axis.vertical,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Container(
              //   height: 100,
              //   padding: const EdgeInsets.only(right: 5, top: 5),
              //   color: const Color(0xffdac19f),
              //   width: double.infinity,
              //   alignment: Alignment.centerLeft,
              //   child: Image.asset(
              //     'assets/icons/senapatilogo.webp',
              //     height: 120,
              //     width: 120,
              //     // fit: BoxFit.fill,
              //   ),
              // ),
              Stack(
                children: [
                  Image.asset(
                    'assets/icons/webbanner.jpg',
                    fit: BoxFit.cover,
                    width: double.infinity,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 10, top: 5),
                    child: Image.asset(
                      'assets/icons/12.webp',
                      height: 120,
                      width: 120,
                    ),
                  ),
                  Positioned(
                    bottom: 0 + 210,
                    right: 0,
                    child: Padding(
                      padding: const EdgeInsets.only(right: 25),
                      child: Align(
                        alignment: Alignment.topRight,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            const Text(
                              'इस बार राज नहीं रिवाज बदलेगा',
                              textAlign: TextAlign.center,
                              style: TextStyle(
                                decoration: TextDecoration.none,
                                fontFamily: 'briyaniSemi',
                                color: Color(0xffdd2795),
                                fontWeight: FontWeight.w700,
                                fontSize: 25,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            CustomBtn(
                              title: 'प्रण ले',
                              height: 50,
                              width: isMobile || isTablet
                                  ? MediaQuery.of(context).size.width * .7
                                  : 260,
                              onTap: () {
                                provider.dialogBox(isMobile, isTablet, context);
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Container(
                height: 8,
                color: const Color(0xffbd9766),
              ),
              const SizedBox(
                height: 20,
              ),
              midWebContent(),
              SizedBox(
                height: MediaQuery.of(context).size.height * .04,
              ),
              fotterWidget(context)
            ],
          ),
        ),
      ),
    );
  }

  midWebContent() {
    return Container(
      padding: const EdgeInsets.only(right: 30),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(
              width: double.infinity,
              child: Image.asset(
                'assets/icons/12.webp',
                height: 300,
                width: 200,
              ),
            ),
          ),
          const SizedBox(
            width: 50,
          ),
          const Flexible(
            child: SizedBox(
                width: double.infinity,
                child: Text(
                  "मैं सेनापति राजस्थान क्या है ?\nराजस्थान की आने वाली पीढ़ियों के भविष्य को सुरक्षित करने की दिशा में सेनापति राजस्थान हर तरीके से तैयार है।\nहमारा अस्तित्व सम्मान, सौहार्द, सेवा तथा विकास की राजनीति से है।\n\nऐसे युवा आवेदन कर सेनापति राजस्थान बन सकते हैं जो अपने क्षेत्र के विधायक प्रत्याशी से कंधे से कंधा मिलाकर प्रदेश की जनता के हित में एक बेहतर राजनीति सुनिश्चित करने को तैयार हैं।\n\nराजस्थान प्रदेश स्वाभिमान और स्वाधीनता का प्रतीक है, यहाँ शौर्य और बलिदान के साथ वैभवशाली भाईचारे का अपना एक इतिहास है। यहाँ हजारों ऐसे उदहारण है जो बताते है की कैसे वीरों द्वारा बलिदान देकर जनतंत्र की सुरक्षा की गई। यहाँ के किसान और कमेरा के स्वाधीनता के साथ महिला सम्मान और स्वालंबन की अपनी ही एक कथा है । \n\nमैं सेनापति राजस्थान हूँ क्योंकि मैं चाहता हूँ की राजस्थान की प्रजा सुरक्षित हाथों में अपना राज रखे।\n\nमैं जनता हूँ गुजरात के ग्रेहन को, मैं जानता हूँ उतर प्रदेश के जंगलराज को, मैं जानता हूँ मामा के महिला अत्याचार को मैं जानता हूँ हरियाणा के किसान दमन को बेरोजगारी को इसलिए मेरी मुहीम है प्रदेश को सुरक्षित हाथों में रखने की \n\n“मैं सेनापति राजस्थान” एक जन-आंदोलन  की शुरुआत है, प्रदेश के हर घर और गाँव-ढाणी से सेनापति तैयार हो रहें हैं अपने परिवार तथा क्षेत्र की आवाज बन कर एक सही सरकार को दोहराने के लिए।\n\n\nआइए मिलकर प्राण लें -\nराजस्थान से मेरी पहचान ।\nमैं सेनापति राजस्थान ।।",
                  style: TextStyle(fontSize: 17),
                )),
          )
        ],
      ),
    );
  }

  midPhoneContent() {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        children: [
          Image.asset(
            'assets/icons/12.webp',
            height: 300,
            width: 200,
          ),
          const SizedBox(
            width: 10,
          ),
          const Text(
            "मैं सेनापति राजस्थान क्या है ?\nराजस्थान की आने वाली पीढ़ियों के भविष्य को सुरक्षित करने की दिशा में सेनापति राजस्थान हर तरीके से तैयार है।\nहमारा अस्तित्व सम्मान, सौहार्द, सेवा तथा विकास की राजनीति से है।\n\nऐसे युवा आवेदन कर सेनापति राजस्थान बन सकते हैं जो अपने क्षेत्र के विधायक प्रत्याशी से कंधे से कंधा मिलाकर प्रदेश की जनता के हित में एक बेहतर राजनीति सुनिश्चित करने को तैयार हैं।\n\nराजस्थान प्रदेश स्वाभिमान और स्वाधीनता का प्रतीक है, यहाँ शौर्य और बलिदान के साथ वैभवशाली भाईचारे का अपना एक इतिहास है। यहाँ हजारों ऐसे उदहारण है जो बताते है की कैसे वीरों द्वारा बलिदान देकर जनतंत्र की सुरक्षा की गई। यहाँ के किसान और कमेरा के स्वाधीनता के साथ महिला सम्मान और स्वालंबन की अपनी ही एक कथा है । \n\nमैं सेनापति राजस्थान हूँ क्योंकि मैं चाहता हूँ की राजस्थान की प्रजा सुरक्षित हाथों में अपना राज रखे।\n\nमैं जनता हूँ गुजरात के ग्रेहन को, मैं जानता हूँ उतर प्रदेश के जंगलराज को, मैं जानता हूँ मामा के महिला अत्याचार को मैं जानता हूँ हरियाणा के किसान दमन को बेरोजगारी को इसलिए मेरी मुहीम है प्रदेश को सुरक्षित हाथों में रखने की \n\n“मैं सेनापति राजस्थान” एक जन-आंदोलन  की शुरुआत है, प्रदेश के हर घर और गाँव-ढाणी से सेनापति तैयार हो रहें हैं अपने परिवार तथा क्षेत्र की आवाज बन कर एक सही सरकार को दोहराने के लिए।\n\n\nआइए मिलकर प्राण लें -\nराजस्थान से मेरी पहचान ।\nमैं सेनापति राजस्थान ।।",
            style: TextStyle(fontSize: 17),
          )
        ],
      ),
    );
  }

  phoneDesign(isMobile, isTablet, DashboardProvider provider) {
    return Scaffold(
      backgroundColor: Colors.white,
      resizeToAvoidBottomInset: false,
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 80,
              padding: const EdgeInsets.only(right: 5, top: 5, left: 5),
              color: const Color(0xffdac19f),
              width: double.infinity,
              alignment: Alignment.center,
              child: Image.asset(
                'assets/icons/12.webp',
                height: 100,
                width: 100,
                // fit: BoxFit.fill,
              ),
            ),
            Image.asset(
              'assets/icons/mobilebanner1.webp',
              fit: BoxFit.cover,
              width: double.infinity,
              // height: 450,
            ),
            const SizedBox(
              height: 40,
            ),
            const Padding(
              padding: EdgeInsets.only(left: 15, right: 15),
              child: Text(
                'इस बार राज नहीं रिवाज बदलेगा',
                textAlign: TextAlign.center,
                style: TextStyle(
                  decoration: TextDecoration.none,
                  fontFamily: 'briyaniSemi',
                  color: Color(0xffdd2795),
                  fontWeight: FontWeight.w700,
                  fontSize: 25,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(top: 10, left: 15, right: 15),
              child: CustomBtn(
                title: 'प्रण ले',
                height: 50,
                width: double.infinity,
                onTap: () {
                  provider.dialogBox(isMobile, isTablet, context);
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            midPhoneContent(),
            const SizedBox(
              height: 40,
            ),
            fotterWidget(context),
          ],
        ),
      ),
    );
  }
}
