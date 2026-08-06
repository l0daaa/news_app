import 'package:flutter/material.dart';
class CategoryItem extends StatelessWidget {
  const CategoryItem({super.key, required this.title, required this.selected});
final String title;
final bool selected;
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.only(right: 10),
      child: Container(
        padding: EdgeInsets.symmetric(horizontal: 22,vertical: 10),
        decoration: BoxDecoration(
          color: selected ? Colors.orange : Colors.white,
              borderRadius: BorderRadius.circular(30),
            border: Border.all(color: Colors.grey.shade400)

        ),
        child: Text(title,style: TextStyle(color: Colors.black,fontSize: 16)),

      ),
    );
  }
}
