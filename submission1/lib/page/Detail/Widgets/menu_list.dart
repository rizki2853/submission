import 'package:flutter/material.dart';

class MenuList extends StatelessWidget {
  final String name;
  final String image;
  const MenuList({Key? key, required this.name, required this.image})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Container(
            height: 171,
            width: 171,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(30),
                image: DecorationImage(image: NetworkImage(image))),
          ),
        ),
        Text(name)
      ],
    );
  }
}
