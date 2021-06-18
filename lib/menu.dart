import 'package:flutter/material.dart';
import 'package:nerocoffee/loginpage.dart';
import 'package:nerocoffee/signin.dart';
import 'login.dart';
import 'listmember.dart';
import 'listmenu.dart';

class Menu extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Nero Coffe"),
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
                                'https://images.unsplash.com/photo-1595434091143-b375ced5fe5c?ixid=MnwxMjA3fDB8MHxzZWFyY2h8MXx8Y29mZmVlJTIwY3VwfGVufDB8fDB8fA%3D%3D&ixlib=rb-1.2.1&w=1000&q=80'),
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
      body: Container(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.max,
            children: <Widget>[
              SizedBox(height: 20),
              Text(
                'EMAIL',
                style: TextStyle(
                    fontSize: 15,
                    fontWeight: FontWeight.bold,
                    color: Colors.black54),
              ),
              Text(
                email,
                style: TextStyle(
                    fontSize: 25,
                    color: Colors.deepPurple,
                    fontWeight: FontWeight.bold),
              ),
              SizedBox(height: 40),
            ],
          ),
        ),
      ),
    );
  }
}
