import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sarkar/helper.dart/custombtn.dart';
import 'package:sarkar/helper.dart/customtextfield.dart';
import 'package:sarkar/utils/collectionreference.dart';
import 'package:sarkar/utils/showcircleprogressdialog.dart';

class SpreadCampagin extends StatefulWidget {
  final String id;
  const SpreadCampagin(this.id);

  @override
  State<SpreadCampagin> createState() => _SpreadCampaginState();
}

class _SpreadCampaginState extends State<SpreadCampagin> {
  final formKey = GlobalKey<FormState>();
  final nameController = TextEditingController();
  final phoneController = TextEditingController();
  final jilaController = TextEditingController();
  final vidhanController = TextEditingController();

  setFormData() async {
    DocumentReference<Object?> doc = spreadCampagin.doc();
    if (formKey.currentState!.validate()) {
      showCircleProgressDialog(context);
      await spreadCampagin.doc(doc.id).set({
        'name': nameController.text,
        'number': phoneController.text,
        'jila': jilaController.text,
        'vidhan': vidhanController.text,
        'id': doc.id,
        'userId': widget.id
      }).then((value) {
        ScaffoldMessenger.of(context).showSnackBar(const SnackBar(
            width: 200,
            behavior: SnackBarBehavior.floating,
            backgroundColor: Colors.green,
            content: Text(
              'Successfully Added',
              textAlign: TextAlign.center,
            )));
        Navigator.pop(context);
        setState(() {});
      });
      Navigator.pop(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xfffbffe8),
      body: Align(
        alignment: Alignment.center,
        child: Container(
          width: 280,
          alignment: Alignment.center,
          child: SingleChildScrollView(
            child: Form(
              key: formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  const Text(
                    'कांग्रेस सरकार के कुशासन का अंत करने के लिए प्रण लें',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      decoration: TextDecoration.none,
                      color: Colors.black,
                      fontWeight: FontWeight.w700,
                      fontSize: 20,
                    ),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  CustomTextfield(
                    onTap: () {},
                    hintText: 'नाम *',
                    controller: nameController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
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
                    onTap: () {},
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
                    onTap: () {},
                    hintText: 'ज़िला का नाम*',
                    controller: jilaController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
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
                    onTap: () {},
                    hintText: 'विधानसभा *',
                    controller: vidhanController,
                    inputFormatters: [
                      FilteringTextInputFormatter.deny(RegExp(r'\s')),
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
                      if (formKey.currentState!.validate()) {
                        setFormData();
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
