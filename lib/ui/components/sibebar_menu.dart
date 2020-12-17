import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:master_chef/resources/constants.dart';

class SideBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Column(
        children: <Widget>[
          DrawerHeader(
            child: Center(
              child: Text(
                'GIVE ME MONEY, QUICKLY!!! ',
                textAlign: TextAlign.center,
                style: TextStyle(color: Colors.white, fontSize: 25),
              ),
            ),
            decoration: BoxDecoration(
              color: AppConstant.kPrimaryColor,
            ),
          ),
          ListTile(
            selectedTileColor: AppConstant.kPrimaryColor,
            leading: Icon(Icons.home),
            title: Text('Home'),
            onTap: ()  { Navigator.of(context).pushReplacementNamed('/home'); },
          ),
          ListTile(
            leading: Icon(Icons.exit_to_app),
            title: Text('Logout'),
            onTap: () => { SystemNavigator.pop() },
          ),
        ],
      ),
    );
  }

}