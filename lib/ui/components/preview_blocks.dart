import 'package:flutter/material.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/ui/components/card.dart';


class RecipesBlock extends StatelessWidget {
  final List<ItemRecipe> recipes;
  List<RecipeCard> recipeCard = [];

  RecipesBlock({
    Key key,
    @required this.recipes,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    recipes.forEach((element) {
      recipeCard.add(new RecipeCard(
        item: element,
        press:() { Navigator.of(context).pushNamed('/description', arguments: element); } ,
      ));
    });

    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: recipeCard
      ),
    );
  }

}