import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:hexcolor/hexcolor.dart';
import 'package:expandable/expandable.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'dart:math' as math;
import 'package:master_chef/resources/constants.dart';
import 'package:master_chef/ui/components/appbar.dart';
import 'package:master_chef/ui/components/sibebar_menu.dart';

class RecipesScreen extends StatefulWidget {
  final ItemRecipe dishes;

  RecipesScreen({
    Key key,
    @required this.dishes,
  }) :super(key: key);

  @override
  State<StatefulWidget> createState() => _RecipesScreenState(dishes: dishes);
}

class _RecipesScreenState extends State<RecipesScreen> {

  final ItemRecipe dishes;
  Map<String, dynamic> meta;
  List<String> ingredients;
  List<String> directions;

  _RecipesScreenState({
    @required this.dishes,
  }) {
    meta = dishes.parseMeta();
    ingredients = dishes.parseIngredients();
    directions = dishes.parseDirections();
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      appBar: buildAppBar(title: 'Delisious'),
      drawer: SideBar(),
      body: Stack(
        children: [
          _buildImageDishes(),
          _buildScrollBar(),
        ],
      ),
    );
  }

  Widget _buildImageDishes() {
    return ClipRRect(
      child: Image.network(
          dishes.image,
          height: SizeConfig.screenHeight * 0.4,
          width: SizeConfig.screenWidth,
          fit:BoxFit.fill
      ),
    );
  }

  Widget _buildScrollBar() {
    return DraggableScrollableSheet(
        initialChildSize: 0.6,
        maxChildSize: 0.9,
        minChildSize: 0.6,
        builder: (BuildContext context, ScrollController scrollController) {
          return SingleChildScrollView(
            controller: scrollController,
            child: Container(
              decoration: BoxDecoration(
                  color: AppConstant.kBackgroundColor,
                  borderRadius: BorderRadius.only(
                    topRight: Radius.circular(30),
                    topLeft: Radius.circular(30),
                  )
              ),
              child: Column(
                children: [
                  _buildBlockTitle(context),
                  _buildBoxWithMetaInfo( _buildListOfRichText()),
                  Card3(indgreds: ingredients,),
                  Direction(directions: directions),
                  Text('The end!'),
                ],
              ),
            ),
          );
        }
    );
  }

  Widget _buildBlockSummary() {
    return Container(
      decoration:  BoxDecoration(
        // color: AppConstant.kPrimaryColor
        borderRadius: BorderRadius.only(
          topRight: Radius.circular(30),
          topLeft: Radius.circular(30),
        ),
        color: HexColor('#f2f2f2'),
        boxShadow: [BoxShadow(
          blurRadius: 205.0, // soften the shadow
          spreadRadius: 100.0, //extend the shadow
          offset: Offset(
            15.0, // Move to right 15  horizontally
            15.0, // Move to bottom 15 Vertically
          ),
          color: AppConstant.kPrimaryColor.withOpacity(0.53),
        ),
        ],
      ),
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Container(
          child: Text(
            dishes.summary.trim(),
            style: TextStyle(
              color: AppConstant.kTextColor,
              fontFamily: 'NotSansa',
              fontSize: 18.0,
            ),
          ),
        ),
      ),
    );
  }

  void _showSummaryBlock(context) {
    showBottomSheet(context: context, builder: (BuildContext buildContext) {
      return _buildBlockSummary();
    });
  }

  Widget _buildBlockTitle(context) {
    return GestureDetector(
      onTap: () {
        print('On TAP Block Summary');
        _showSummaryBlock(context);
      },
      child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.12,
          decoration: new BoxDecoration(
              color: AppConstant.kPrimaryColor.withOpacity(0.94),
              borderRadius:  BorderRadius.only(
                  topLeft: Radius.circular(30.0),
                  topRight: Radius.circular(30.0))
          ),
          child: Center(child: _buildTitle())
      ),
    );
  }

  Widget _buildTitle() {
    return Padding(
      padding: const EdgeInsets.all(8.0),
      child: Text(
          (dishes.name != null) ? dishes.name.toUpperCase() : "Empty",
          textAlign: TextAlign.center,
          overflow: TextOverflow.visible,
          style: TextStyle(
            fontSize: 28.0,
            fontFamily: 'NotoSansa',
            color: AppConstant.kTextColor,
          )
      ),
    );
  }

  String _reverseTimeToSimple(int time) {
    String hr = (time ~/ 60 >= 1) ? (time ~/ 60).toString() + ' hr ' : '' ;
    String mins = (time % 60 >= 1) ? (time % 60).toString() + ' mins ': '' ;
    return hr + mins;
  }

  List<RichText> _buildListOfRichText() {
    List<RichText> result = [];
    meta.forEach((key, value) {
      if (value.runtimeType == int && value == 0) {}
      else
        result.add(
          RichText(
            text: TextSpan(
                style: TextStyle(
                  color: AppConstant.kTextColor,
                  fontSize: 18.0,
                ),
                children: [
                  TextSpan(
                      text: key.toString() + ' : ',
                      style: TextStyle(fontWeight: FontWeight.bold, fontFamily: 'NotoSansa')
                  ),
                  TextSpan(
                      text: (value.runtimeType == String)
                          ? value
                          : _reverseTimeToSimple(value)
                  )
                ]
            ),
          ),
        );
    });
    return result;
  }

  Widget _buildBoxWithMetaInfo(List<RichText> data) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(20.0),
        child: Container(
          width: SizeConfig.screenWidth,
          height: SizeConfig.screenHeight * 0.15,
          decoration: BoxDecoration(
            color: AppConstant.kPrimaryColor.withOpacity(0.2),
            borderRadius: BorderRadius.circular(10),
            border: Border.all(
              color: AppConstant.kPrimaryColor,
              width: 5,
            ),
          ),
          child: Row(
            children: [
              _buildColumnWithMeta(data: data, max: 3, min: 0),
              _buildColumnWithMeta(data: data, max: data.length, min: 3),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildColumnWithMeta({List<RichText> data, int min, int  max}) {
    return Expanded(
      flex: 1,
      child: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: data.sublist(min, max),
        ),
      ),
    );
  }

}

class Direction extends StatelessWidget {
  Direction({
    @required this.directions
  });

  List<String> directions;

  @override
  Widget build(BuildContext context) {

    buildItem(str) {
      return Padding(
        padding: const EdgeInsets.all(20.0),
        child: Text(str, style: TextStyle(fontSize: 20),),
      );
    }
    builList() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          for (var str in directions) buildItem(str),
        ],
      );
    }
    return builList();

  }
}

class Card3 extends StatelessWidget {

  final List<String> indgreds;
  Card3({@required this.indgreds});

  @override
  Widget build(BuildContext context) {

    buildItem(String label) {
      return Padding(
        padding: EdgeInsets.only(
          left: 15,
          right: 10,
          bottom: 10,
          top: 10,
        ),
        child: Text(
          label.trim(),
          style: TextStyle(
            color: AppConstant.kTextColor,
            fontSize: 17.0,
          ),
        ),
      );
    }

    buildList() {
      return Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          for (var str in indgreds) buildItem(str),
        ],
      );
    }

    return ExpandableNotifier(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ScrollOnExpand(
            child: Card(
              clipBehavior: Clip.antiAlias,
              child: Column(
                children: <Widget>[
                  ExpandablePanel(
                    theme: const ExpandableThemeData(
                      headerAlignment: ExpandablePanelHeaderAlignment.center,
                      tapBodyToExpand: true,
                      tapBodyToCollapse: true,
                      hasIcon: false,
                    ),
                    header: Container(
                      color: AppConstant.kPrimaryColor.withOpacity(0.94),
                      child: Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Row(
                          children: [
                            ExpandableIcon(
                              theme: const ExpandableThemeData(
                                expandIcon: Icons.arrow_right,
                                collapseIcon: Icons.arrow_drop_down,
                                iconColor: AppConstant.kTextColor,
                                iconSize: 45.0,
                                iconRotationAngle: math.pi / 2,
                                iconPadding: EdgeInsets.only(right: 5),
                                hasIcon: false,
                              ),
                            ),
                            Expanded(
                              child: Text(
                                "Ingredients : ",
                                style: TextStyle(
                                    color: AppConstant.kTextColor,
                                    fontSize: 20.0,
                                    fontFamily: 'NotoSansa'
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ),
                    expanded: buildList(),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
