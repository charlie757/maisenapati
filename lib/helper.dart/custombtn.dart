import 'package:flutter/material.dart';

class CustomBtn extends StatefulWidget {
  final String title;
  final double height;
  final double width;
  final bool isLoading;
  final Function() onTap;
  const CustomBtn(
      {key,
      required this.title,
      required this.height,
      required this.width,
      required this.onTap,
      this.isLoading = false});

  @override
  State<CustomBtn> createState() => _CustomBtnState();
}

class _CustomBtnState extends State<CustomBtn> {
  @override
  Widget build(BuildContext context) {
    return MouseRegion(
      cursor: SystemMouseCursors.text,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
            elevation: 10,
            backgroundColor: const Color(0xff2596be),
            shape: RoundedRectangleBorder(
                side: const BorderSide(color: Color(0xff1782b7)),
                borderRadius: BorderRadius.circular(5))),
        onPressed: widget.onTap,
        child: Container(
          alignment: Alignment.center,
          height: widget.height,
          width: widget.width,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              widget.isLoading
                  ? Image.asset(
                      'assets/icons/pran.jpeg',
                      color: Colors.black,
                    )
                  : Container(),
              Text(
                widget.title,
                style: const TextStyle(
                    fontSize: 20,
                    // fontFamily: LatoRegular,
                    color: Colors.white,
                    fontWeight: FontWeight.w800),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
