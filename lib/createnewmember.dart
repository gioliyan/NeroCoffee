import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:nerocoffee/signin.dart';
import 'menu.dart';
import 'listmember.dart';
import 'package:flutter/material.dart';

class CreateMember extends StatefulWidget {
  CreateMember({this.email});
  final String email;
  @override
  _CrtMember createState() => new _CrtMember();
}

class _CrtMember extends State<CreateMember> {
  String name = '';
  String emailmember = '';
  String phonenumber = '';
  String address = '';

  void _addMember() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      CollectionReference _user =
          FirebaseFirestore.instance.collection('member');
      await _user.add({
        "email": email,
        "name": name,
        "emailmember": emailmember,
        "phonenumber": phonenumber,
        "address": address,
      });
    });
    MaterialPageRoute route = MaterialPageRoute(builder: (_) => Member());
    Navigator.push(context, route);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Create New Member'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        name = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Name",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        emailmember = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Email",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    keyboardType: TextInputType.number,
                    onChanged: (String str) {
                      setState(() {
                        phonenumber = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Phone Number",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    onChanged: (String str) {
                      setState(() {
                        address = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Address",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
              ],
            ),
          ),
          Padding(
            padding: const EdgeInsets.only(top: 40.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                IconButton(
                  icon: Icon(Icons.check, size: 40.0),
                  onPressed: () {
                    _addMember();
                  },
                ),
                IconButton(
                  icon: Icon(Icons.close, size: 40.0),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
