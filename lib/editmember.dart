import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'login.dart';
import 'package:nerocoffee/signin.dart';
import 'menu.dart';
import 'listmember.dart';
import 'package:flutter/material.dart';

class EditMember extends StatefulWidget {
  EditMember(
      {this.name,
      this.emailmember,
      this.phonenumber,
      this.address,
      this.index});
  final String name;
  final String emailmember;
  final String phonenumber;
  final String address;
  final index;
  @override
  _CrtMember createState() => new _CrtMember();
}

class _CrtMember extends State<EditMember> {
  TextEditingController nameController;
  TextEditingController emailmemberController;
  TextEditingController phonenumberController;
  TextEditingController addressController;

  String name;
  String emailmember;
  String phonenumber;
  String address;

  void _editMember() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
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
  void initState() {
    super.initState();

    name = widget.name;
    emailmember = widget.emailmember;
    phonenumber = widget.phonenumber;
    address = widget.address;

    nameController = TextEditingController(text: widget.name);
    emailmemberController = TextEditingController(text: widget.emailmember);
    phonenumberController = TextEditingController(text: widget.phonenumber);
    addressController = TextEditingController(text: widget.address);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Member'),
      ),
      body: Column(
        children: [
          SizedBox(
            height: 30,
          ),
          Container(
            width: 310,
            child: Column(
              children: [
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: nameController,
                    onChanged: (String str) {
                      setState(() {
                        name = str;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.perm_identity_sharp),
                      hintText: "Name",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: emailmemberController,
                    onChanged: (String str) {
                      setState(() {
                        emailmember = str;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.mail_sharp),
                      hintText: "Email",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: phonenumberController,
                    onChanged: (String str) {
                      setState(() {
                        phonenumber = str;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.phone_android),
                      hintText: "Phone Number",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: addressController,
                    onChanged: (String str) {
                      setState(() {
                        address = str;
                      });
                    },
                    decoration: InputDecoration(
                      icon: Icon(Icons.location_on),
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
                    _editMember();
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
