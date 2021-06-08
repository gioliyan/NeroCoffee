import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:nerocoffee/signin.dart';
import 'menu.dart';
import 'listmember.dart';

class MenuList extends StatefulWidget {
  @override
  ListMenu createState() => ListMenu();
}

class ListMenu extends State<MenuList> {
  @override
  Widget build(BuildContext) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Menu'),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: <Widget>[
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.indigo,
              ),
              child: Center(
                child: Column(
                  children: <Widget>[
                    Column(
                      children: [
                        Container(
                          margin: EdgeInsets.all(15),
                          child: CircleAvatar(
                            backgroundImage: NetworkImage(
                                'https://i.pinimg.com/736x/1e/1c/3e/1e1c3e4adbd53afaa0b7f2f999c46887.jpg'),
                            radius: 30,
                          ),
                        )
                      ],
                    ),
                    Text(
                      email,
                      style: TextStyle(
                          color: Colors.white, fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              ),
            ),
            ListTile(
              leading: Icon(Icons.home_sharp),
              title: Text('Home'),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => Menu());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.people_sharp),
              title: Text('List Member'),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => Member());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.menu_book_sharp),
              title: Text('List Menu'),
              onTap: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => MenuList());
                Navigator.push(context, route);
              },
            ),
            ListTile(
              leading: Icon(Icons.login_outlined),
              title: Text('Log Out'),
              onTap: () {
                signOutGoogle();
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return LoginPage2();
                }), ModalRoute.withName('/'));
              },
            ),
          ],
        ),
      ),
    );
  }
}
