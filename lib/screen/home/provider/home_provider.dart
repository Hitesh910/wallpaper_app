import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/home/model/wallpaper_model.dart';
import 'package:wallpaper_app/utils/API_helper.dart';

class HomeProvider with ChangeNotifier {
  List<HitsModel>? imageList = [];
  List carsoulList = [
    "https://i0.wp.com/picjumbo.com/wp-content/uploads/beautiful-nature-mountain-scenery-with-flowers-free-photo.jpg?w=600&quality=80",
    "https://images.pexels.com/photos/33109/fall-autumn-red-season.jpg?auto=compress&cs=tinysrgb&dpr=1&w=500",
    "https://hd.wallpaperswide.com/thumbs/nature_landscape_4-t2.jpg",
    "https://hd.wallpaperswide.com/thumbs/summer_landscape_nature_7-t2.jpg"
  ];
  String search = "Nature";
  Future<WallpaperModel?>? model;
  int page = 0;
  List<HitsModel> hitsList2 = [];
  int index = 0;
  int? lIndex;

  void getWallpaper1() {
    page++;
    APIHelper helper = APIHelper();
    model = helper.getWallpaper(search, page);

    model!.then(
      (value) {
        if (value != null) {
          notifyListeners();
        }
      },
    );

    // if (model != null) {
    //   imageList = model.hitsList;
    //   notifyListeners();
    // }
  }

  void changeIndex(int value) {
    index = value;
    notifyListeners();
    print(index);
  }

  void listIndex(int index) {
    lIndex = index;
    notifyListeners();
  }
}
