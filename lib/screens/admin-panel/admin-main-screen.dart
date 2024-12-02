import 'package:e_comm/screens/admin-panel/promotions_discounts_screen.dart';
import 'package:e_comm/screens/admin-panel/statistical.dart';
import 'package:e_comm/screens/admin-panel/terms_policies_screen.dart';
import 'package:e_comm/screens/admin-panel/users_management.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import '../auth-ui/welcome-screen.dart';
import '../user-panel/all-orders-screen.dart';
import 'monitoring_security_screen.dart';
import 'orders_management.dart';
import 'products_management.dart'; // Import màn hình quản lý sản phẩm

class AdminMainScreen extends StatefulWidget {
  const AdminMainScreen({super.key});

  @override
  State<AdminMainScreen> createState() => _AdminMainScreenState();
}

class _AdminMainScreenState extends State<AdminMainScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Quản trị viên",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.exit_to_app, color: Colors.white),
            onPressed: () {
              // Điều hướng về màn hình WelcomeScreen
              Get.to(() => WelcomeScreen());
            },
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Expanded(
              child: GridView.count(
                crossAxisCount: 2, // 2 cột
                crossAxisSpacing: 16.0,
                mainAxisSpacing: 16.0,
                children: [
                  _buildPanel("Quản lý sản phẩm", Icons.production_quantity_limits, () {
                    // Điều hướng đến màn hình quản lý sản phẩm
                    Get.to(() => ProductsManagement());
                  }),
                  _buildPanel("Quản lý người dùng", Icons.supervised_user_circle, () {
                    // Điều hướng đến quản lý người dùng
                    Get.to(() => UsersManagementScreen());
                  }),
                  _buildPanel("Thống kê doanh thu", Icons.bar_chart, () {
                    // Điều hướng đến thống kê doanh thu
                    Get.to(() => StatisticalScreen());
                  }),
                  _buildPanel("Quản lý đơn hàng", Icons.list_alt, () {
                    Get.to(() => OrdersManagementScreen());
                  }),
                  _buildPanel("Giám sát và bảo mật", Icons.security, () {
                    Get.to(() => MonitoringSecurityScreen());
                    // Điều hướng đến giám sát và bảo mật
                  }),
                  _buildPanel("Khuyến mãi và giảm giá", Icons.discount, () {
                    // Điều hướng đến giám sát và bảo mật
                    Get.to(() => PromotionsDiscountsScreen());
                  }),
                ],
              ),
            ),
            // Footer
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: GestureDetector(
                onTap: () {
                  // Điều hướng đến màn hình Terms and Policies
                  Get.to(() => TermsPoliciesScreen());
                },
                child: Text(
                  "Điều khoản & Chính sách",
                  textAlign: TextAlign.center,
                  style: TextStyle(
                    fontSize: 14.0,
                    color: Colors.blue.shade700,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

          ],
        ),
      ),
    );
  }

  // Hàm để xây dựng mỗi panel
  Widget _buildPanel(String title, IconData icon, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Card(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(12.0),
        ),
        elevation: 5,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(12.0),
            color: Colors.blue.shade50,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                size: 50,
                color: Colors.blue,
              ),
              SizedBox(height: 8.0),
              Text(
                title,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 18.0,
                  fontWeight: FontWeight.bold,
                  color: Colors.blue,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
