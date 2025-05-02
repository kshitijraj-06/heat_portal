import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/WIdgets/appbar.dart';

import '../test.dart';

class Dashboard extends StatelessWidget{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(
                child: Appbar()
            ),
            Expanded(
                child: Text('Partner DashBoard',
                style: GoogleFonts.urbanist(
                  color: Colors.black
                ),)
            )
          ],
        ),
        actions: [
          GestureDetector(
            onTap: (){

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
                Get.offAll(PageDashboard());
              },
            ),
            ListTile(
              leading: Icon(Icons.table_chart),
              title: Text('Submitted Requests'),
              onTap: (){

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
      body: Center(
        child: ConstrainedBox(
            constraints: BoxConstraints(
              maxWidth: 1500,
              maxHeight: 1200,
            ),
          child: Container(
            margin: EdgeInsets.all(50),
            padding: EdgeInsets.only(top: 50),
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(10)
            ),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(10),
              child: Row(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Container(
                    padding: EdgeInsets.all(40),
                    width: 500,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        _statbox('Total Submissions Today', '0', Icons.upload),
                        _statbox('Pending Itineraries', '0', Icons.pending),
                        _statbox('Approved Itineraries', '0', Icons.check_circle),

                      ],
                    ),
                  ),
                  SizedBox(
                    width: 500,
                    child: ClipRRect(
                      borderRadius: BorderRadius.circular(15),
                      child: Container(
                        decoration: BoxDecoration(
                          image: const DecorationImage(
                            image: AssetImage('assets/bg_heat.jpg'),
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
                                  child: _userArea('View Users', Icons.people, (){ print('Users are this that');}),
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
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
                  )
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
      child: Container(
        width: 200,
        padding: EdgeInsets.all(16),
        child: Column(
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
      color: Colors.white.withValues(alpha: 0.7), // <-- Translucent white
      elevation: 0, // Optional: flat card
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(24)),
      child: InkWell(
        onTap: onTap,
        child: Container(
          width: 200,
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

}