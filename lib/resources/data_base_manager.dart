import 'package:firebase_database/firebase_database.dart';

class DataBaseManager {
  final dbRefMeal = FirebaseDatabase.instance.reference().child("/by_meal");
  final dbRefAudience = FirebaseDatabase.instance.reference().child("/by_audience");
  final dbRefCuisine = FirebaseDatabase.instance.reference().child("/by_cuisine");
  final dbRefHolidays = FirebaseDatabase.instance.reference().child("/by_holidays");
  final dbRefCooking = FirebaseDatabase.instance.reference().child("/by_cooking_method");
  final dbRefIngred = FirebaseDatabase.instance.reference().child("/by_ingred");
  final dbRefDiets = FirebaseDatabase.instance.reference().child("/by_diets");

  Future query(db) async{
    return await db.orderByKey().limitToFirst(6).once();
  }

  Future getDataForPreviewByMeal() async{
    return await query(dbRefMeal);
  }

  Future getDataForPreviewByAudience() async{
    return await query(dbRefAudience);
  }

  Future getDataForPreviewByCuisine() async{
    return await query(dbRefCuisine);
  }

  Future getDataForPreviewByHolidays() async{
    return await query(dbRefHolidays);
  }

  Future getDataForPreviewByCooking() async{
    return await query(dbRefCooking);
  }

  Future getDataForPreviewByIngred() async{
    return await query(dbRefIngred);
  }

  Future getDataForPreviewByDiets() async{
    return await query(dbRefDiets);
  }

  DatabaseReference returnObjectForQueryByType(type) {
    if (type == 'By Meal') return dbRefMeal;
    else if (type == 'By Audience') return dbRefAudience;
    else if (type == 'By Cooking Method') return dbRefCooking;
    else if (type == 'By Cuisine') return dbRefCuisine;
    else if (type == 'By Holidays and Events') return dbRefHolidays;
    else if (type == 'By Main Ingredient') return dbRefIngred;
    else if (type == 'By Special Diets') return dbRefDiets;
  }


}


