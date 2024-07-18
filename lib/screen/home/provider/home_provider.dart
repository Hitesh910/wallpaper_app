import 'package:flutter/material.dart';
import 'package:wallpaper_app/screen/home/model/wallpaper_model.dart';
import 'package:wallpaper_app/utils/API_helper.dart';

class HomeProvider with ChangeNotifier {
  List<HitsModel>? imageList = [];
  List carsoulList = [
    "https://img.freepik.com/premium-photo/landscape-painting-mountain-sky-clouds-magical-mystic-lake-river-ai-generated-creative-posters-ad-campaigns-flyers-templates_467123-24268.jpg?size=626&ext=jpg&ga=GA1.1.2008272138.1721088000&semt=ais_user",
    "https://img.freepik.com/free-photo/brown-mountain-mirrored-body-water_395237-244.jpg?w=1060&t=st=1721211641~exp=1721212241~hmac=5e1801ef2a6286db995e8a141147ea774fc8ab5232bb744b2299f25a194e4609",
    "https://img.freepik.com/free-photo/nature-landscape-with-black-sand-beach_23-2151380343.jpg?t=st=1721210626~exp=1721214226~hmac=5878515bf5219dbe8816ecfc78c429a80dff84611dad59baac3bb5cfaf62c871&w=1060",
    "https://img.freepik.com/free-photo/nature-landscape-with-black-sand-beach_23-2151380296.jpg?t=st=1721211751~exp=1721215351~hmac=14bb1dca27b8f2aaa11be4769da3efb5d91079272772ae1c5bdeca600c3dc1ae&w=1060"
  ];
  String search = "Nature";
  Future<WallpaperModel?>? model;
  int page = 0;
  List<HitsModel> hitsList2 = [];

  void getWallpaper1()  {
    page++;
    APIHelper helper = APIHelper();
  model = helper.getWallpaper(search,page);

    model!.then((value) {
      if(value!=null)
        {
          notifyListeners();
        }
    },);

    // if (model != null) {
    //   imageList = model.hitsList;
    //   notifyListeners();
    // }
  }
}
