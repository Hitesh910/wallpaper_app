class WallpaperModel
{
  int? total,totalHits;
  List<HitsModel>? hitsList = [];

  WallpaperModel({this.total, this.totalHits, this.hitsList});

  factory WallpaperModel.mapToModel(Map m1)
  {
    List l1 = m1['hits'];
    return WallpaperModel(total: m1['total'],totalHits: m1['totalHits'],hitsList: l1.map((e) => HitsModel.mapToModel(e),).toList());
  }
}

class HitsModel
{
  String? previewURL,largeviewURL;

  HitsModel({this.previewURL, this.largeviewURL});

  factory HitsModel.mapToModel(Map m1)
  {
    return HitsModel(previewURL: m1['previewURL'],largeviewURL: m1['largeviewURL']);
  }
}