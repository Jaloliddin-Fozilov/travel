import 'package:flutter/material.dart';
import 'package:travel/models/category_model.dart';

class CategoryProvider with ChangeNotifier {
  List<CategoryModel> _list = [
    CategoryModel(
      id: '0',
      color: Colors.blueGrey,
      title: 'Hiking tips',
      icon: Icons.hiking,
    ),
    CategoryModel(
      id: '1',
      color: Colors.deepPurple,
      title: 'City tours',
      icon: Icons.directions_bus,
    ),
    CategoryModel(
      id: '0',
      color: Colors.blueAccent,
      title: 'Hiking tips',
      icon: Icons.hiking,
    ),
    CategoryModel(
      id: '1',
      color: Colors.blueGrey,
      title: 'City tours',
      icon: Icons.directions_bus,
    ),
    CategoryModel(
      id: '0',
      color: Colors.yellowAccent,
      title: 'Hiking tips',
      icon: Icons.hiking,
    ),
    CategoryModel(
      id: '1',
      color: Colors.deepPurple,
      title: 'City tours',
      icon: Icons.directions_bus,
    ),
  ];

  List<CategoryModel> get list {
    return [..._list];
  }
}
