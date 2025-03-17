import 'dart:convert';

class StdRoundParent {
  List<Items>? items;
  bool? hasMore;
  int? limit;
  int? offset;
  int? count;
  List<Links>? links;

  StdRoundParent(
      {this.items,
      this.hasMore,
      this.limit,
      this.offset,
      this.count,
      this.links});

  StdRoundParent.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
    hasMore = json['hasMore'];
    limit = json['limit'];
    offset = json['offset'];
    count = json['count'];
    if (json['links'] != null) {
      links = <Links>[];
      json['links'].forEach((v) {
        links!.add(new Links.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    data['hasMore'] = this.hasMore;
    data['limit'] = this.limit;
    data['offset'] = this.offset;
    data['count'] = this.count;
    if (this.links != null) {
      data['links'] = this.links!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? stdId;
  int? driverId;
  String? roundId;
  int? schoolId;
  int? isActive;
  String? roundNameEn;
  String? roundNameAr;
  String? startDate;

  Items(
      {this.stdId,
      this.driverId,
      this.roundId,
      this.schoolId,
      this.isActive,
      this.roundNameEn,
      this.roundNameAr,
      this.startDate});

  Items.fromJson(Map<String, dynamic> json) {
    stdId = json['std_id'].toString();
    driverId = json['driver_id'];
    roundId = json['round_id'].toString();
    schoolId = json['school_id'];
    isActive = json['is_active'];
    roundNameEn = json['round_name_en'];
    roundNameAr = json['round_name_ar'] != null
        ? utf8.decode(json['round_name_ar'].toString().runes.toList())
        : null;
    startDate = json['start_date'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_id'] = this.stdId;
    data['driver_id'] = this.driverId;
    data['round_id'] = this.roundId.toString();
    data['school_id'] = this.schoolId;
    data['is_active'] = this.isActive;
    data['round_name_en'] = this.roundNameEn;
    data['round_name_ar'] = this.roundNameAr;
    data['start_date'] = this.startDate;
    return data;
  }
}

class Links {
  String? rel;
  String? href;

  Links({this.rel, this.href});

  Links.fromJson(Map<String, dynamic> json) {
    rel = json['rel'];
    href = json['href'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['rel'] = this.rel;
    data['href'] = this.href;
    return data;
  }
}
