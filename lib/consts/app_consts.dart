import 'package:flutter/material.dart';

class AppConstants {
  static const String nikeShoe =
      "https://static.nike.com/a/images/c_limit,w_592,f_auto/t_product_v1/e93db408-ecf6-4982-b0d0-13a756c9b8c2/pegasus-40-mens-road-running-shoes-zD8H1c.png";
  static List<String> categoriesList = [
    "Phones",
    "Laptops",
    "Electronics",
    "Watches",
    "Clothes",
    "Shoes",
    "Books",
    "Cosmetics",
    "Accessories"
  ];
  static List<DropdownMenuItem<String>> get dropdownValues {
    return categoriesList.map((categorie) {
      return DropdownMenuItem<String>(
        value: categorie,
        child: Text(categorie),
      );
    }).toList();
  }
}
