import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:nerocoffee/listmenu.dart';
import 'login.dart';
import 'package:nerocoffee/signin.dart';
import 'menu.dart';
import 'listmember.dart';
import 'listmenu.dart';

class EditMenu extends StatefulWidget {
  EditMenu({this.nmmenu, this.price, this.index});
  final String nmmenu;
  final String price;
  final index;
  @override
  _CrtMenu createState() => new _CrtMenu();
}

class _CrtMenu extends State<EditMenu> {
  TextEditingController nameMenuController;
  TextEditingController priceController;

  String nmmenu = '';
  String price = '';

  void _editMenu() {
    FirebaseFirestore.instance.runTransaction((Transaction transaction) async {
      DocumentSnapshot snapshot = await transaction.get(widget.index);
      await transaction.update(snapshot.reference, {
        "email": email,
        "name_menu": nmmenu,
        "price": price,
      });
    });
    MaterialPageRoute route = MaterialPageRoute(builder: (_) => MenuList());
    Navigator.push(context, route);
  }

  @override
  void initState() {
    super.initState();

    nmmenu = widget.nmmenu;
    price = widget.price;

    nameMenuController = TextEditingController(text: widget.nmmenu);
    priceController = TextEditingController(text: widget.price);
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Edit Menu'),
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
                    controller: nameMenuController,
                    onChanged: (String str) {
                      setState(() {
                        nmmenu = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Name Menu",
                    ),
                    style: TextStyle(fontSize: 20.0, color: Colors.black),
                  ),
                ),
                Padding(
                  padding: EdgeInsets.all(10.0),
                  child: TextField(
                    controller: priceController,
                    onChanged: (String str) {
                      setState(() {
                        price = str;
                      });
                    },
                    decoration: InputDecoration(
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(5.0),
                      ),
                      hintText: "Price",
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
                    _editMenu();
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
