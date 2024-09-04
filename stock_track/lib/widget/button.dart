import 'package:flutter/material.dart';

class Button extends StatelessWidget {
   Button({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.value,
    required this.borderColor
  });

  final double height;
  final double width;
  Color? color;
  String? value;
  Color? borderColor;

  @override
  Widget build(BuildContext context) {
    return Container(height: height ,width: width,
    decoration: BoxDecoration(borderRadius: BorderRadius.circular(20),
    border: Border.all(color: borderColor!),
    color: color),
    child: Center(child: Text(value!,style: const TextStyle(color:Colors.white),)),
    );
  }
}