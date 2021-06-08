import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/widgets.dart';
import 'login.dart';
import 'package:nerocoffee/signin.dart';
import 'menu.dart';
import 'listmenu.dart';
import 'createnewmember.dart';
import 'editmember.dart';

class Member extends StatefulWidget {
  @override
  ListMember createState() => ListMember();
}

class ListMember extends State<Member> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('List Member'),
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
      body: Stack(
        children: <Widget>[
          Padding(
            padding: EdgeInsets.all(15),
            child: StreamBuilder(
              stream: FirebaseFirestore.instance
                  .collection("member")
                  .where("email", isEqualTo: email)
                  .snapshots(),
              builder: (BuildContext context,
                  AsyncSnapshot<QuerySnapshot> snapshot) {
                if (!snapshot.hasData)
                  return new Container(
                    child: Center(
                      child: CircularProgressIndicator(),
                    ),
                  );
                return new MemberList(document: snapshot.data.docs);
              },
            ),
          ),
          Container(
            alignment: Alignment.bottomRight,
            margin: EdgeInsets.all(10),
            width: double.infinity,
            child: FloatingActionButton(
              child: Icon(Icons.add),
              backgroundColor: Colors.indigo,
              onPressed: () {
                MaterialPageRoute route =
                    MaterialPageRoute(builder: (_) => CreateMember());
                Navigator.push(context, route);
              },
            ),
          ),
        ],
      ),
    );
  }
}

class MemberList extends StatelessWidget {
  MemberList({this.document});
  final List<DocumentSnapshot> document;
  @override
  Widget build(BuildContext context) {
    return new ListView.builder(
      itemCount: document.length,
      itemBuilder: (BuildContext context, int i) {
        String name = document[i].data()['name'].toString();
        String emailmember = document[i].data()['email'].toString();
        String phonenumber = document[i].data()['phonenumber'].toString();
        String address = document[i].data()['address'].toString();
        return Dismissible(
          key: Key(document[i].id),
          onDismissed: (direction) {
            FirebaseFirestore.instance.runTransaction((transaction) async {
              DocumentSnapshot snapshot =
                  await transaction.get(document[i].reference);
              await transaction.delete(snapshot.reference);
            });

            Scaffold.of(context).showSnackBar(
              SnackBar(
                content: Text("Complete Delete Member"),
              ),
            );
          },
          child: Padding(
            padding: EdgeInsets.all(10),
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: <Widget>[
                Expanded(
                    child: Container(
                  child: Container(
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          name,
                          style: TextStyle(fontSize: 15, letterSpacing: 1.0),
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.mail_outline),
                            ),
                            Text(
                              emailmember,
                              style:
                                  TextStyle(fontSize: 15, letterSpacing: 1.0),
                            ),
                          ],
                        ),
                        Row(
                          children: <Widget>[
                            Padding(
                              padding: const EdgeInsets.only(right: 15),
                              child: Icon(Icons.phone),
                            ),
                            Text(
                              phonenumber,
                              style:
                                  TextStyle(fontSize: 15, letterSpacing: 1.0),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                )),
                IconButton(
                    icon: Icon(Icons.edit),
                    onPressed: () {
                      MaterialPageRoute route = MaterialPageRoute(
                          builder: (_) => EditMember(
                                name: name,
                                emailmember: emailmember,
                                phonenumber: phonenumber,
                                address: address,
                                index: document[i].reference,
                              ));
                      Navigator.push(context, route);
                    })
              ],
            ),
          ),
        );
      },
    );
  }
}
