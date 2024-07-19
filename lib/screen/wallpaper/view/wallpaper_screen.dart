import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screen/home/provider/home_provider.dart';

class WallpaperScreen extends StatefulWidget {
  const WallpaperScreen({super.key});

  @override
  State<WallpaperScreen> createState() => _WallpaperScreenState();
}

class _WallpaperScreenState extends State<WallpaperScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(),
      body: Column(
        children: [
          Expanded(
            child: CarouselSlider.builder(
                itemCount: providerW!.hitsList2.length,
                itemBuilder: (context, index, realIndex) {
                  print(providerR!.hitsList2[index].largeviewURL);
                  return Container(
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${providerR!.hitsList2[index].largeviewURL}"))),
                  );
                },
                options: CarouselOptions(enlargeCenterPage: true, height: 800)),
          )
        ],
      ),
    );
  }
}
