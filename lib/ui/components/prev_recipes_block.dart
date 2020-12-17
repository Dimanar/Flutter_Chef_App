import 'package:flutter/material.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/resources/constants.dart';
import 'package:master_chef/ui/components/preview_blocks.dart';

class ScrolsPrevRecipesBlock extends StatelessWidget {

  final List<ItemRecipe> items;
  final Function press;
  final String type;

  ScrolsPrevRecipesBlock({
    Key key,
    @required this.items,
    @required this.press,
    @required this.type,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        _buildTitleWithMoreButton(),
        RecipesBlock(recipes: items,),
      ],
    );
  }

  Widget _buildTitleWithMoreButton() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppConstant.kDefaultPadding),
      child: Row(
        children: [
          _buildTitleWithCustomUnderline(type),
          _buildSpacer(),
          _buildButton()
        ],
      ),
    );
  }

  Spacer _buildSpacer() {
    return Spacer();
  }

  Widget _buildTitleWithCustomUnderline(text) {
    return Container(
      height: 24,
      child: Stack(
        children: <Widget>[
          _buildText(text),
          _buildLine()
        ],
      ),
    );
  }

  Widget _buildText(text) {
    return Padding(
      padding: const EdgeInsets.only(
          left: AppConstant.kDefaultPadding / 4),
      child: Text(
        text,
        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
      ),
    );
  }

  Widget _buildLine() {
    return Positioned(
      bottom: 0,
      right: 0,
      left: 0,
      child: Container(
        margin: EdgeInsets.only(right: AppConstant.kDefaultPadding / 4),
        height: 7,
        color: AppConstant.kPrimaryColor.withOpacity(0.15),
      ),
    );
  }

  FlatButton _buildButton() {
    return FlatButton(
      color: AppConstant.kPrimaryColor,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(20),
      ),
      onPressed: press,
      child: Text(
        AppConstant.more,
        style: TextStyle(color: Colors.white),
      ),
    );
  }

}

