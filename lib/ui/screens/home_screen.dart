import 'package:flutter/material.dart';
import 'package:master_chef/model/item_recipe.dart';
import 'package:master_chef/resources/constants.dart';
import 'package:master_chef/resources/data_base_manager.dart';
import 'package:master_chef/ui/components/appbar.dart';
import 'package:master_chef/ui/components/prev_recipes_block.dart';
import 'package:master_chef/ui/components/sibebar_menu.dart';

class HomeScreen extends StatelessWidget {

  final dataManager = DataBaseManager();
  List<ItemRecipe> lists = [];
  String toSearch;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: buildAppBar(),
      drawer: SideBar(),
      body: SingleChildScrollView(
        child: Column(
          children: [
            _buildHeaderWithSearchBox(size: SizeConfig.size, context: context),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByMeal()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByAudience()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByCuisine()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByHolidays()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByCooking()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByIngred()),
            _buildWidgetFutureBuilder(dataManager.getDataForPreviewByDiets()),
          ],
        ),
      ),
    );
  }

  Widget _buildWidgetFutureBuilder(dataFuture) {
    return FutureBuilder(
        future: dataFuture,
        builder: (BuildContext context, AsyncSnapshot<dynamic> snapshot) {
          lists.clear();
          if (!snapshot.hasData)
            return Center(child: CircularProgressIndicator());
          else {
            for (var i = 1; i < snapshot.data.value.length; i++){
              lists.add(new ItemRecipe.fromJson(snapshot.data.value[i]));
            }
            return ScrolsPrevRecipesBlock(
                type: lists[0].type,
                items: lists,
                press: () { Navigator.of(context).pushNamed('/recipes', arguments: lists[0].type); }
            );
          }
        }
    );
  }

  Widget _buildHeaderWithSearchBox({size, context}) {
    return Stack(
      children: <Widget>[
        Container(
          padding: EdgeInsets.only(
              left: AppConstant.kDefaultPadding,
              right: AppConstant.kDefaultPadding,
              bottom:  AppConstant.kDefaultPadding
          ),
          height: SizeConfig.screenHeight * 0.12,
          decoration: BoxDecoration(
              color: AppConstant.kPrimaryColor,
              borderRadius: BorderRadius.only(
                bottomLeft: Radius.circular(36),
                bottomRight: Radius.circular(36),
              )
          ),
          child: Row(
            children: <Widget>[
              _buildText(context),
              Spacer(),
              _buildImage(),
            ],
          ),
        ),
      ],
    );
  }

  Image _buildImage () {
    return Image.asset(
        SplashConstant.splash_photo,
        height: 60.0, width:  60.0
    );
  }

  Text _buildText (context) {
    return Text(
        AppConstant.greetings,
        style: Theme.of(context).textTheme.headline5.copyWith(
            color: Colors.white, fontWeight: FontWeight.bold,
            fontSize: 30
        )
    );
  }

}
