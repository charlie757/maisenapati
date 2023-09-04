import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:mainsenapatirajasthan/utils/firebaseauth.dart';
import 'package:mainsenapatirajasthan/utils/routes.dart';
import 'package:provider/provider.dart';
import 'package:responsive_framework/responsive_breakpoints.dart';
import 'package:mainsenapatirajasthan/helper.dart/custombtn.dart';
import 'package:mainsenapatirajasthan/providers/dashboardprovider.dart';
import 'package:mainsenapatirajasthan/widget/fotter.dart';

class Dashboard extends StatefulWidget {
  const Dashboard();

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  bool validate = false;
  bool loading = false;
  // AuthService auth = AuthService();
  bool showDialogBox = false;

  late Image backgroundImage;
  late Image phoneBackgroundImg;
  late Image phoneLogo;
  late Image logo;
  @override
  void initState() {
    backgroundImage = Image.asset(
      'assets/icons/dasktopbanner3.webp',
      width: double.infinity,
      fit: BoxFit.cover,
    );
    logo = Image.asset(
      'assets/icons/logo2.webp',
      height: 300,
      width: 200,
    );
    phoneLogo = Image.asset(
      'assets/icons/logo2.webp',
      height: 200,
      width: 200,
    );
    phoneBackgroundImg = Image.asset(
      'assets/icons/mobilebanner.webp',
      fit: BoxFit.cover,
      width: double.infinity,
      // height: 450,
    );
    final provider = Provider.of<DashboardProvider>(context, listen: false);
    provider.fetchDistrctData();
    super.initState();
  }

  @override
  void didChangeDependencies() {
    precacheImage(backgroundImage.image, context);
    precacheImage(logo.image, context);
    precacheImage(phoneBackgroundImg.image, context);
    precacheImage(phoneLogo.image, context);
    super.didChangeDependencies();
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
      body: RefreshIndicator(
        onRefresh: () async {
          Future.delayed(const Duration(milliseconds: 500), () {
            Get.toNamed(Routes.dashboard);
          });
        },
        child: Padding(
          padding: const EdgeInsets.only(),
          child: SingleChildScrollView(
            physics: const ScrollPhysics(),
            scrollDirection: Axis.vertical,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(
                  // height: 665,
                  child: Stack(
                    children: [
                      //image
                      backgroundImage,
                      Padding(
                        padding: const EdgeInsets.only(left: 10, top: 5),
                        child: Image.asset(
                          'assets/icons/logo2.webp',
                          height: (MediaQuery.of(context).size.width < 1000 &&
                                  MediaQuery.of(context).size.width < 1200)
                              ? 90
                              : 120,
                          width: (MediaQuery.of(context).size.width < 1000 &&
                                  MediaQuery.of(context).size.width < 1200)
                              ? 90
                              : 120,
                        ),
                      ),
                      Positioned(
                        bottom: (MediaQuery.of(context).size.width < 900 &&
                                MediaQuery.of(context).size.width < 1000)
                            ? 0 + 150
                            : (MediaQuery.of(context).size.width < 1000 &&
                                    MediaQuery.of(context).size.width < 1200)
                                ? 0 + 180
                                : (MediaQuery.of(context).size.width > 1000 &&
                                        MediaQuery.of(context).size.width <
                                            1200)
                                    ? 0 + 240
                                    : 0 + 290,
                        right: 0,
                        child: Padding(
                          padding: const EdgeInsets.only(right: 85),
                          child: Align(
                            alignment: Alignment.topRight,
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  'इस बार राज नही रिवाज बदलेगा',
                                  textAlign: TextAlign.justify,
                                  style: TextStyle(
                                    decoration: TextDecoration.none,
                                    fontFamily: 'briyaniSemi',
                                    color: Colors.black,
                                    fontWeight: FontWeight.w700,
                                    fontSize:
                                        MediaQuery.of(context).size.width < 1000
                                            ? 20
                                            : 25,
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
                                      : MediaQuery.of(context).size.width < 1000
                                          ? 200
                                          : 260,
                                  onTap: () {
                                    // FirebaseAuthentication
                                    //     firebaseAuthentication =
                                    //     FirebaseAuthentication();
                                    // firebaseAuthentication.sendOTP('9782485409');
                                    provider.dialogBox(
                                        isMobile, isTablet, context);
                                  },
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                Container(
                  height: 8,
                  color: const Color(0xffbd9766),
                ),
                // const SizedBox(
                //   height: 26,
                // ),
                midWebContent(),
                // SizedBox(
                //   height: MediaQuery.of(context).size.height * .04,
                // ),
                fotterWidget(context)
              ],
            ),
          ),
        ),
      ),
    );
  }

  midWebContent() {
    return Container(
      padding: const EdgeInsets.only(right: 30, top: 10, bottom: 10),
      color: const Color(0xffb89058).withOpacity(.8),
      // decoration: const BoxDecoration(
      //     image: DecorationImage(
      //         image: AssetImage('assets/icons/bgbanner.jpg'),
      //         fit: BoxFit.cover)),
      child: Row(
        // mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Flexible(
            child: SizedBox(width: double.infinity, child: logo),
          ),
          const SizedBox(
            width: 50,
          ),
          Flexible(
            child: SizedBox(
                width: double.infinity,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: const [
                    Text(
                      'मैं सेनापति राजस्थान क्या है ?',
                      textAlign: TextAlign.justify,
                      style: TextStyle(
                          fontSize: 30,
                          fontWeight: FontWeight.w500,
                          fontFamily: 'tekoMedium'),
                    ),
                    SizedBox(
                      height: 13,
                    ),
                    Text.rich(TextSpan(
                        text:
                            'राजस्थान की आने वाली पीढ़ियों के लिए सामाजिक सुरक्षा प्रदान करने की दिशा मैं सेनापति राजस्थान पूर्णतः तैयार है।\n\n',
                        style: TextStyle(
                            fontSize: 17,
                            color: Colors.black,
                            fontWeight: FontWeight.w400),
                        children: [
                          TextSpan(
                              text:
                                  'हमारा अस्तित्व सम्मान, सौहार्द, सेवा तथा विकास की राजनीति से है।\n\n',
                              style: TextStyle(
                                  fontSize: 17,
                                  color: Colors.black,
                                  fontWeight: FontWeight.w400),
                              children: [
                                TextSpan(
                                    text:
                                        'ऐसे युवा आवेदन कर सेनापति राजस्थान बन सकते हैं जो अपने क्षेत्र के विधायक जन-प्रत्याशी से कंधे से कंधा मिलाकर प्रदेश की जनता के हित में एक बेहतर राजनीति सुनिश्चित करने को तैयार हैं।\n\n',
                                    style: TextStyle(
                                        fontSize: 17,
                                        color: Color.fromARGB(255, 9, 34, 43),
                                        fontWeight: FontWeight.w900),
                                    children: [
                                      TextSpan(
                                          text:
                                              'राजस्थान प्रदेश स्वाभिमान और स्वाधीनता का प्रतीक है, यहाँ शौर्य और बलिदान के साथ वैभवशाली भाईचारे का अपना एक इतिहास है। यहाँ हजारों ऐसे उदहारण है जो बताते है कि कैसे वीरों द्वारा बलिदान देकर भी जनतंत्र की सुरक्षा की गई।\n\n',
                                          style: TextStyle(
                                              fontSize: 17,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w400),
                                          children: [
                                            TextSpan(
                                                text:
                                                    '“मैं सेनापति राजस्थान” एक जन-आंदोलन  की शुरुआत है, प्रदेश के प्रतिभाशाली व्यक्तित्व सेनापति राजस्थान से जुड़ क्षेत्र की आवाज बन कर एक सही सरकार तथा विचारधारा को मजबूत कर मैं सेनापति राजस्थान कहलाते हैं।\n\n',
                                                style: TextStyle(
                                                    fontSize: 17,
                                                    color: Colors.black,
                                                    fontWeight:
                                                        FontWeight.w400),
                                                children: [
                                                  TextSpan(
                                                      text:
                                                          'सम्मान की राजनीति है मेरी पहचान ।।\n',
                                                      style: TextStyle(
                                                          fontSize: 17,
                                                          color: Colors.black,
                                                          fontWeight:
                                                              FontWeight.w400),
                                                      children: [
                                                        TextSpan(
                                                            text:
                                                                'मैं सेनापति राजस्थान ।।',
                                                            style: TextStyle(
                                                                fontSize: 17,
                                                                fontWeight:
                                                                    FontWeight
                                                                        .w400,
                                                                color: Colors
                                                                    .black))
                                                      ])
                                                ])
                                          ])
                                    ])
                              ])
                        ]))
                  ],
                )),
          )
        ],
      ),
    );
  }

  midPhoneContent(isTablet) {
    return Padding(
      padding: const EdgeInsets.only(left: 20, right: 20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Align(alignment: Alignment.center, child: phoneLogo),
          const SizedBox(
            height: 10,
          ),
          const Text(
            'मैं सेनापति राजस्थान क्या है ?',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 30,
                fontWeight: FontWeight.w500,
                fontFamily: 'tekoMedium'),
          ),
          const SizedBox(
            height: 13,
          ),
          const Text(
            'राजस्थान की आने वाली पीढ़ियों के लिए सामाजिक सुरक्षा प्रदान करने की दिशा मैं सेनापति राजस्थान पूर्णतः तैयार है।\n',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const Text(
            'हमारा अस्तित्व सम्मान, सौहार्द, सेवा तथा विकास की राजनीति से है।\n',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const Text(
            'ऐसे युवा आवेदन कर सेनापति राजस्थान बन सकते हैं जो अपने क्षेत्र के विधायक जन-प्रत्याशी से कंधे से कंधा मिलाकर प्रदेश की जनता के हित में एक बेहतर राजनीति सुनिश्चित करने को तैयार हैं।\n',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17,
                color: Color(0xff2596be),
                fontWeight: FontWeight.w700),
          ),
          const Text(
            'राजस्थान प्रदेश स्वाभिमान और स्वाधीनता का प्रतीक है, यहाँ शौर्य और बलिदान के साथ वैभवशाली भाईचारे का अपना एक इतिहास है। यहाँ हजारों ऐसे उदहारण है जो बताते है कि कैसे वीरों द्वारा बलिदान देकर भी जनतंत्र की सुरक्षा की गई।\n',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const Text(
            '“मैं सेनापति राजस्थान” एक जन-आंदोलन  की शुरुआत है, प्रदेश के प्रतिभाशाली व्यक्तित्व सेनापति राजस्थान से जुड़ क्षेत्र की आवाज बन कर एक सही सरकार तथा विचारधारा को मजबूत कर मैं सेनापति राजस्थान कहलाते हैं।\n',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const Text(
            'सम्मान की राजनीति है मेरी पहचान ।।',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
          const Text(
            'मैं सेनापति राजस्थान ।।',
            textAlign: TextAlign.start,
            style: TextStyle(
                fontSize: 17, color: Colors.black, fontWeight: FontWeight.w400),
          ),
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
            // Container(
            //   height: 130,
            //   padding: const EdgeInsets.only(right: 5, left: 4),
            //   color: const Color(0xffdac19f),
            //   width: double.infinity,
            //   alignment: Alignment.centerLeft,
            //   child: Image.asset(
            //     'assets/icons/12.webp',
            //     height: 130,
            //     width: 130,
            //     // fit: BoxFit.contain,
            //   ),
            // ),
            Stack(
              children: [
                // image
                phoneBackgroundImg,
                Padding(
                  padding: const EdgeInsets.only(left: 7),
                  child: Image.asset(
                    'assets/icons/logo2.webp',
                    height: 100,
                    width: 100,
                  ),
                )
              ],
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
                  provider.dialogBox(isMobile, isTablet, context);
                },
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              height: 6,
              color: const Color(0xffdac19f),
            ),
            const SizedBox(
              height: 30,
            ),
            midPhoneContent(isTablet),
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
