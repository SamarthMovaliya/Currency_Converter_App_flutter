import 'package:currency_converter_app_api/Controller/Providers/FromProvider.dart';
import 'package:currency_converter_app_api/Modals/Glpbals/Modals/ThemeModal.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'Controller/Providers/ThemeProvider.dart';
import 'Views/Screens/CurrentRateScreen.dart';
import 'Views/Screens/HomeScreen.dart';
import 'Views/Screens/SplashScreen.dart';

void main() {
  runApp(CurrencyApp());
}

class CurrencyApp extends StatefulWidget {
  const CurrencyApp({Key? key}) : super(key: key);

  @override
  State<CurrencyApp> createState() => _CurrencyAppState();
}

class _CurrencyAppState extends State<CurrencyApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => FromProvider()),
        ChangeNotifierProvider(create: (context) => ThemeProvider()),
      ],
      builder: (context, _) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          darkTheme: ThemeData.dark(
            useMaterial3: true,
          ),
          theme: ThemeData.light(
            useMaterial3: true,
          ),
          themeMode:
              (Provider.of<ThemeProvider>(context).themeModal.isDark == false)
                  ? ThemeMode.light
                  : ThemeMode.dark,
          initialRoute: 'SplashScreen',
          routes: {
            'HomeScreen': (context) => HomeScreen(),
            'SplashScreen': (context) => SplashScreen(),
            'CurrentRateScreen': (context) => CurrentRateScreen(),
          },
        );
      },
    );
  }
}
