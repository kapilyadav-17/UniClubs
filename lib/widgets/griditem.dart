import 'package:flutter/material.dart';

class GridItem extends StatelessWidget {
  final String interest;
  GridItem({required this.interest});
  @override
  Widget build(BuildContext context) {
    return Container(
      child: Chip(
        label: Text(interest),
        elevation: 4,
        shadowColor: Colors.grey[50],
        padding: EdgeInsets.all(4),
      ),
      margin: EdgeInsets.only(left: 12, right: 12, top: 2, bottom: 2),
    );
  }
}
/*
Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(5),
        border: Border.all(),
        //color: Colors.white,
      ),
      child: (Text(interest)),
      alignment: Alignment.center,
    );
*/