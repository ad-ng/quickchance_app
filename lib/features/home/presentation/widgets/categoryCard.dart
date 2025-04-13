import 'package:flutter/material.dart';

class CategoryCard extends StatelessWidget {
  final String catName;
  const CategoryCard({super.key, required this.catName});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: EdgeInsets.symmetric(vertical: 4, horizontal: 5),
      margin: EdgeInsets.only(right: 10, bottom: 5),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(15),
      ),
      child: Text(
        catName,
        style: TextStyle(
          color: Colors.grey,
          fontWeight: FontWeight.w400,
          fontSize: 18,
        ),
      ),
    );
  }
}
