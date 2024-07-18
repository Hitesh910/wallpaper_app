import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:wallpaper_app/screen/home/model/wallpaper_model.dart';

class APIHelper
{
  Future<WallpaperModel?> getWallpaper(String search,int page)
  async {
    String link = "https://pixabay.com/api/?key=44960287-e62d72a6694fa36f60d0d271e&q=${search}&orientation=vertical&page=${page}";

    var responces = await http.get(Uri.parse(link));

    if(responces.statusCode == 200)
      {
        var json = jsonDecode(responces.body);
        WallpaperModel model = WallpaperModel.mapToModel(json);

        return  model;
      }
    return null;
  }
}