import 'package:dhananjaya_2255011003/CS_Screen/customer_screen.dart';
import 'package:dhananjaya_2255011003/List_Screen/division_screen.dart';
import 'package:dhananjaya_2255011003/List_Screen/priority_screen.dart';
import 'package:flutter/material.dart';
import 'package:dhananjaya_2255011003/CS_Screen/edit_customer.dart';
import 'package:dhananjaya_2255011003/CS_Screen/formcs.dart';

class CustomDrawer extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: <Widget>[
          DrawerHeader(
            decoration: BoxDecoration(
              color: const Color.fromARGB(127, 204, 169, 141),
            ),
            child: Text(
              'Menu',
              style: TextStyle(
                color: Colors.black,
                fontSize: 24,
              ),
            ),
          ),
          ListTile(
            leading: Icon(Icons.headphones),
            title: Text('CS Screen'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const CustomerScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.priority_high),
            title: Text('Priorities Screen'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const PriorityScreen()),
              );
            },
          ),
          ListTile(
            leading: Icon(Icons.cell_tower),
            title: Text('Division Screen'),
            onTap: () {
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(builder: (context) => const DivisionScreen()),
              );
            },
          ),
        ],
      ),
    );
  }
}
