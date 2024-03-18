import 'package:bestshop_adminpanel/pages/edit_upload_product_page.dart';
import 'package:bestshop_adminpanel/pages/inner_pages/orders/order_page.dart';
import 'package:bestshop_adminpanel/pages/search_page.dart';
import 'package:bestshop_adminpanel/services/images_manager.dart';
import 'package:flutter/material.dart';

class DashboardButtonModel {
  final String label, image;
  final Function func;

  DashboardButtonModel(
      {required this.label, required this.image, required this.func});

  static List<DashboardButtonModel> dashboardBtnList(context) {
    return [
      DashboardButtonModel(
          label: "Add a new product",
          image: ImagesManager.cloud,
          func: () {
            Navigator.pushNamed(context, EditOrUploadProductPage.rootName);
          }),
      DashboardButtonModel(
          label: "Inspect all products",
          image: ImagesManager.shoppingCard,
          func: () {
            Navigator.pushNamed(context, SearchPage.rootName);
          }),
      DashboardButtonModel(
          label: "View orders",
          image: ImagesManager.order,
          func: () {
            Navigator.pushNamed(context, OrderPage.rootName);
          })
    ];
  }
}
