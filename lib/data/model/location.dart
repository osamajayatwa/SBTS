class trackBus {
  List<Items>? items;

  trackBus({this.items});

  factory trackBus.fromJson(Map<String, dynamic> json) {
    return trackBus(
      items: (json['items'] as List<dynamic>?)
          ?.map((item) => Items.fromJson(item as Map<String, dynamic>))
          .toList(),
    );
  }
}

class Items {
  double? lat;
  double? lng;

  Items({this.lat, this.lng});

  factory Items.fromJson(Map<String, dynamic> json) {
    return Items(
      lat: (json['lat'] as num?)?.toDouble(),
      lng: (json['lng'] as num?)?.toDouble(),
    );
  }
}
