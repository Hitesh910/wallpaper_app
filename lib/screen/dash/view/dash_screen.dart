import 'package:cached_network_image/cached_network_image.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../home/model/wallpaper_model.dart';
import '../../home/provider/home_provider.dart';

class DashScreen extends StatefulWidget {
  const DashScreen({super.key});

  @override
  State<DashScreen> createState() => _DashScreenState();
}

class _DashScreenState extends State<DashScreen> {
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
      // appBar: AppBar(
      //   title: Text("Wallpaper app"),
      // ),
      body: CustomScrollView(
        scrollDirection: Axis.vertical,
        controller: scrollController,

        slivers: [
          SliverToBoxAdapter(
            child: Container(
              height: 50,
              width: MediaQuery.sizeOf(context).width,
              padding: const EdgeInsets.only(right: 10, left: 10),
              child: SearchBar(
                elevation: const WidgetStatePropertyAll(0),
                trailing: <Widget>[
                  IconButton(
                      onPressed: () {
                        // txtSearch.clear();
                        providerW!.hitsList2.clear();
                        providerR!.search = txtSearch.text;
                        providerW!.getWallpaper1();
                        providerW!.page = 1;
                      },
                      icon: const Icon(Icons.search))
                ],
                onSubmitted: (value) {
                  providerR!.search = txtSearch.text;
                  providerW!.getWallpaper1();
                },
                controller: txtSearch,
                onTap: () {},
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: CarouselSlider.builder(
                itemCount: providerW!.carsoulList.length,
                itemBuilder: (context, index, realIndex) {
                  return Container(
                    margin: const EdgeInsets.all(10),
                    decoration: BoxDecoration(
                        image: DecorationImage(
                            image: NetworkImage(
                                "${providerR!.carsoulList[index]}"))),
                  );
                },
                options: CarouselOptions(
                  autoPlay: true,
                  enlargeCenterPage: true,
                  onPageChanged: (index, reason) {},
                )),
          ),
          FutureBuilder(
            future: providerW!.model,
            builder: (context, snapshot) {
              if (snapshot.hasError) {
                Text("${snapshot.error}");
              } else if (snapshot.hasData) {
                WallpaperModel? model = snapshot.data;
                if(model!=null)
                  {
                    providerR!.hitsList2.addAll(model.hitsList!);
                    model.hitsList!.clear();
                  }
                // providerW!.hitsList.clear();
                if (model == null) {
                  return const SliverToBoxAdapter(child: Text("No data found"));
                } else if (providerW!.hitsList2.isEmpty) {
                  return const SliverToBoxAdapter(
                      child: Text("Search another Topic..."));
                } else {
                  return SliverGrid.builder(
                    itemCount: providerW!.hitsList2.length,
                    gridDelegate:
                        const SliverGridDelegateWithFixedCrossAxisCount(
                            crossAxisCount: 3,
                            mainAxisExtent: 200,
                            mainAxisSpacing: 5,
                            crossAxisSpacing: 5),
                    itemBuilder: (context, index) {
                      return InkWell(onTap: () {
                        Navigator.pushNamed(context, 'wallpaper');
                      },
                        child: CachedNetworkImage(
                          imageUrl: "${providerR!.hitsList2[index].previewURL}",
                          fit: BoxFit.fill,
                          // errorWidget: ,
                          placeholder: (context, url) => const Center(
                            child: CircularProgressIndicator(),
                          ),
                        ),
                      );
                    },
                  );
                }
              }
              // return Center();
              return const SliverToBoxAdapter(child: Center(child: CircularProgressIndicator()));
            },
          ),
        ],
        // child: FutureBuilder(
        //   future: providerW!.model,
        //   builder: (context, snapshot) {
        //     if (snapshot.hasError) {
        //       Text("${snapshot.error}");
        //     } else if (snapshot.hasData) {
        //       WallpaperModel? model = snapshot.data;
        //       providerW!.hitsList2.addAll(model!.hitsList!);
        //        //model.hitsList!.clear();
        //       // providerW!.hitsList.clear();
        //       if (model == null) {
        //         Text("No data found");
        //       } else if (model.hitsList!.isEmpty) {
        //         Text("Search another Topic...");
        //       } else {
        //         return Column(
        //           children: [
        //             Container(
        //               height: 50,
        //               width: MediaQuery.sizeOf(context).width,
        //               padding: EdgeInsets.only(right: 10,left: 10),
        //               child: SearchBar(
        //                 elevation: WidgetStatePropertyAll(0),
        //                 trailing: <Widget>[
        //                   IconButton(
        //                       onPressed: () {
        //                         // txtSearch.clear();
        //                         providerW!.hitsList2.clear();
        //                         providerR!.search = txtSearch.text;
        //                         providerW!.getWallpaper1();
        //                         providerW!.page=1;
        //                       },
        //                       icon: Icon(Icons.search))
        //                 ],
        //                 onSubmitted: (value) {
        //                   providerR!.search = txtSearch.text;
        //                   providerW!.getWallpaper1();
        //                 },
        //                 controller: txtSearch,
        //                 onTap: () {},
        //               ),
        //             ),
        //             CarouselSlider.builder(
        //
        //                 itemCount: providerW!.carsoulList.length,
        //                 itemBuilder: (context, index, realIndex) {
        //                   providerW!.listIndex(index);
        //                   return Container(
        //                     margin: EdgeInsets.all(10),
        //                     decoration: BoxDecoration(
        //                         image: DecorationImage(
        //                             image: NetworkImage(
        //                                 "${providerR!.carsoulList[index]}"))),
        //                   );
        //                 },
        //                 options: CarouselOptions(
        //                   autoPlay: true,
        //                   enlargeCenterPage: true,
        //
        //                 )),
        //             // Row(
        //             //   children: List.generate(
        //             //     5,
        //             //     (index) => Container(
        //             //       height: 20,
        //             //       width: 20,
        //             //       decoration: BoxDecoration(color: providerW!.index==0  ?Colors.grey :Colors.white,
        //             //           shape: BoxShape.circle, ),
        //             //     ),
        //             //   )
        //             //   // ListView.builder(
        //             //   //   itemBuilder: (context, index) {
        //             //   //     return Container(
        //             //   //       height: 20,
        //             //   //       width: 20,
        //             //   //       decoration: BoxDecoration(
        //             //   //           shape: BoxShape.circle, color: Colors.grey),
        //             //   //     );
        //             //   //   },
        //             //   //   itemCount: 5,
        //             //   // ),
        //             //
        //             //   ,
        //             // ),
        //             Expanded(
        //               child: GridView.builder(
        //                 controller: scrollController,
        //                 itemCount: providerW!.hitsList2.length,
        //                 gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
        //                     crossAxisCount: 3,
        //                     mainAxisExtent: 200,
        //                     mainAxisSpacing: 5,
        //                     crossAxisSpacing: 5),
        //                 itemBuilder: (context, index) {
        //                   return CachedNetworkImage(
        //                     imageUrl: "${providerR!.hitsList2[index].previewURL}",
        //                     fit: BoxFit.fill,
        //                     // errorWidget: ,
        //                     placeholder: (context, url) => Center(
        //                       child: CircularProgressIndicator(),
        //                     ),
        //                   );
        //                 },
        //               ),
        //             ),
        //           ],
        //         );
        //       }
        //     }
        //     // return Center();
        //     return Center(child: CircularProgressIndicator());
        //   },
        // ),
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
      // bottomNavigationBar: BottomNavigationBar(items: [
      //   BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.home,
      //         color: Colors.black,
      //       ),
      //       label: "Home"),
      //   BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.category,
      //         color: Colors.black,
      //       ),
      //       label: "Category"),
      //   BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.favorite,
      //         color: Colors.black,
      //       ),
      //       label: "Favorite"),
      //   BottomNavigationBarItem(
      //       icon: Icon(
      //         Icons.settings,
      //         color: Colors.black,
      //       ),
      //       label: "Settings")
      // ]),
    );
  }
}
