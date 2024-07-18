import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:wallpaper_app/screen/category/view/category_screen.dart';
import 'package:wallpaper_app/screen/dash/view/dash_screen.dart';
import 'package:wallpaper_app/screen/favorite/view/favorite_screen.dart';

import '../model/wallpaper_model.dart';
import '../provider/home_provider.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  HomeProvider? providerR;
  HomeProvider? providerW;
  TextEditingController txtSearch = TextEditingController();
  ScrollController scrollController = ScrollController();

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    context.read<HomeProvider>().getWallpaper1();
    scrollController.addListener(
      () {
        if (scrollController.position.pixels ==
            scrollController.position.maxScrollExtent) {
          print("End Hello");
          context.read<HomeProvider>().getWallpaper1();
        }
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    providerR = context.read<HomeProvider>();
    providerW = context.watch<HomeProvider>();
    return Scaffold(
      appBar: AppBar(
        title: Text("Wallpaper app"),
      ),
      body: Column(
        children: [
          providerW!.index == 0
              ? Expanded(child: DashScreen())
              : providerW!.index == 1
                  ? Expanded(child: CategoryScreen())
                  : Expanded(child: FavoriteScreen())
        ],
      ),
      // Column(
      //   children: [
      //     SearchBar(trailing: <Widget>[IconButton(onPressed: () {
      //       // txtSearch.clear();
      //       providerR!.search = txtSearch.text;
      //       providerW!.getWallpaper1();
      //     }, icon: Icon(Icons.search))],onSubmitted: (value) {
      //       providerR!.search = txtSearch.text;
      //       providerW!.getWallpaper1();
      //     },controller: txtSearch,onTap: () {
      //
      //     },),
      //     CarouselSlider.builder(itemCount: providerW!.carsoulList.length,
      //         itemBuilder: (context, index, realIndex) {
      //         return  Container(margin: EdgeInsets.all(10),decoration: BoxDecoration(image: DecorationImage(
      //               image: NetworkImage("${providerR!.carsoulList[index]}"))),);
      //         },
      //         options: CarouselOptions(autoPlay: true,enlargeCenterPage: true,)),
      //     Expanded(
      //       child: GridView.builder(
      //         itemCount: providerW!.imageList!.length,
      //         gridDelegate:
      //         SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
      //         itemBuilder: (context, index) {
      //           return Image.network(
      //             "${providerR!.imageList![index].previewURL}",);
      //         },
      //       ),
      //     ),
      //   ],
      // ),
      bottomNavigationBar: BottomNavigationBar(
          onTap: (value) {
            providerR!.changeIndex(value);
          },
          currentIndex: providerW!.index,
          items: const [
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.home,
                  color: Colors.white,
                ),
                label: "Home"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.category,
                  color: Colors.white,
                ),
                label: "Category"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.favorite,
                  color: Colors.white,
                ),
                label: "Favorite"),
            BottomNavigationBarItem(
                icon: Icon(
                  Icons.settings,
                  color: Colors.white,
                ),
                label: "Settings")
          ]),
    );
  }
}

// FutureBuilder(
// future: providerW!.model,
// builder: (context, snapshot) {
// if (snapshot.hasError) {
// Text("${snapshot.error}");
// }
// else if (snapshot.hasData) {
// WallpaperModel? model = snapshot.data;
// providerW!.hitsList2.addAll(model!.hitsList!);
// // model.hitsList!.clear();
// // providerW!.hitsList.clear();
// if (model == null) {
// Text("No data found");
// }
// else if (model.hitsList!.isEmpty) {
// Text("Search another Topic...");
// }
// else {
// return Column(
// children: [
// SearchBar(
// elevation: WidgetStatePropertyAll(0),
// trailing: <Widget>[
// IconButton(
// onPressed: () {
// // txtSearch.clear();
// providerR!.search = txtSearch.text;
// providerW!.getWallpaper1();
// },
// icon: Icon(Icons.search))
// ],
// onSubmitted: (value) {
// providerR!.search = txtSearch.text;
// providerW!.getWallpaper1();
// },
// controller: txtSearch,
// onTap: () {},
// ),
// CarouselSlider.builder(
// itemCount: providerW!.carsoulList.length,
// itemBuilder: (context, index, realIndex) {
// return Container(
// margin: EdgeInsets.all(10),
// decoration: BoxDecoration(
// image: DecorationImage(
// image: NetworkImage(
// "${providerR!.carsoulList[index]}"))),
// );
// },
// options: CarouselOptions(
// autoPlay: true,
// enlargeCenterPage: true,
// )),
// // SizedBox(
// //   height: 20,width: 400,
// //   child: Row(
// //     children: [
// //       ListView.builder(itemBuilder: (context, index) {
// //         return Container(height: 20,width: 20,decoration: BoxDecoration(shape: BoxShape.circle,color: Colors.grey),);
// //       },itemCount: 5,),
// //     ],
// //   ),
// // ),
// Expanded(
// child: GridView.builder(
// controller: scrollController,
// itemCount: providerW!.hitsList2.length,
// gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
// crossAxisCount: 3,
// mainAxisExtent: 200,
// mainAxisSpacing: 5,
// crossAxisSpacing: 5),
// itemBuilder: (context, index) {
// return CachedNetworkImage(
// imageUrl: "${providerR!.hitsList2[index].previewURL}",
// fit: BoxFit.fill,
// // errorWidget: ,
// placeholder: (context, url) => Center(
// child: CircularProgressIndicator(),
// ),
// );
// },
// ),
// ),
// ],
// );
// }
// }
// // return Center();
// return Center(child: CircularProgressIndicator());
// },
// ),
