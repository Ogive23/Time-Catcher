import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:time_catcher/Screens/TopThree/BackgroundScreen.dart';
import 'package:time_catcher/Session/session_manager.dart';
import 'package:time_catcher/Shared%20Data/app_language.dart';
import 'package:time_catcher/Shared%20Data/app_theme.dart';
import 'package:time_catcher/Shared%20Data/common_data.dart';

class MainScreen extends StatelessWidget {
  final SessionManager sessionManager = new SessionManager();
  static late AppTheme appTheme;
  static late AppLanguage appLanguage;
  final CommonData commonData = new CommonData();
  @override
  Widget build(BuildContext context) {
    appTheme = new AppTheme(sessionManager.loadPreferredTheme(), context);
    appLanguage = new AppLanguage(sessionManager.loadPreferredLanguage()!);
    return MultiProvider(providers: [
      ChangeNotifierProvider<AppTheme>(
        create: (context) => appTheme,
      ),
      ChangeNotifierProvider<AppLanguage>(
        create: (context) => appLanguage,
      ),
      ChangeNotifierProvider<CommonData>(
        create: (context) => commonData,
      ),
    ], child: BackgroundScreen());
  }
}
