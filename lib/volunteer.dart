import 'package:flutter/material.dart';
import 'package:sarkar/helper.dart/custombtn.dart';
import 'package:sarkar/helper.dart/customtextfield.dart';

class Volunteer extends StatefulWidget {
  const Volunteer({super.key});

  @override
  State<Volunteer> createState() => _VolunteerState();
}

class _VolunteerState extends State<Volunteer> {
  final incomeController = TextEditingController();
  final occupationController = TextEditingController();
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
                  hintText: 'Occupation *',
                  controller: occupationController,
                ),
                const SizedBox(
                  height: 10,
                ),
                CustomTextfield(
                  onTap: () {},
                  hintText: 'Income *',
                  controller: incomeController,
                ),
                const SizedBox(
                  height: 15,
                ),
                CustomBtn(
                  title: 'प्रण ले',
                  height: 45,
                  width: double.infinity,
                  onTap: () {
                    setState(() {});
                  },
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
