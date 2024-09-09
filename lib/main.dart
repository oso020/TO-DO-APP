import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:provider/provider.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:to_do_app/Home/home_screen.dart';
import 'package:to_do_app/Home/login/login_screen.dart';
import 'package:to_do_app/Home/register/register_screen.dart';
import 'package:to_do_app/SharedPrefsLocal.dart';
import 'package:to_do_app/firebase_options.dart';
import 'package:to_do_app/providers/getTaskProvider.dart';
import 'package:to_do_app/providers/language_provider.dart';
import 'package:to_do_app/providers/theme_provider.dart';
import 'package:to_do_app/providers/user_auth_provider.dart';
import 'package:to_do_app/theme_and_color/theme_app.dart';

import 'Home/to_do_list/change_detiles_task_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  SharedPrefsLocal.init(); // Initialize your SharedPreferences wrapper

  // Get saved language and theme from SharedPreferences
  final String? savedLanguage = sharedPreferences.getString('appLanguage');
  final bool? theme = sharedPreferences.getBool('theme');

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (context) => LanguageProvider(locale: savedLanguage ?? "en"),
        ),
        ChangeNotifierProvider(
          create: (context) => ThemeProvider(mode: theme),
        ),
        ChangeNotifierProvider(
          create: (context) => GetTaskProvider(),
        ),
        ChangeNotifierProvider(
          create: (context) => AuthUserProvider(),
        ),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    var languageProvider = Provider.of<LanguageProvider>(context);
    var themeProvider = Provider.of<ThemeProvider>(context);

    return MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: ThemeApp.themeLight,
      themeMode: themeProvider.theme,
      darkTheme: ThemeApp.themeDark,
      locale: Locale(languageProvider.locale),
      localizationsDelegates: AppLocalizations.localizationsDelegates,
      supportedLocales: AppLocalizations.supportedLocales,

      // Use StreamBuilder to listen to authentication state changes
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          // Check the authentication state
          if (snapshot.hasData) {
            return Home();
          } else {
            return LoginScreen();
          }
        },
      ),

      routes: {
        Home.routeName: (context) => Home(),
        ChangeDetilesTaskScreen.routeName: (context) =>
            ChangeDetilesTaskScreen(),
        LoginScreen.routeName: (context) => LoginScreen(),
        RegisterScreen.routeName: (context) => RegisterScreen(),
      },
    );
  }
}
