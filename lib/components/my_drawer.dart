import 'package:flutter/material.dart';
import 'package:fitness_tracker/theme/theme_provider.dart';
import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
class MyDrawer extends StatelessWidget {
  const MyDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDarkMode = themeProvider.isDarkMode;
    return Drawer(
      backgroundColor: Theme
          .of(context)
          .colorScheme
          .surface,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              isDarkMode ? 'Change to Light Mode' : 'Change to Dark Mode', // Replace with your desired text
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: isDarkMode ? Colors.white : Colors.black,
              ),
            ),
            SizedBox(height: 8), // Optional spacing between text and switch
            CupertinoSwitch(
              value: Provider
                  .of<ThemeProvider>(context)
                  .isDarkMode,
              onChanged: (value) =>
                  Provider.of<ThemeProvider>(context, listen: false)
                      .toggleTheme(),
            ),
          ],
        ),
      ),
    );
  }
}
