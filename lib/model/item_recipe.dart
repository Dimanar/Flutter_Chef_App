import 'package:flutter/material.dart';

class ItemRecipe {
  String direction;
  String facts;
  int id;
  String image;
  String ingred;
  String link;
  String meta;
  String name;
  String pack;
  String summary;
  String type;

  ItemRecipe({
    @required this.direction,
    @required this.facts,
    @required this.id,
    @required this.image,
    @required this.ingred,
    @required this.link,
    @required this.meta,
    @required this.name,
    @required this.pack,
    @required this.summary,
    @required this.type,
  });

  ItemRecipe.fromJson(Map<dynamic, dynamic> json) {
    direction = json['direction'];
    facts = json['facts'];
    id = json['id'];
    image = json['image'];
    ingred = json['ingred'];
    link = json['link'];
    meta = json['meta'];
    name = json['name'];
    pack = json['pack'];
    summary = json['summary'];
    type = json['type'];
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['direction'] = this.direction;
    data['facts'] = this.facts;
    data['id'] = this.id;
    data['image'] = this.image;
    data['ingred'] = this.ingred;
    data['link'] = this.link;
    data['meta'] = this.meta;
    data['name'] = this.name;
    data['pack'] = this.pack;
    data['summary'] = this.summary;
    data['type'] = this.type;
    return data;
  }

  Map<String, dynamic> parseMeta() {
    Map<String, dynamic> result = {
      'prep' : 0, 'cook' : 0,
      'additional' : 0, 'total' : 0,
      'Servings' : 0, 'Yield' : '',
    };
    Iterable<String> splited = meta.split('<->');
    for (var item in splited) {
      var nameValue = item.split(':');
      String name = nameValue[0].trim();
      var values = nameValue[1].replaceAll(RegExp('[^0-9]'), ' ').split(' ').where(
              (item) => item.isNotEmpty).toList();
      var typeValues = nameValue[1].replaceAll(RegExp(r'[0-9]'), '').trim().split(' ').where(
              (item) => item.isNotEmpty).toList();
      // if (name == 'cook') print(values);
      if (typeValues.isEmpty) {
        result.update(name, (value) => value + int.parse(values[0]));
      }
      else {
        for (int i = 0; i < typeValues.length; i++) {
          if (typeValues[i] == 'mins') result.update(name, (value) => value + int.parse(values[i]));
          else if (typeValues[i] == 'hr' || typeValues[i] == 'hrs') result.update(name, (value) => value + (int.parse(values[i]) * 60));
          else {
            try {
              if (i == 0)
                result.update(name, (value) =>
                value + ' ' + values.map((i) => i.toString()).join(' ')
                    + ' ' + typeValues.join(' '));
            }
            catch (e) {
              print(typeValues);
              print(name);
            }
          }
        }
      }
    }
    return result;
  }

  List<String> parseIngredients() {
    return ingred.split('<->');
  }

  List<String> parseDirections() {
    return direction.split('<->');
  }

  @override
  String toString() {
    return 'id=${id}   name=${name}';
  }

}

