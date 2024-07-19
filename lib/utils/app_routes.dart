import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/category/view/category_screen.dart';
import 'package:wallpaper_app/screen/dash/view/dash_screen.dart';
import 'package:wallpaper_app/screen/home/view/home_screen.dart';
import 'package:wallpaper_app/screen/wallpaper/view/wallpaper_screen.dart';

Map<String,WidgetBuilder> app_routes = {
  "/":(context) => HomeScreen(),
  "category":(context) => CategoryScreen(),
  "dash":(context) => DashScreen(),
  "wallpaper":(context) => WallpaperScreen(),
};