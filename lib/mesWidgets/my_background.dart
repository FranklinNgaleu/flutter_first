import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_first/controller/myCustomPath.dart';

class MyBackGround extends StatefulWidget {
  const MyBackGround({super.key});

  @override
  State<MyBackGround> createState() => _MyBackGroundState();
}

class _MyBackGroundState extends State<MyBackGround> {
  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: MyCustomPath(),
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.pink,
      ),
    );
  }
}