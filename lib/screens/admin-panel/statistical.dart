import 'dart:math';

import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart'; // Thư viện cho biểu đồ

class StatisticalScreen extends StatelessWidget {
  const StatisticalScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Thống kê doanh thu'),
        backgroundColor: Colors.blue,
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Text(
                  'Doanh thu theo tháng',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                IconButton(
                  icon: const Icon(Icons.filter_list),
                  tooltip: 'Lọc doanh thu',
                  onPressed: () {
                    _showTopThreeMonths(context);
                  },
                ),
              ],
            ),
            const Divider(thickness: 1, color: Colors.grey), // Đường ngăn cách
            const SizedBox(height: 20),
            Expanded(
              child: BarChart(
                BarChartData(
                  alignment: BarChartAlignment.spaceAround,
                  barGroups: _createBarGroups(),
                  titlesData: FlTitlesData(
                    bottomTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          switch (value.toInt()) {
                            case 0:
                              return const Text('T1');
                            case 1:
                              return const Text('T2');
                            case 2:
                              return const Text('T3');
                            case 3:
                              return const Text('T4');
                            case 4:
                              return const Text('T5');
                            case 5:
                              return const Text('T6');
                            default:
                              return const Text('');
                          }
                        },
                      ),
                    ),
                    leftTitles: AxisTitles(
                      sideTitles: SideTitles(
                        showTitles: true,
                        getTitlesWidget: (double value, TitleMeta meta) {
                          return Text(
                            value.toInt().toString(),
                            style: const TextStyle(fontSize: 10, color: Colors.black),
                          );
                        },
                      ),
                    ),
                  ),
                  borderData: FlBorderData(show: false),
                ),
              ),
            ),
            const SizedBox(height: 20),
            const Text(
              'Tổng doanh thu: 120,000,000 VND',
              style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
              textAlign: TextAlign.center,
            ),
            const SizedBox(height: 30),
            const Divider(thickness: 1, color: Colors.grey), // Đường ngăn cách thứ hai
            const Text(
              'Doanh thu theo danh mục',
              style: TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
              textAlign: TextAlign.center,
            ),
            const Divider(thickness: 1, color: Colors.grey), // Đường ngăn cách
            const SizedBox(height: 20),
            Expanded(
              child: PieChart(
                PieChartData(
                  sections: _createPieSections(),
                  centerSpaceRadius: 50,
                  sectionsSpace: 2,
                ),
              ),
            ),
            const SizedBox(height: 20),
            // Chú thích danh mục
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: const [
                _LegendItem(color: Colors.yellow, label: 'Điện thoại'),
                _LegendItem(color: Colors.green, label: 'Laptop'),
                _LegendItem(color: Colors.blue, label: 'Tai nghe'),
                _LegendItem(color: Colors.red, label: 'Iphone'),
              ],
            ),
          ],
        ),
      ),
    );
  }

  void _showTopThreeMonths(BuildContext context) {
    // Giả lập dữ liệu doanh thu
    final data = {
      'T1': 10,
      'T2': 15,
      'T3': 12,
      'T4': 8,
      'T5': 16,
      'T6': 20,
    };

    // Lấy 3 tháng có doanh thu cao nhất
    final topThree = data.entries.toList()
      ..sort((a, b) => b.value.compareTo(a.value));
    final filteredData = topThree.take(3).toList();

    // Hiển thị danh sách
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text('3 tháng có doanh thu cao nhất'),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: filteredData.map((e) {
              return ListTile(
                title: Text('${e.key}: ${e.value} triệu VND'),
              );
            }).toList(),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              style: TextButton.styleFrom(
                foregroundColor: Colors.blue, // Đặt màu chữ là xanh dương
              ),
              child: const Text('Đóng'),
            ),
          ],
        );
      },
    );
  }


  List<BarChartGroupData> _createBarGroups() {
    return [
      BarChartGroupData(x: 0, barRods: [BarChartRodData(fromY: 0, toY: 10, color: Colors.blue)]),
      BarChartGroupData(x: 1, barRods: [BarChartRodData(fromY: 0, toY: 15, color: Colors.blue)]),
      BarChartGroupData(x: 2, barRods: [BarChartRodData(fromY: 0, toY: 12, color: Colors.blue)]),
      BarChartGroupData(x: 3, barRods: [BarChartRodData(fromY: 0, toY: 8, color: Colors.blue)]),
      BarChartGroupData(x: 4, barRods: [BarChartRodData(fromY: 0, toY: 16, color: Colors.blue)]),
      BarChartGroupData(x: 5, barRods: [BarChartRodData(fromY: 0, toY: 20, color: Colors.blue)]),
    ];
  }

  List<PieChartSectionData> _createPieSections() {
    return [
      PieChartSectionData(
        value: 40,
        color: Colors.yellow,
        title: '40%',
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 30,
        color: Colors.green,
        title: '30%',
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 20,
        color: Colors.blue,
        title: '20%',
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
      PieChartSectionData(
        value: 10,
        color: Colors.red,
        title: '10%',
        titleStyle: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold, color: Colors.white),
      ),
    ];
  }
}

class _LegendItem extends StatelessWidget {
  final Color color;
  final String label;

  const _LegendItem({required this.color, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Container(
          width: 20,
          height: 20,
          color: color,
        ),
        const SizedBox(width: 8),
        Text(label, style: const TextStyle(fontSize: 16)),
      ],
    );
  }
}
