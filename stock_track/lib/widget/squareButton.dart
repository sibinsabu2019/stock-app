import 'package:flutter/material.dart';

class squareButton extends StatelessWidget {
   squareButton({
    super.key,
    required this.height,
    required this.width,
    required this.color,
    required this.icon,
    required this.title,
    required this.subtitle
  });

  final double height;
  final double width;
  Color? color;
  IconData? icon;
  String? title;
  String? subtitle;

  @override
  Widget build(BuildContext context) {
    return Container(height: height*0.079,
       width: width*0.94,
       decoration: BoxDecoration(borderRadius: BorderRadius.circular(5),color: Colors.white),
       
       child: Row(children: [
        Container(margin:const EdgeInsets.all(10),
          height: 50,
        width: 50,
          decoration: BoxDecoration(shape:BoxShape.circle,color:color),
          child: Icon(icon,color: Colors.white,)),
          Column(crossAxisAlignment: CrossAxisAlignment.start,
            children: [
            Padding(
              padding: const EdgeInsets.only(top: 12,bottom: 1),
              child: Text(title!,style: const TextStyle(fontSize: 20,fontWeight: FontWeight.w300),),
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 1),
              child: Text(subtitle!),
            ),
            
           
          ],),
          const Spacer(),
           const Icon(Icons.keyboard_arrow_right_rounded,size: 35,)
       ],),);
  }
}

