// import 'package:flutter/material.dart';
// import 'package:get/get.dart';
// import 'package:sarkar/utils/collectionreference.dart';

// class DashBoardController extends GetxController {
//   // validation variable
//   bool nameValidation = false;
//   bool phoneValidation = false;
//   bool jilaValidation = false;
//   bool vidhanValidation = false;
//   bool ageValidation = false;
//   bool gendorValidation = false;

//   final nameController = TextEditingController();
//   final phoneController = TextEditingController();
//   final jilaController = TextEditingController();
//   final vidhanController = TextEditingController();
//   final otpController = TextEditingController();
//   final ageController = TextEditingController();
//   final gendorController = TextEditingController();
//   List gendorList = ['पुरुष', 'महिला', 'अन्य'];
//   int selectedGendor = -1;
//   List districtList = [];
//   int selectedJila = -1;
//   int selectedVidhan = -1;
//   int selectedIndex = 0;
//   bool isVidhanRead = true;
//   fetchDistrctData() async {
//     districtList.clear();
//     district.get().then((value) {
//       districtList = value.docs;
//     });
//   }
// }
