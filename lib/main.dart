import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:todo_2/layout/Home_layout.dart';
import 'package:todo_2/moduels/edit_task/edit_task.dart';
import 'package:todo_2/provider/my_provider.dart';
import 'shared/styles/my_theme.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  runApp(ChangeNotifierProvider(
      create: (context) => MyProvider(), child: MyApp()));
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    var provider = Provider.of<MyProvider>(context);
    return MaterialApp(
      localizationsDelegates: const [
        AppLocalizations.delegate, // Add this line
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate,
        GlobalCupertinoLocalizations.delegate,
      ],
      supportedLocales:  [
        const Locale('en'), // English
        const Locale('ar'),

      ],



      locale: Locale(provider.languageCode),
      initialRoute: Home_layout.routeName,
      routes: {
        Home_layout.routeName: (context) => Home_layout(),
        EditTask.routeName: (context) => EditTask()
      },
      debugShowCheckedModeBanner: false,
      theme: MyThemeData.ligthTheme,
      darkTheme: MyThemeData.darkTheme,
      themeMode: ThemeMode.light,
    );
  }
}
