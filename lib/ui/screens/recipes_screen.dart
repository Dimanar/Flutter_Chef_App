import 'package:flutter/material.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/resources/data_base_manager.dart';
import 'package:master_chef/ui/components/appbar.dart';
import 'package:master_chef/ui/components/card.dart';
import 'package:master_chef/ui/components/sibebar_menu.dart';

class RecipesByTypeScreen extends StatelessWidget {
  final String type;
  final DataBaseManager dataBaseManager = DataBaseManager();
  List<ItemRecipe> leftrows = [];
  List<ItemRecipe> rightrows = [];

  RecipesByTypeScreen({
    @required this.type
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(title: type),
      body: _buildBody(),
      drawer: SideBar(),
    );
  }

  Widget _buildBody() {
    return FutureBuilder(
        future: dataBaseManager.returnObjectForQueryByType(type).once(),
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          if (!snapshot.hasData) return Center(child: CircularProgressIndicator());
          else {
            print(snapshot.data.value.length);
            for (var i = 0; i < snapshot.data.value.length; i++){
              if (i < (snapshot.data.value.length / 2).toInt())
                leftrows.add(new ItemRecipe.fromJson(snapshot.data.value[i]));
              else
                rightrows.add(new ItemRecipe.fromJson(snapshot.data.value[i]));
            }
            if (leftrows.length % 2 != 0) leftrows.removeLast();
            if (rightrows.length % 2 != 0) rightrows.removeLast();
          }
          return ListView.builder(
            shrinkWrap: true,
            scrollDirection: Axis.vertical,
            itemCount: leftrows.length,
            itemBuilder: (BuildContext context, int index) {
              return  Row(
                children: [
                  RecipeCard(
                    item: leftrows[index],
                    press: () { Navigator.of(context).pushNamed('/description', arguments: leftrows[index]); },
                  ),
                  RecipeCard(
                    item: rightrows[index],
                    press: () { Navigator.of(context).pushNamed('/description', arguments: rightrows[index]); },
                  ),
                ],
              );
            },
          );
        }
    );
  }

}