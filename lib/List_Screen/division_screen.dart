import 'dart:io';
import 'package:dhananjaya_2255011003/CS_Screen/edit_customer.dart';
import 'package:dhananjaya_2255011003/CS_Screen/formcs.dart';
import 'package:dhananjaya_2255011003/dto/cs.dart';
import 'package:dhananjaya_2255011003/dto/division.dart';
import 'package:dhananjaya_2255011003/dto/division.dart';
import 'package:dhananjaya_2255011003/endpoints/endpoints.dart';
import 'package:dhananjaya_2255011003/services/data_service.dart';
import 'package:dhananjaya_2255011003/utils/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class DivisionScreen extends StatefulWidget {
  const DivisionScreen({Key? key}) : super(key: key);

  @override
  _DivisionScreenState createState() => _DivisionScreenState();
}

class _DivisionScreenState extends State<DivisionScreen> with WidgetsBindingObserver {
  Future<List<Division>>? division;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    division = DataService.fetchDivision();
  }

  @override
  void dispose() {
    WidgetsBinding.instance.removeObserver(this);
    super.dispose();
  }

  @override
  Future<bool> didPopRoute() async {
    return false;
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async {
        return false;
      },
      child: Scaffold(
        appBar: AppBar(
          title: Text("Division List"),
          backgroundColor: const Color.fromARGB(127, 204, 169, 141),
        ),
        drawer: CustomDrawer(),
        // floatingActionButton: FloatingActionButton(
        //   backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
        //   tooltip: 'Add New Division',
        //   onPressed: () {
        //     Navigator.push(
        //       context,
        //       MaterialPageRoute(builder: (context) => const FormScreen()),
        //     );
        //   },
        //   child: const Icon(Icons.add),
        // ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder<List<Division>>(
                      future: division,
                      builder: (context, snapshot) {
                        if (snapshot.hasData) {
                          final data = snapshot.data!;
                          return ListView.builder(
                            shrinkWrap: true,
                            itemCount: data.length,
                            itemBuilder: (context, index) {
                              final item = data[index];
                              return Container(
                                margin: EdgeInsets.symmetric(
                                  vertical: 8.0,
                                  horizontal: 16.0,
                                ),
                                padding: EdgeInsets.all(8.0),
                                decoration: BoxDecoration(
                                  border: Border.all(color: Colors.grey),
                                  borderRadius: BorderRadius.circular(8.0),
                                ),
                                child: Text(
                                  'Division: ${item.divisionDepartmentName}',
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: const Color.fromARGB(255, 36, 31, 31),
                                    fontWeight: FontWeight.normal,
                                  ),
                                ),
                              );
                            },
                          );
                        } else if (snapshot.hasError) {
                          return Center(child: Text('${snapshot.error}'));
                        }
                        return const Center(child: CircularProgressIndicator());
                      },
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
