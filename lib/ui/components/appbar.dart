import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:master_chef/resources/constants.dart';
import 'package:master_chef/ui/components/sibebar_menu.dart';

Widget buildAppBar({String title}) {
    return AppBar(
        title: Padding(
          padding: const EdgeInsets.only(right: AppConstant.kDefaultPadding),
          child: Center(
            child: title != null ? Text(
                title,
                style: TextStyle(
                  fontSize: 30.0,
                  fontFamily: 'NotSansa',
                  color: Colors.white,
                )
            ) : null,
          ),
        ),
        elevation: 0,
    );
  }

