import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travel/providers/categories_provider.dart';

class HomeCategories extends StatelessWidget {
  const HomeCategories({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final categories = Provider.of<CategoryProvider>(context).list;
    return Row(
      children: categories
          .map((category) => GestureDetector(
                onTap: () => Navigator.of(context).pushNamed('/details'),
                child: Container(
                  height: 80,
                  padding: const EdgeInsets.all(10),
                  margin: const EdgeInsets.only(right: 10),
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      colors: [
                        category.color.withAlpha(80),
                        category.color,
                      ],
                    ),
                    borderRadius: BorderRadius.circular(15),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Icon(
                        category.icon,
                        color: Colors.white,
                      ),
                      const SizedBox(height: 10),
                      Text(
                        category.title,
                        style: const TextStyle(
                            color: Colors.white, fontWeight: FontWeight.w600),
                      ),
                    ],
                  ),
                ),
              ))
          .toList(),
    );
  }
}
