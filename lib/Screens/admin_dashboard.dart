import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Screens/Admin_Screens/edit_employees.dart';
import 'package:heat_portal/Screens/SALES_SCREEN/dashboard.dart';
import 'package:heat_portal/Services/viewUser_service.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../test.dart';

class Dashboard extends StatefulWidget{
  const Dashboard({super.key});

  @override
  State<Dashboard> createState() => _DashboardState();
}

class _DashboardState extends State<Dashboard> {
  final controller = Get.put(UserController());
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 10),
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Appbar()
            ),
            Expanded(
                child: Text('Admin DashBoard',
                style: GoogleFonts.urbanist(
                  color: Colors.black,
                  letterSpacing: .5
                ),)
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){
              Get.offAllNamed('/profile');
            },
            child: CircleAvatar(
              radius: 30,
              backgroundImage: AssetImage('assets/user.jpg'),
            ),
          ),
        ],
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(
                color: Colors.green.shade900
              ),
                child: Text(
                    'Partner Menu',
                    style: GoogleFonts.poppins(
                        color: Colors.white,
                        fontSize: 20
                    )
                )
            ),
            ListTile(
              leading: Icon(Icons.add_box),
              title: Text('Submit New Requirement'),
              onTap: (){
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Submitted Requests'),
              onTap: (){
                Get.offAll(SalesDashBoard());
              },
            ),
            ListTile(
              leading: Icon(Icons.support_agent),
              title: Text('Support'),
              onTap: () {},
            ),
          ],
        ),
      ),
      body: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
            minHeight: 1200,
          ),
        child: SingleChildScrollView(
          child: Container(
            margin: EdgeInsets.all(20),
            padding: EdgeInsets.only(top: 20),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Column(
                    children: [
                      SizedBox(
                        width: 480,
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                              image: DecorationImage(
                                  image: AssetImage('assets/bg_dashboard2.jpg'),
                                fit: BoxFit.cover
                              )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                color: Colors.transparent
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                  padding: EdgeInsets.all(10),
                                child: StaggeredGrid.count(
                                  crossAxisCount: 3,
                                  mainAxisSpacing: 24,
                                  crossAxisSpacing: 24,
                                  children: [
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 1,
                                      child: _statbox('Total Submissions Today', '0', Icons.upload),
                                    ),
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 1, // taller card
                                      child: _statbox('Approved Itineraries', '0', Icons.check_circle),
                                    ),
                                    StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount: 2,
                                      child:  _statbox('Pending Itineraries', '0', Icons.pending),
                                    ),
                                  ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), // TODO: STATS_CARD
                      SizedBox(height: 20,),
                      SizedBox(
                        width: 480,
                        height: 350,
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(15),
                          child: Container(
                            decoration: BoxDecoration(
                                image: DecorationImage(
                                    image: AssetImage('assets/bg_dashboard3.jpg'),
                                    fit: BoxFit.cover
                                )
                            ),
                            child: Container(
                              decoration: BoxDecoration(
                                  color: Colors.transparent
                              ),
                              alignment: Alignment.center,
                              child: Padding(
                                padding: EdgeInsets.all(10),
                                child: StaggeredGrid.count(
                                    crossAxisCount: 3,
                                    mainAxisSpacing: 24,
                                    crossAxisSpacing: 24,
                                    children: [
                                      StaggeredGridTile.count(
                                        crossAxisCellCount: 1,
                                        mainAxisCellCount: 1,
                                        child: _employeeArea(
                                        'Create New Employee',
                                            Icons.add,
                                            (){
                                          Get.offAllNamed('/create_emp');
                                            },
                                        )
                                      ),
                                      StaggeredGridTile.count(
                                          crossAxisCellCount: 1,
                                          mainAxisCellCount: 1,
                                      child: SizedBox(),),
                                      StaggeredGridTile.count(
                                        crossAxisCellCount: 1,
                                        mainAxisCellCount: 2, // taller card
                                        child: _employeeArea(
                                          'View All Employee',
                                          Icons.visibility,
                                              (){
                                                Get.offAllNamed('/view_employee');
                                              },
                                        )
                                      ),
                                      StaggeredGridTile.count(
                                        crossAxisCellCount: 2,
                                        mainAxisCellCount: 1,
                                        child:  _employeeArea(
                                          'Edit Employee',
                                          Icons.edit,
                                              () {
                                            if (controller.alluser.isNotEmpty) {
                                              Get.offAll(EditEmployeePage(
                                                employeeId: controller.alluser[0].id,
                                                employee: controller.alluser[0],
                                              ));
                                            } else {
                                              Get.snackbar("Error", "No employees available to edit");
                                            }
                                          },
                                        )
                                      ),
                                    ]
                                ),
                              ),
                            ),
                          ),
                        ),
                      ), // TODO: EMPLOYEES_CARD
                    ],
                  ),
                  SizedBox(width: 20,),
                  SizedBox(
                    width: 480,
                    height: 600,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/bg_dashboard1.jpg'),
                            fit: BoxFit.cover,
                          ),
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                            color: Colors.transparent
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: StaggeredGrid.count(
                              crossAxisCount: 3,
                              mainAxisSpacing: 24,
                              crossAxisSpacing: 24,
                              children: [
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 2,
                                  mainAxisCellCount: 1,
                                  child: _userArea('Create New user', Icons.accessibility_new, (){ print('New User Created');}),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount: 1,
                                  child: _userArea('View Users', Icons.people, (){

                                  }),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount: 2, // taller card
                                  child: _userArea('Itinerary', Icons.trip_origin, (){}),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount: 1,
                                  child: _userArea('Reports', Icons.bar_chart, (){}),
                                ),
                                StaggeredGridTile.count(
                                  crossAxisCellCount: 1,
                                  mainAxisCellCount: 2,
                                  child: _userArea('SALES DASHBOARD', Icons.people, (){
                                    Get.offAll(SalesDashBoard());
                                  }),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // TODO: USERS_CARD
                  SizedBox(width: 20,),
                  SizedBox(
                    width: 480,
                    height: 350,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                            image: DecorationImage(
                                image: AssetImage('assets/bg_dashboard4.jpg'),
                                fit: BoxFit.cover
                            )
                        ),
                        child: Container(
                          decoration: BoxDecoration(
                              color: Colors.transparent
                          ),
                          alignment: Alignment.center,
                          child: Padding(
                            padding: EdgeInsets.all(10),
                            child: StaggeredGrid.count(
                                crossAxisCount: 3,
                                mainAxisSpacing: 24,
                                crossAxisSpacing: 24,
                                children: [

                                  StaggeredGridTile.count(
                                      crossAxisCellCount: 2,
                                      mainAxisCellCount: 1,
                                      child: _accountsArea(
                                        'Download Account Reports',
                                        Icons.download_sharp,
                                            (){},
                                      )
                                  ),
                                  StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount: 1, // taller card
                                      child: _employeeArea(
                                        'Check Accounts',
                                        Icons.visibility,
                                            (){},
                                      )
                                  ),
                                  StaggeredGridTile.count(
                                      crossAxisCellCount: 1,
                                      mainAxisCellCount: 1,
                                      child:  _accountsArea(
                                        'Edit Accounts',
                                        Icons.edit,
                                            (){},
                                      )
                                  ),
                                ]
                            ),
                          ),
                        ),
                      ),
                    ),
                  ), // TODO: ACCOUNTS_CARD
                ]
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _statbox(String title, String value, IconData icon) {
    return Card(
      color: Colors.white.withValues(alpha: 0.7),
      child: Container(
        //width: 150,
        padding: EdgeInsets.all(16),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 32,),
            SizedBox(height: 10,),
            Text(value, style: GoogleFonts.urbanist(fontSize: 20, fontWeight: FontWeight.bold)),
            SizedBox(height: 4,),
            Text(title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14)),
          ],
        ),
      ),
    );
  }

  Widget _userArea(String title, IconData icon ,VoidCallback onTap){
    return Card(
      color: Colors.white.withValues(alpha: 0.7),
      elevation: 0,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          //width: 200,
          padding: EdgeInsets.all(10),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(title, style: GoogleFonts.poppins(fontSize: 20)),
              SizedBox(height: 10),
              Icon(icon, size: 32),
              SizedBox(height: 10),
            ],
          ),
        ),
      ),
    );
  }

  Widget _employeeArea(String title, IconData icon, VoidCallback onTap) {
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.white.withValues(alpha: 0.7),
      child: InkWell(
        onTap: onTap,
        child: Container(
          //width: 150,
          padding: EdgeInsets.all(16),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Icon(icon, size: 32,),
              SizedBox(height: 10,),
              Text(title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14)),
            ]
          ),
        ),
      ),
    );
  }

  Widget _accountsArea(String title, IconData icon, VoidCallback onTap){
    return Card(
      elevation: 0,
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(24),
      ),
      color: Colors.white.withValues(alpha: 0.7),
      child: InkWell(
        onTap: onTap,
        child: Container(
          //width: 200,
          padding: EdgeInsets.all(16),
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(icon, size: 32,),
                SizedBox(height: 10,),
                Text(title, textAlign: TextAlign.center, style: GoogleFonts.poppins(fontSize: 14)),
              ]
          ),
        ),
      ),
    );
  }
}