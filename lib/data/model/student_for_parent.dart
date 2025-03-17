import 'dart:convert';

class StdForParent {
  List<Items>? items;

  StdForParent({this.items});

  StdForParent.fromJson(Map<String, dynamic> json) {
    if (json['items'] != null) {
      items = <Items>[];
      json['items'].forEach((v) {
        items!.add(new Items.fromJson(v));
      });
    }
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    if (this.items != null) {
      data['items'] = this.items!.map((v) => v.toJson()).toList();
    }
    return data;
  }
}

class Items {
  String? stdId;
  String? nameEn;
  String? nameAr;
  int? eduLevel;
  int? age;
  int? parentId;
  int? schoolId;
  int? branchId;
  String? schoolNameEn;
  String? schoolNameAr;
  String? branchNameEn;
  String? branchNameAr;

  Items(
      {this.stdId,
      this.nameEn,
      this.nameAr,
      this.eduLevel,
      this.age,
      this.parentId,
      this.schoolId,
      this.branchId,
      this.schoolNameEn,
      this.schoolNameAr,
      this.branchNameEn,
      this.branchNameAr});

  Items.fromJson(Map<String, dynamic> json) {
    stdId = json['std_id'].toString();
    nameEn = json['std_name_en'];
    nameAr = json['std_name_ar'] != null
        ? utf8.decode(json['std_name_ar'].toString().runes.toList())
        : null;
    eduLevel = json['edu_level'];
    age = json['age'];
    parentId = json['parent_id'];
    schoolId = json['school_id'];
    branchId = json['branch_id'];
    schoolNameEn = json['school_name_en'];
    schoolNameAr = json['school_name_ar'] != null
        ? utf8.decode(json['school_name_ar'].toString().runes.toList())
        : null;
    branchNameEn = json['branch_name_en'];
    branchNameAr = json['branch_name_ar'] != null
        ? utf8.decode(json['branch_name_ar'].toString().runes.toList())
        : null;
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['std_id'] = this.stdId;
    data['std_name_en'] = this.nameEn;
    data['std_name_ar'] = this.nameAr;
    data['edu_level'] = this.eduLevel;
    data['age'] = this.age;
    data['parent_id'] = this.parentId;
    data['school_id'] = this.schoolId;
    data['branch_id'] = this.branchId;
    data['school_name_en'] = this.schoolNameEn;
    data['school_name_ar'] = this.schoolNameAr;
    data['branch_name_en'] = this.branchNameEn;
    data['branch_name_ar'] = this.branchNameAr;
    return data;
  }
}
