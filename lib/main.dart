import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screen/home/provider/home_provider.dart';
import 'package:wallpaper_app/utils/app_routes.dart';
import 'package:wallpaper_app/utils/app_theme.dart';

void main() {
  runApp(MultiProvider(
    providers: [ChangeNotifierProvider.value(value: HomeProvider())],
    child: MaterialApp(
      debugShowCheckedModeBanner: false,
      theme: darkTheme,
      themeMode: ThemeMode.dark,
      routes: app_routes,
    ),
  )
      // MaterialApp(
      //   routes: app_routes,
      // )
      );
}
