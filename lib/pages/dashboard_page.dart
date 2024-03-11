import 'package:bestshop_adminpanel/models/dashboard_btn_model.dart';
import 'package:bestshop_adminpanel/providers/theme_provider.dart';
import 'package:bestshop_adminpanel/services/images_manager.dart';
import 'package:bestshop_adminpanel/widgets/app_name_text_widget.dart';
import 'package:bestshop_adminpanel/widgets/dashboard_button_widget.dart';
import 'package:bestshop_adminpanel/widgets/subtitle_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardPage extends StatelessWidget {
  const DashboardPage({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return Scaffold(
      appBar: AppBar(
          leading: Padding(
              padding: const EdgeInsets.only(left: 6),
              child: Image.asset(ImagesManager.shoppingCard)),
          title: const AppNameTextWidget(title: "Best Shop"),
          actions: [
            IconButton(
                onPressed: () {
                  themeProvider.setDarkTheme(!themeProvider.getIsDarkTheme);
                },
                icon: themeProvider.getIsDarkTheme
                    ? const Icon(Icons.nightlight_round_outlined)
                    : Icon(
                        Icons.light_mode,
                        color: Colors.yellow.shade900,
                      ))
          ]),
      body: GridView.count(
        crossAxisCount: 2,
        children: List.generate(
            3,
            (index) => DashboardButtonWidget(
                label:
                    DashboardButtonModel.dashboardBtnList(context)[index].label,
                image:
                    DashboardButtonModel.dashboardBtnList(context)[index].image,
                func: DashboardButtonModel.dashboardBtnList(context)[index]
                    .func)),
      ),
    );
  }
}
