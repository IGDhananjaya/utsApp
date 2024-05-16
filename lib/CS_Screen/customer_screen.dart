import 'dart:io';
import 'package:dhananjaya_2255011003/CS_Screen/edit_customer.dart';
import 'package:dhananjaya_2255011003/CS_Screen/formcs.dart';
import 'package:dhananjaya_2255011003/dto/cs.dart';
import 'package:dhananjaya_2255011003/dto/division.dart';
import 'package:dhananjaya_2255011003/dto/priorities.dart';
import 'package:dhananjaya_2255011003/endpoints/endpoints.dart';
import 'package:dhananjaya_2255011003/services/data_service.dart';
import 'package:dhananjaya_2255011003/utils/custom_drawer.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter_rating_bar/flutter_rating_bar.dart';

class CustomerScreen extends StatefulWidget {
  const CustomerScreen({Key? key}) : super(key: key);

  @override
  _CustomerScreenState createState() => _CustomerScreenState();
}

class _CustomerScreenState extends State<CustomerScreen> with WidgetsBindingObserver {
  Future<List<CustomerService>>? newcs;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    newcs = DataService.fetchCustomerService();
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
          title: Text("Customer Service"),
          backgroundColor: const Color.fromARGB(127, 204, 169, 141),
        ),
        drawer: CustomDrawer(),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color.fromRGBO(82, 170, 94, 1.0),
          tooltip: 'Add New Customer Service',
          onPressed: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const FormScreen()),
            );
          },
          child: const Icon(Icons.add),
        ),
        body: SingleChildScrollView(
          scrollDirection: Axis.vertical,
          child: Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: FutureBuilder<List<CustomerService>>(
                      future: newcs,
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
                                child: Row(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    if (item.imageUrl != null)
                                      Container(
                                        margin: EdgeInsets.only(right: 8.0),
                                        child: Image.network(
                                          Uri.parse('${Endpoints.baseURL}/public/${item.imageUrl!}')
                                              .toString(),
                                          width: 100,
                                          errorBuilder: (context, error, stackTrace) => const Icon(Icons.error),
                                        ),
                                      ),
                                    Expanded(
                                      child: Column(
                                        crossAxisAlignment: CrossAxisAlignment.start,
                                        children: [
                                          Text(
                                            'Issue : ${item.titleIssues}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color.fromARGB(255, 36, 31, 31),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          Text(
                                            'Deskripsi : ${item.descriptionIssues}',
                                            style: GoogleFonts.poppins(
                                              fontSize: 14,
                                              color: const Color.fromARGB(255, 36, 31, 31),
                                              fontWeight: FontWeight.normal,
                                            ),
                                          ),
                                          RatingBar.builder(
                                            initialRating: item.rating.toDouble(),
                                            minRating: 1,
                                            direction: Axis.horizontal,
                                            allowHalfRating: true,
                                            itemCount: 5,
                                            itemPadding: EdgeInsets.symmetric(horizontal: 4.0),
                                            itemBuilder: (context, _) => Icon(
                                              Icons.star,
                                              color: Colors.amber,
                                            ),
                                            onRatingUpdate: (rating) {
                                              setState(() {
                                                item.rating = rating.toInt();
                                              });
                                            },
                                          ),
                                          Row(
                                            mainAxisAlignment: MainAxisAlignment.end,
                                            children: [
                                              IconButton(
                                                onPressed: () {
                                                  Navigator.push(
                                                    context,
                                                    MaterialPageRoute(
                                                      builder: (context) => EditDatas(
                                                        idCustomerService: item.idCustomerService,
                                                        title: item.titleIssues,
                                                        description: item.descriptionIssues,
                                                        rating: item.rating,
                                                        selectedPriority: Priority(priorityName: item.priority),
                                                        selectedDepartment: Division(divisionDepartmentName: item.department),
                                                        imageFile: item.imageUrl != null ? File(item.imageUrl!) : null,
                                                        onSave: (title, description, rating, selectedPriority, selectedDepartment, imageFile) {
                                                          setState(() {
                                                            item.titleIssues = title;
                                                            item.descriptionIssues = description;
                                                            item.rating = rating;
                                                            item.priority = selectedPriority.priorityName!;
                                                            item.department = selectedDepartment.divisionDepartmentName!;
                                                            item.imageUrl = imageFile != null ? imageFile.path : null;
                                                          });
                                                        },
                                                      ),
                                                    ),
                                                  );
                                                },
                                                icon: Icon(Icons.edit),
                                              ),
                                              IconButton(
                                                onPressed: () async {
                                                  bool confirm = await showDialog(
                                                    context: context,
                                                    builder: (BuildContext context) {
                                                      return AlertDialog(
                                                        title: Text('Confirm Deletion'),
                                                        content: Text('Are you sure you want to delete this item?'),
                                                        actions: <Widget>[
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(false);
                                                            },
                                                            child: Text('Cancel'),
                                                          ),
                                                          TextButton(
                                                            onPressed: () {
                                                              Navigator.of(context).pop(true);
                                                            },
                                                            child: Text('Delete'),
                                                          ),
                                                        ],
                                                      );
                                                    },
                                                  );
                                                  if (confirm) {
                                                    DataService.deleteCustomerService(item.idCustomerService).then((_) {
                                                      ScaffoldMessenger.of(context).showSnackBar(
                                                        SnackBar(
                                                          content: Text('Data successfully deleted'),
                                                        ),
                                                      );
                                                      setState(() {
                                                        newcs = DataService.fetchCustomerService();
                                                      });
                                                    }).catchError((error) {
                                                      print('Error deleting data: $error');
                                                    });
                                                  }
                                                },
                                                icon: Icon(Icons.delete),
                                              ),
                                            ],
                                          ),
                                        ],
                                      ),
                                    ),
                                  ],
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
