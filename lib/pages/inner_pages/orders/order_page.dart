import 'package:bestshop_adminpanel/pages/inner_pages/orders/order_widget.dart';
import 'package:flutter/material.dart';

import '../../../services/images_manager.dart';
import '../../../widgets/empty_card_widget.dart';
import '../../../widgets/subtitle_text.dart';

class OrderPage extends StatelessWidget {
  static const String rootName = "/orders";
  const OrderPage({super.key});

  final bool isEmpty = false;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
          toolbarHeight: 40,
          leading: IconButton(
            onPressed: () {
              if (Navigator.canPop(context)) {
                Navigator.pop(context);
              }
            },
            icon: const Icon(Icons.arrow_back_ios_new_outlined),
          ),
          title: const SubtitleTextWidget(label: "All orders")),
      body: isEmpty
          ? EmptyCardWidget(
              image: ImagesManager.shoppingCard,
              title: "WHOPPSS",
              subtitle1: "Your have no orders!",
              subtitle2: "You might want to look for new products",
              buttonText: "Search Products",
              func: () {})
          : ListView.separated(
              physics: const BouncingScrollPhysics(),
              itemBuilder: (context, index) {
                return const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 6, vertical: 2),
                  child: OrderWidget(),
                );
              },
              separatorBuilder: (context, index) {
                return const Divider();
              },
              itemCount: 15),
    );
  }
}
