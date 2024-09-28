import 'package:flutter/material.dart';

class WeekOfferInfo {
  int? id;
  String? name;
  String? desc;
  String? qty;
  int? kcal;
  String? image;
  double? price;
  Color? colorBegin;
  Color? colorEnd;

  WeekOfferInfo({
    this.id,
    this.name,
    this.desc,
    this.qty,
    this.kcal,
    this.image,
    this.price,
    this.colorBegin,
    this.colorEnd,
  });

  WeekOfferInfo.fromJson(Map<String, dynamic> json) {
    id = json['id'];
    name = json['name'];
    desc = json['desc'];
    qty = json['qty'];
    kcal = json['kcal'];
    image = json['image'];
    price = json['price'];
    colorBegin = json['colorBegin'];
    colorEnd = json['colorEnd'];
  }

  Map<String?, dynamic> toJson() {
    Map<String?, dynamic> data = <String?, dynamic>{};
    data['id'] = id;
    data['name'] = name;
    data['desc'] = desc;
    data['qty'] = qty;
    data['kcal'] = kcal;
    data['image'] = image;
    data['price'] = price;
    data['colorBegin'] = colorBegin;
    data['colorEnd'] = colorEnd;
    return data;
  }
}