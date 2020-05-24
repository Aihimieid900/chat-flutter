import 'package:flutter/material.dart';
import 'package:permission_handler/permission_handler.dart';
import 'package:contacts_service/contacts_service.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class SearchScreen extends StatefulWidget {
  @override
  SearchScreenState createState() => SearchScreenState();
}

class SearchScreenState extends State<SearchScreen> {
  String status;
  Permission permission;
  PermissionStatus _permissionStatus;
  Future<void> requestPermission(Permission permission) async {
    final status = await permission.request();

    setState(() {
      print(status);
      _permissionStatus = status;
      print(_permissionStatus);
    });
  }

  @override
  void initState() {
    super.initState();
    requestPermission(Permission.contacts);
    getContacts();
  }

  Future<void> getContacts() async {
// Get all contacts on device
    Iterable<Contact> contacts = await ContactsService.getContacts();

// Phone numbers
    contacts.forEach((contact) {
      // for gain all name
      Map<String, String> allNum = {};

      var namePhone = contact.displayName;
      //for pull all phones number
      var mobilenum = contact.phones;
      mobilenum.forEach((mobial) {
        var numPhone = mobial.value;
        if (numPhone.length >= 7) {
         
          bool strNumPhone = numPhone.toString().substring(0, 2) == '+2';
          bool strNumPhone2 = numPhone.toString().substring(0, 1) == '0';
          if (strNumPhone) {
            numPhone.toString().replaceAll('+20', '');
            allNum['name'] = namePhone;
            allNum['phone'] = numPhone.toString();
            print(allNum);
          } else if (strNumPhone2)
            print(numPhone.toString().substring(0, 1).replaceAll('0', ''));
          // Map<String> allNum={'numPhone':numPhone.toString(),
          // 'name':element.
          // };

        }
        // else if (numPhone.length <= 15) {
        //   print(numPhone);
        // }
      });
    });
  }

  checkNumPhone(var phone) {
    bool strNumPhone = phone.toString().substring(0, 2) == '+2';
    bool strNumPhone2 = phone.toString().substring(0, 1) == '0';
    if (strNumPhone)
      print(phone.toString().replaceAll('+20', ''));
    else if (strNumPhone2)
      print(phone.toString().substring(0, 1).replaceAll('0', ''));
    // Map<String> allNum={'numPhone':numPhone.toString(),
    // 'name':element.
    // };
  }

  List<String> typesearch = ['num', 'text'];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Container(
          child: Column(
            children: <Widget>[
              // Text('$contacts'),
              TextField(
                autofocus: true,
                decoration:
                    InputDecoration(labelText: 'Search by ${typesearch[0]}'),
                onChanged: (value) {},
              ),
            ],
          ),
        ),
      ),
    );
  }
}
