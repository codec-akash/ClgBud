import 'package:clgbud/pages/home_page/home_page.dart';
import 'package:clgbud/pages/login_page/login_page.dart';
import 'package:clgbud/services/auth.dart';
import 'package:clgbud/services/user_database.dart';
import 'package:clgbud/utils/theme.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeNotifier()),
        ChangeNotifierProvider(create: (_) => AuthService()),
        ChangeNotifierProvider(create: (_) => UserDataBase()),
      ],
      child: Consumer<ThemeNotifier>(
        builder: (context, theme, child) => MaterialApp(
          title: 'ClgBud',
          theme: theme.darkTheme ? dark : light,
          home: StreamBuilder<User>(
              stream: AuthService().user,
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return Text("Loadi");
                } else if (snapshot.hasData) {
                  return HomePage();
                }
                if (snapshot.hasError) {
                  print(snapshot.error);
                }
                return LoginPage();
              }),
        ),
      ),
    );
  }
}
