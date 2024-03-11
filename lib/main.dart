import 'package:bestshop_adminpanel/consts/theme_data.dart';
import 'package:bestshop_adminpanel/pages/addnew_product_page.dart';
import 'package:bestshop_adminpanel/pages/dashboard_page.dart';
import 'package:bestshop_adminpanel/pages/inner_pages/orders/order_page.dart';
import 'package:bestshop_adminpanel/pages/search_page.dart';
import 'package:bestshop_adminpanel/providers/product_provider.dart';
import 'package:bestshop_adminpanel/providers/theme_provider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) {
          return ProductProvider();
        }),
        ChangeNotifierProvider(create: (_) {
          return ThemeProvider();
        })
      ],
      child: Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          title: "Admin Panel",
          theme: Themes.themeData(
              isDarkTheme: themeProvider.getIsDarkTheme, context: context),
          home: const DashboardPage(),
          routes: {
            OrderPage.rootName: (context) {
              return const OrderPage();
            },
            SearchPage.rootName: (context) {
              return const SearchPage();
            },
            AddNewProductPage.rootName: (context) {
              return const AddNewProductPage();
            }
          },
        );
      }),
    );
  }
}
