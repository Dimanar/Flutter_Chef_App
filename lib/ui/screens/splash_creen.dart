import 'dart:async';
import 'dart:math';
import 'package:master_chef/resources/constants.dart';
import 'package:shimmer/shimmer.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';


class SplashScreen extends StatefulWidget {

  @override
  _SplashScreenState createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {

  @override
  void initState() {
    super.initState();
    Future.delayed(Duration(seconds: 3), () {}).then(
            (_) => Navigator.of(context).pushReplacementNamed('/home')
    );
  }

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      body: Container(
        child: Stack(
          children: <Widget>[
            SafeArea(child: _buildBackground()),
            Center(child: _buildAnimationText()),
            Center(child: _buildCircleWithShadowPhoto())
          ],
        ),
      ),
    );
  }

  Widget _buildBackground() {
    return Image(
      image: AssetImage(SplashConstant.splash_bg),
      width: SizeConfig.screenWidth,
      height: SizeConfig.screenHeight,
      fit: BoxFit.cover,
    );
  }

  Widget _buildAnimationText() {
    return Container(
      margin: EdgeInsets.only(top: 70),
      child: Shimmer.fromColors(
        period: Duration(microseconds: pow(11, 6)),
        baseColor: SplashConstant.kSplashColorStart,
        highlightColor: SplashConstant.kSplashColorEnd,
        child: _buildTextForAnimation(),
      ),
    );
  }

  Widget _buildCircleWithShadowPhoto() {
    return Container(
      margin: EdgeInsets.only(top: 170),
      width: 370.0,
      height: 370.0,
      decoration: _buildDecorationForPhoto(),
    );
  }

  BoxDecoration _buildDecorationForPhoto() {
    return BoxDecoration(
        boxShadow: [BoxShadow(
            offset: Offset(3, 3),
            blurRadius: 40,
            color: AppConstant.kTextColor.withOpacity((0.73))
        )],
        shape: BoxShape.circle,
        border: Border.all(
          color: AppConstant.kTextColor.withOpacity(0.6),
          width: 01.0,
        ),
        image: DecorationImage(
            fit: BoxFit.fill,
            image: AssetImage(SplashConstant.splash_photo,
            )
        )
    );
  }

  Widget _buildTextForAnimation() {
    return Container(
      alignment: Alignment.topCenter,
      child: Text(
        SplashConstant.splash_str,
        style: TextStyle(
          fontSize: 67.0,
          fontFamily: 'Sansa',
          shadows: <Shadow>[
            Shadow(
                blurRadius: 18.0,
                color: AppConstant.kTextColor,
                offset: Offset.fromDirection(120, 12)
            )
          ],
        ),
      ),
    );
  }

}