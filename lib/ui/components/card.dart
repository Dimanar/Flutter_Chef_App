import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/resources/constants.dart';

class RecipeCard extends StatelessWidget {
  const RecipeCard({
    Key key,
    this.item,
    this.press,
  }) : super(key: key);

  final ItemRecipe item;
  final Function press;

  @override
  Widget build(BuildContext context) {
    return ConstrainedBox(
      constraints: BoxConstraints(
        maxWidth: SizeConfig.screenWidth * 0.5,
        maxHeight: SizeConfig.screenHeight * 0.44,
      ),
      child: Container(
        margin: EdgeInsets.only(
          left: AppConstant.kDefaultPadding * 0.3,
          right: AppConstant.kDefaultPadding * 0.3,
          bottom: AppConstant.kDefaultPadding * 0.5,
          top: AppConstant.kDefaultPadding * 0.5
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            _buildPrevImage(),
            _buildGestureDetector(context),
          ],
        ),
      ),
    );
  }

  Widget _buildPrevImage () {
    return ClipRRect(
      borderRadius: BorderRadius.only(
        topLeft: Radius.circular(20),
        topRight: Radius.circular(20),
      ),
      child: Image.network(
          item.image,
          height: SizeConfig.screenHeight * 0.4 - 160 ,
          fit:BoxFit.fill
      ),
    );
  }

  Widget _buildGestureDetector(context) {
    return GestureDetector(
      onTap: press,
        child: Container(
          padding: EdgeInsets.all(AppConstant.kDefaultPadding),
          decoration: BoxDecoration(
            color: Colors.white70,
            borderRadius: BorderRadius.only(
              bottomLeft: Radius.circular(10),
              bottomRight: Radius.circular(10),
            ),
            boxShadow: [BoxShadow(
              offset: Offset(1, 8),
              blurRadius: 30,
              color: AppConstant.kPrimaryColor.withOpacity(0.43),
            ),
            ],
          ),
          child: _buildTitleForCard(context),
        )
    );
  }

  Widget _buildTitleForCard(context) {
    return Stack(
      children: [
        _buildText(context)
      ],
    );
  }

  Widget _buildText(context) {
    return Text(
      item.name,
      overflow: TextOverflow.ellipsis,
      style: TextStyle(
        fontSize: 20.0,
        // fontFamily: 'NotoSansa',
        fontWeight: FontWeight.bold,
        color: AppConstant.kTextColor,
      )
    );
  }

}