import 'package:bestshop_adminpanel/providers/theme_provider.dart';
import 'package:bestshop_adminpanel/services/images_manager.dart';
import 'package:bestshop_adminpanel/widgets/title_text.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class DashboardButtonWidget extends StatelessWidget {
  const DashboardButtonWidget(
      {super.key,
      required this.label,
      required this.image,
      required this.func});

  final String label, image;
  final Function func;
  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    return GestureDetector(
      onTap: () {
        func();
      },
      child: Padding(
        padding: const EdgeInsets.all(8.0),
        child: Container(
          padding: const EdgeInsets.all(8),
          decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(25),
              color: themeProvider.getIsDarkTheme
                  ? Colors.blueGrey.shade800
                  : Colors.blueGrey.shade100),
          child: Column(mainAxisAlignment: MainAxisAlignment.center, children: [
            Expanded(child: Image.asset(image)),
            const SizedBox(
              height: 10,
            ),
            FittedBox(
              child: TitleTextWidget(
                label: label,
                maxLines: 2,
              ),
            )
          ]),
        ),
      ),
    );
  }
}
