import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'about.dart';

class NavDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        // padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            child: Text(
              'Menu',
              style: TextStyle(color: Colors.white, fontSize: 25),
            ),
            decoration: BoxDecoration(
              color: Theme.of(context).primaryColor,

              // image: DecorationImage(
              //    // fit: BoxFit.fill,
              //     image: AssetImage('assets/images/cover.jpg')
              //     )
            ),
          ),
          // ListTile(
          //   leading: Icon(Icons.input),
          //   title: Text('Welcome'),
          //   onTap: () => {},
          // ),
          ListTile(
            leading: Icon(Icons.verified_user),
            title: Text('payments '),
            onTap: () => {Navigator.of(context).pop()},
          ),
          // ListTile(
          //   leading: Icon(Icons.settings),
          //   title: Text('Settings'),
          //   onTap: () => {Navigator.of(context).pop()},
          // ),
          ListTile(
            leading: Icon(Icons.border_color),
            title: Text('About Us '),
            onTap: () => {
              Navigator.of(context)
                  .push(MaterialPageRoute(builder: (context) => about_us()))
            },
          ),
          // ListTile(
          //   leading: Icon(Icons.exit_to_app),
          //   title: Text('Logout'),
          //   onTap: () {},
          // ),
        ],
      ),
    );
  }
}
