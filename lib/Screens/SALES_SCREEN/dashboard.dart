import 'package:fl_chart/fl_chart.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:heat_portal/Services/viewCustomer_service.dart';
import 'package:heat_portal/WIdgets/appbar.dart';
import 'package:get/get.dart';
import 'package:table_calendar/table_calendar.dart';
import '../../Services/profile_service.dart';

class SalesDashBoard extends StatefulWidget {
  const SalesDashBoard({super.key});

  @override
  State<SalesDashBoard> createState() => _SalesDashBoardState();
}

class _SalesDashBoardState extends State<SalesDashBoard> {
  final customerController = Get.put(CustomerController());
  final profilecontroller = Get.put(ProfileController());
  late final CalendarFormat _calenderFormat = CalendarFormat.month;
  final DateTime _focusedDay = DateTime.now();

  @override
  void initState() {
    super.initState();
    print("SalesDashboard initState called");
    customerController.fetchCustomers().then((_) {
      print("Customers fetched: ${customerController.filteredCustomers.length}");
    }).catchError((error) {
      print("Error fetching customers: $error");
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.white.withValues(alpha: 1.15),
        toolbarHeight: 70,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Expanded(child: GestureDetector(
                onTap: (){
                  Get.offAllNamed('/dashboard');
                },
                child: Appbar())),
            Expanded(
              child: Text(
                'Dashboard',
                style: GoogleFonts.qwigley(color: Colors.black, fontSize: 35),
              ),
            ),
          ],
        ),
      ),
      drawer: Drawer(
        child: ListView(
          padding: EdgeInsets.zero,
          children: [
            DrawerHeader(
              decoration: BoxDecoration(color: Colors.black),
              child: Text(
                'Sales Person',
                style: GoogleFonts.poppins(color: Colors.white),
              ),
            ),
            ListTile(
              leading: Icon(Icons.dashboard),
              title: Text('Dashboard'),
              onTap: () {
                Get.offAllNamed('/sales_dashboard');
              },
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: ConstrainedBox(
          constraints: BoxConstraints(
            minWidth: MediaQuery.of(context).size.width,
          ),
          child: Container(
            constraints: BoxConstraints(
              maxWidth: MediaQuery.of(context).size.width,
            ),
            child: Padding(
              padding: const EdgeInsets.all(30.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        constraints: BoxConstraints(maxWidth: 300),
                        child: TextField(
                          decoration: InputDecoration(
                            hintText: 'Search',
                            prefixIcon: Icon(Icons.search),
                            border: OutlineInputBorder(
                              borderRadius: BorderRadius.circular(18),
                            ),
                            contentPadding: EdgeInsets.symmetric(
                              vertical: 0,
                              horizontal: 16,
                            ),
                            isDense: true,
                          ),
                          // onChanged: controller.filterUsers,
                        ),
                      ), //TODO: Search Bar
                      const SizedBox(width: 24),
                      Row(
                        children: [
                          Column(
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              Obx(() => Text(
                                  profilecontroller.name.value,
                                  style: GoogleFonts.poppins(
                                    color: Colors.black,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                              Obx(() => Text(
                                  profilecontroller.email.value,
                                  style: GoogleFonts.poppins(
                                    color: Colors.blueGrey,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ],
                          ),
                          SizedBox(width: 20),
                          GestureDetector(
                            onTap: () {
                              Get.offAllNamed('/profile');
                            },
                            child: CircleAvatar(
                              radius: 30,
                              child: Image.asset('assets/user.jpg'),
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 24),
                  Obx(() => Text(
                      'Hello, ${profilecontroller.name.value}',
                      style: GoogleFonts.poppins(fontSize: 27),
                    ),
                  ),
                  SizedBox(height: 24),
                  Row(
                    children: [
                      Container(
                        width: 300,
                        height: 160,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Image.asset('assets/blue_group.png'),
                            Padding(
                              padding: EdgeInsets.only(left: 18.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Quotations Sent',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "Rs.200",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'View Entire List',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), //TODO: BLUE_GROUP
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          //color: Color(0xFFFAD85D),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Image.asset('assets/yellow_group.png'),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Pending Payments',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "40",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'View Entire List',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), // TODO: YELLOW_GROUP
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          //color: Color(0xFFFAD85D),
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Image.asset('assets/pink_group.png'),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Completed Itinerary',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "80",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'View Entire List',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), // TODO: YELLOW_GROUP222
                      SizedBox(width: 20),
                      Container(
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(18),
                        ),
                        child: Stack(
                          children: [
                            Image.asset('assets/lavender_group.png'),
                            Padding(
                              padding: EdgeInsets.only(left: 25.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 20),
                                  Text(
                                    'Confirmed Itinerary',
                                    style: GoogleFonts.poppins(
                                      fontSize: 16,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    "120",
                                    style: GoogleFonts.poppins(
                                      fontSize: 32,
                                      fontWeight: FontWeight.w500,
                                    ),
                                  ),
                                  SizedBox(height: 15),
                                  Text(
                                    'View Entire List',
                                    style: GoogleFonts.poppins(fontSize: 12),
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ), //TODO: LAVENDER_GROUP
                    ],
                  ),
                  SizedBox(height: 20),
                  Row(
                    children: [
                      Container(
                        width: 940,
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xFF181B1A),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        padding: const EdgeInsets.all(24),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            // Header Row
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                Text(
                                  'Sales',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontWeight: FontWeight.bold,
                                    fontSize: 18,
                                  ),
                                ),
                                Row(
                                  children: [
                                    Container(
                                      padding: const EdgeInsets.symmetric(
                                        horizontal: 12,
                                        vertical: 8,
                                      ),
                                      decoration: BoxDecoration(
                                        color: const Color(0xFF232624),
                                        borderRadius: BorderRadius.circular(8),
                                      ),
                                      child: Row(
                                        children: [
                                          Icon(
                                            Icons.calendar_today,
                                            color: Colors.white,
                                            size: 16,
                                          ),
                                          SizedBox(width: 6),
                                          Text(
                                            '2022',
                                            style: TextStyle(
                                              color: Colors.white,
                                            ),
                                          ),
                                          Icon(
                                            Icons.arrow_drop_down,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ),
                                    SizedBox(width: 12),
                                    ElevatedButton.icon(
                                      onPressed: () {},
                                      icon: Icon(
                                        Icons.download,
                                        color: Color(0xFF181B1A),
                                      ),
                                      label: Text(
                                        'Download',
                                        style: TextStyle(
                                          color: Color(0xFF181B1A),
                                        ),
                                      ),
                                      style: ElevatedButton.styleFrom(
                                        backgroundColor: Color(0xFFF8D96B),
                                        shape: RoundedRectangleBorder(
                                          borderRadius: BorderRadius.circular(
                                            8,
                                          ),
                                        ),
                                        elevation: 0,
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                            const SizedBox(height: 24),
                            // Chart
                            SizedBox(
                              width: 950,
                              height: 260,
                              child: LineChart(
                                LineChartData(
                                  minX: 1,
                                  maxX: 12,
                                  minY: 0,
                                  maxY: 50000,
                                  gridData: FlGridData(
                                    show: true,
                                    drawVerticalLine: false,
                                    getDrawingHorizontalLine:
                                        (value) => FlLine(
                                          color: Colors.white.withOpacity(0.05),
                                          strokeWidth: 1,
                                        ),
                                  ),
                                  titlesData: FlTitlesData(
                                    leftTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 40,
                                        getTitlesWidget: (value, meta) {
                                          switch (value.toInt()) {
                                            case 10000:
                                              return _axisLabel('\$10k');
                                            case 20000:
                                              return _axisLabel('\$20k');
                                            case 30000:
                                              return _axisLabel('\$30k');
                                            case 40000:
                                              return _axisLabel('\$40k');
                                            case 50000:
                                              return _axisLabel('\$50k');
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    bottomTitles: AxisTitles(
                                      sideTitles: SideTitles(
                                        showTitles: true,
                                        reservedSize: 32,
                                        getTitlesWidget: (value, meta) {
                                          if (value >= 1 && value <= 12) {
                                            return Text(
                                              value.toInt().toString(),
                                              style: TextStyle(
                                                color: Colors.white.withOpacity(
                                                  0.4,
                                                ),
                                                fontSize: 12,
                                              ),
                                            );
                                          }
                                          return const SizedBox.shrink();
                                        },
                                      ),
                                    ),
                                    topTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                    rightTitles: AxisTitles(
                                      sideTitles: SideTitles(showTitles: false),
                                    ),
                                  ),
                                  borderData: FlBorderData(show: false),
                                  lineBarsData: [
                                    // Main solid line
                                    LineChartBarData(
                                      spots: [
                                        FlSpot(1, 25000),
                                        FlSpot(2, 20000),
                                        FlSpot(3, 15000),
                                        FlSpot(4, 20000),
                                        FlSpot(5, 18000),
                                        FlSpot(6, 30000),
                                        FlSpot(7, 35000),
                                        FlSpot(8, 40000),
                                        FlSpot(9, 32000),
                                        FlSpot(10, 47000),
                                        FlSpot(11, 30000),
                                        FlSpot(12, 28000),
                                      ],
                                      isCurved: true,
                                      color: const Color(0xFFB18AFF),
                                      barWidth: 4,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(show: false),
                                    ),
                                    // Dashed comparison line
                                    LineChartBarData(
                                      spots: [
                                        FlSpot(1, 22000),
                                        FlSpot(2, 23000),
                                        FlSpot(3, 12000),
                                        FlSpot(4, 25000),
                                        FlSpot(5, 19000),
                                        FlSpot(6, 27000),
                                        FlSpot(7, 31000),
                                        FlSpot(8, 35000),
                                        FlSpot(9, 42000),
                                        FlSpot(10, 39000),
                                        FlSpot(11, 34000),
                                        FlSpot(12, 32000),
                                      ],
                                      isCurved: true,
                                      color: const Color(0xFF3EF1C7),
                                      barWidth: 3,
                                      isStrokeCapRound: true,
                                      dotData: FlDotData(show: false),
                                      dashArray: [8, 8],
                                    ),
                                  ],
                                ),
                              ),
                            ), //TODO: CHART
                          ],
                        ),
                      ), // TODO: CHART_CARD/CONTAINER
                      SizedBox(width: 20),
                      Container(
                        width: 510,
                        height: 400,
                        decoration: BoxDecoration(
                          color: const Color(0xFF181B1A),
                          borderRadius: BorderRadius.circular(24),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Padding(
                              padding: EdgeInsets.only(left: 24.0, top: 24),
                              child: Text(
                                'Calender',
                                style: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                  fontSize: 18,
                                ),
                              ),
                            ),
                            TableCalendar(
                              calendarFormat: _calenderFormat,
                              focusedDay: _focusedDay,
                              firstDay: DateTime.now().subtract(
                                Duration(days: 365),
                              ),
                              lastDay: DateTime.now().add(Duration(days: 365)),
                              calendarStyle: CalendarStyle(
                                todayDecoration: BoxDecoration(
                                  color: Colors.blue,
                                  shape: BoxShape.circle,
                                ),
                                selectedDecoration: BoxDecoration(
                                  color: Colors.orange,
                                  shape: BoxShape.circle,
                                ),
                                defaultTextStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                weekendTextStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                outsideTextStyle: GoogleFonts.poppins(
                                  color: Colors.white38,
                                ),
                              ),
                              daysOfWeekStyle: DaysOfWeekStyle(
                                weekdayStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                ),
                                weekendStyle: GoogleFonts.poppins(
                                  color: Colors.white70,
                                ),
                              ),
                              headerStyle: HeaderStyle(
                                titleTextStyle: GoogleFonts.poppins(
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
                                formatButtonTextStyle: GoogleFonts.poppins(
                                  color: Colors.black,
                                ),
                                formatButtonDecoration: BoxDecoration(
                                  color: Colors.white,
                                  borderRadius: BorderRadius.circular(8),
                                ),
                                leftChevronIcon: Icon(
                                  Icons.chevron_left,
                                  color: Colors.white,
                                ),
                                rightChevronIcon: Icon(
                                  Icons.chevron_right,
                                  color: Colors.white,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                  SizedBox(height: 20),
                  Container(
                    height: 500,
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                      color: const Color(0xFF181B1A),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Padding(
                          padding: const EdgeInsets.all(24.0),
                          child: Row(
                            children: [
                              Expanded(
                                child: Text(
                                  'Customer Details',
                                  style: GoogleFonts.poppins(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                              ),
                              ElevatedButton.icon(
                                onPressed: () {},
                                icon: const Icon(
                                  Icons.download,
                                  color: Color(0xFF181B1A),
                                ),
                                label: const Text(
                                  "Download",
                                  style: TextStyle(
                                    color: Color(0xFF181B1A),
                                    fontWeight: FontWeight.bold,
                                  ),
                                ),
                                style: ElevatedButton.styleFrom(
                                  backgroundColor: const Color(0xFFF8D96B),
                                  elevation: 0,
                                  padding: const EdgeInsets.symmetric(
                                    horizontal: 18,
                                    vertical: 12,
                                  ),
                                  shape: RoundedRectangleBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                        SizedBox(height: 24),
                        Obx(() =>
                          DataTable(
                            headingTextStyle: const TextStyle(
                              color: Colors.white70,
                              fontWeight: FontWeight.bold,
                              fontSize: 15,
                            ),
                            dataTextStyle: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                            ),
                            headingRowColor: WidgetStateProperty.all(
                              const Color(0xFF181B1A),
                            ),
                            dataRowColor: WidgetStateProperty.all(
                              const Color(0xFF181B1A),
                            ),
                            dividerThickness: 0.5,
                            columns: const [
                              DataColumn(label: Text('ID')),
                              DataColumn(label: Text('Name')),
                              DataColumn(label: Text('Age')),
                              DataColumn(label: Text('Address')),
                              DataColumn(label: Text('Phone')),
                              DataColumn(label: Text('Email')),
                            ],
                            rows: customerController.filteredCustomers.map((customer) {
                              return DataRow(cells: [
                                DataCell(Text(customer.id.substring(0, 6))), // Shorten UUID
                                DataCell(Text(customer.name)),
                                DataCell(Text(customer.age.toString())),
                                DataCell(Text(customer.address)),
                                DataCell(Text(customer.phone)),
                                DataCell(Text(customer.email)),
                              ]);
                            }).toList(),
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }

  Widget _axisLabel(String text) => Text(
    text,
    style: TextStyle(color: Colors.white.withOpacity(0.4), fontSize: 12),
  );
}
