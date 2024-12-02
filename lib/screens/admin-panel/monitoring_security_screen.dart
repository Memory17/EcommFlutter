import 'package:flutter/material.dart';

class MonitoringSecurityScreen extends StatefulWidget {
  const MonitoringSecurityScreen({super.key});

  @override
  State<MonitoringSecurityScreen> createState() => _MonitoringSecurityScreenState();
}

class _MonitoringSecurityScreenState extends State<MonitoringSecurityScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Giám sát và Bảo mật",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildMonitoringCard(
              "Trạng thái hệ thống",
              Icons.info_outline,
              "Hệ thống đang hoạt động bình thường.",
              Colors.green,
            ),
            _buildMonitoringCard(
              "Cảnh báo an ninh",
              Icons.warning,
              "Không có cảnh báo an ninh hiện tại.",
              Colors.orange,
            ),
            _buildMonitoringCard(
              "Thiết bị giám sát",
              Icons.device_hub,
              "Tất cả các thiết bị đang hoạt động.",
              Colors.blue,
            ),
            _buildMonitoringCard(
              "Kiểm tra bảo mật",
              Icons.security,
              "Đã kiểm tra và không phát hiện vấn đề bảo mật.",
              Colors.red,
            ),
            _buildMonitoringCard(
              "Giám sát hoạt động người dùng",
              Icons.supervised_user_circle,
              "Theo dõi tất cả các hoạt động của người dùng.",
              Colors.blue,
            ),
            _buildMonitoringCard(
              "Lịch sử truy cập",
              Icons.history,
              "Đã ghi nhận lịch sử truy cập vào hệ thống.",
              Colors.purple,
            ),
            _buildMonitoringCard(
              "Cập nhật phần mềm",
              Icons.update,
              "Phần mềm đã được cập nhật gần đây.",
              Colors.green,
            ),
            _buildMonitoringCard(
              "Cảnh báo hệ thống",
              Icons.notifications_active,
              "Không có cảnh báo hệ thống nào.",
              Colors.red,
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để xây dựng mỗi mục giám sát
  Widget _buildMonitoringCard(String title, IconData icon, String description, Color statusColor) {
    return Card(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.circular(12.0),
      ),
      elevation: 5,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(12.0),
          color: Colors.blue.shade50,
        ),
        child: ListTile(
          leading: Icon(icon, size: 40, color: statusColor),
          title: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Text(description),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        ),
      ),
    );
  }
}
