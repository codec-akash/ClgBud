import 'package:clgbud/pages/login_page/login_page.dart';
import 'package:clgbud/utils/theme.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider.value(value: ThemeNotifier()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'ClgBud',
          theme: theme.darkTheme ? dark : light,
          home: LoginPage(),
        ),
      ),
    );
  }
}
