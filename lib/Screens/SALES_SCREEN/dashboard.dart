import 'package:flutter/material.dart';
import 'package:flutter_admin_scaffold/admin_scaffold.dart';
import 'package:fl_chart/fl_chart.dart';

class SalesDashboardBody extends StatelessWidget {
  const SalesDashboardBody({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return AdminScaffold(
      backgroundColor: const Color(0xFFF5F7FB),
      appBar: AppBar(
        title: const Text('HEAT Sales Dashboard'),
        backgroundColor: Colors.blueGrey[900],
      ),
      sideBar: SideBar(
        items: const [
          AdminMenuItem(title: 'Dashboard', icon: Icons.dashboard, route: '/dashboard'),
          AdminMenuItem(title: 'Quotations', icon: Icons.request_quote, route: '/quotations'),
          AdminMenuItem(title: 'Proforma Invoices', icon: Icons.receipt_long, route: '/invoices'),
          AdminMenuItem(title: 'Files', icon: Icons.folder, route: '/files'),
          AdminMenuItem(title: 'Bhutan Ops', icon: Icons.flag, route: '/bhutan'),
          AdminMenuItem(title: 'Reports', icon: Icons.bar_chart, route: '/reports'),
        ],
        selectedRoute: '/dashboard',
        onSelected: (item) {
          // handle navigation (use Get.toNamed or Navigator)
        },
        header: Container(
          height: 50,
          color: Colors.blueGrey[800],
          child: const Center(
            child: Text('HEAT Admin', style: TextStyle(color: Colors.white, fontWeight: FontWeight.bold)),
          ),
        ),
        footer: Container(
          height: 40,
          color: Colors.blueGrey[800],
          child: const Center(
            child: Text('© 2025 HEAT', style: TextStyle(color: Colors.white)),
          ),
        ),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Top KPI Cards
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                _kpiCard('Quotations Sent', '48', Icons.send),
                _kpiCard('Pending Payments', '6', Icons.access_time),
                _kpiCard('Confirmed Files', '22', Icons.check_circle),
                _kpiCard('Matured Files', '15', Icons.verified),
              ],
            ),
            const SizedBox(height: 32),

            // Sales Pipeline/Funnel Chart (Bar Chart Example)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                height: 260,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Sales Pipeline', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 16),
                    Expanded(
                      child: BarChart(
                        BarChartData(
                          barGroups: [
                            BarChartGroupData(x: 0, barRods: [
                              BarChartRodData(toY: 50, color: Colors.blue)
                            ], showingTooltipIndicators: [0]),
                            BarChartGroupData(x: 1, barRods: [
                              BarChartRodData(toY: 30, color: Colors.orange)
                            ], showingTooltipIndicators: [0]),
                            BarChartGroupData(x: 2, barRods: [
                              BarChartRodData(toY: 22, color: Colors.green)
                            ], showingTooltipIndicators: [0]),
                            BarChartGroupData(x: 3, barRods: [
                              BarChartRodData(toY: 15, color: Colors.purple)
                            ], showingTooltipIndicators: [0]),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('Enquiry');
                                    case 1:
                                      return const Text('Quotation');
                                    case 2:
                                      return const Text('Confirmed');
                                    case 3:
                                      return const Text('Matured');
                                    default:
                                      return const Text('');
                                  }
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Task List / Alerts
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Upcoming Tasks & Alerts',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    ListTile(
                      leading: const Icon(Icons.warning, color: Colors.orange),
                      title: const Text('3 files approaching payment TL'),
                      subtitle: const Text('Agent: ABC Travels'),
                      trailing: ElevatedButton(onPressed: () {}, child: const Text('Remind')),
                    ),
                    ListTile(
                      leading: const Icon(Icons.mail, color: Colors.blue),
                      title: const Text('Send confirmation mail for File #123'),
                      trailing: ElevatedButton(onPressed: () {}, child: const Text('Send')),
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Files Table
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Files', style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    DataTable(
                      columns: const [
                        DataColumn(label: Text('File #')),
                        DataColumn(label: Text('Agent')),
                        DataColumn(label: Text('Status')),
                        DataColumn(label: Text('TL')),
                        DataColumn(label: Text('Actions')),
                      ],
                      rows: [
                        DataRow(cells: [
                          const DataCell(Text('123')),
                          const DataCell(Text('ABC Travels')),
                          const DataCell(Text('Pending Payment')),
                          const DataCell(Text('05-May-2025')),
                          DataCell(Row(
                            children: [
                              IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.mail), onPressed: () {}),
                            ],
                          )),
                        ]),
                        DataRow(cells: [
                          const DataCell(Text('124')),
                          const DataCell(Text('Bhutan Explorer')),
                          const DataCell(Text('Confirmed')),
                          const DataCell(Text('07-May-2025')),
                          DataCell(Row(
                            children: [
                              IconButton(icon: const Icon(Icons.visibility), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.edit), onPressed: () {}),
                              IconButton(icon: const Icon(Icons.mail), onPressed: () {}),
                            ],
                          )),
                        ]),
                      ],
                    ),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Bhutan Operations Panel
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Bhutan Operations',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    const Text('Service Mail to Bhutan Agent: Pending'),
                    const SizedBox(height: 8),
                    const Text('Flight Ticket Status: Issued'),
                    const SizedBox(height: 8),
                    ElevatedButton(onPressed: () {}, child: const Text('Send Service Mail')),
                  ],
                ),
              ),
            ),
            const SizedBox(height: 32),

            // Analytics/Reports Section (Line Chart Example)
            Card(
              elevation: 2,
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
              child: Container(
                width: double.infinity,
                padding: const EdgeInsets.all(24),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Text('Analytics & Reports',
                        style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18)),
                    const SizedBox(height: 12),
                    SizedBox(
                      height: 200,
                      child: LineChart(
                        LineChartData(
                          lineBarsData: [
                            LineChartBarData(
                              spots: const [
                                FlSpot(0, 10),
                                FlSpot(1, 30),
                                FlSpot(2, 20),
                                FlSpot(3, 40),
                                FlSpot(4, 35),
                              ],
                              isCurved: true,
                              color: Colors.blue,
                              barWidth: 4,
                              dotData: FlDotData(show: false),
                            ),
                          ],
                          titlesData: FlTitlesData(
                            leftTitles: AxisTitles(
                              sideTitles: SideTitles(showTitles: true, reservedSize: 30),
                            ),
                            bottomTitles: AxisTitles(
                              sideTitles: SideTitles(
                                showTitles: true,
                                getTitlesWidget: (value, meta) {
                                  switch (value.toInt()) {
                                    case 0:
                                      return const Text('Jan');
                                    case 1:
                                      return const Text('Feb');
                                    case 2:
                                      return const Text('Mar');
                                    case 3:
                                      return const Text('Apr');
                                    case 4:
                                      return const Text('May');
                                    default:
                                      return const Text('');
                                  }
                                },
                              ),
                            ),
                            rightTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                            topTitles: AxisTitles(sideTitles: SideTitles(showTitles: false)),
                          ),
                          borderData: FlBorderData(show: false),
                          gridData: FlGridData(show: false),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // KPI Card Helper
  Widget _kpiCard(String title, String value, IconData icon) {
    return Card(
      elevation: 2,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(16)),
      child: Container(
        width: 230,
        height: 100,
        padding: const EdgeInsets.all(16),
        child: Row(
          children: [
            CircleAvatar(
              backgroundColor: Colors.blueGrey[100],
              child: Icon(icon, color: Colors.blueGrey[800]),
            ),
            const SizedBox(width: 12),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(value, style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 22)),
                Text(title, style: const TextStyle(fontSize: 14)),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
