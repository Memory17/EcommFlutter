import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class OrdersManagementScreen extends StatefulWidget {
  const OrdersManagementScreen({super.key});

  @override
  _OrdersManagementScreenState createState() => _OrdersManagementScreenState();
}

class _OrdersManagementScreenState extends State<OrdersManagementScreen> {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  late Future<List<Map<String, dynamic>>> _orders;

  @override
  void initState() {
    super.initState();
    _orders = _getOrders(); // Lấy danh sách đơn hàng khi màn hình được hiển thị
  }

  // Hàm lấy đơn hàng từ Firestore
  Future<List<Map<String, dynamic>>> _getOrders() async {
    var user = FirebaseAuth.instance.currentUser;
    List<Map<String, dynamic>> orders = [];

    try {
      // Lấy dữ liệu từ Firestore
      var querySnapshot = await _firestore
          .collection('orders') // Collection orders
          .doc(user!.uid) // UID của user
          .collection('confirmOrders') // Collection confirmOrders trong orders
          .get();

      // Duyệt qua các document trong collection và thêm vào list orders
      for (var doc in querySnapshot.docs) {
        var orderData = doc.data() as Map<String, dynamic>;
        orderData['id'] = doc.id; // Gán id của tài liệu vào orderData
        orders.add(orderData);
      }
    } catch (e) {
      print("Lỗi khi lấy đơn hàng: $e");
    }

    return orders;
  }

  // Hàm cập nhật trạng thái của đơn hàng
  Future<void> _updateStatus(String orderId) async {
    var user = FirebaseAuth.instance.currentUser;

    try {
      await _firestore
          .collection('orders')
          .doc(user!.uid)
          .collection('confirmOrders')
          .doc(orderId)
          .update({'status': true});

      print("Cập nhật trạng thái thành công!");
    } catch (e) {
      print("Lỗi khi cập nhật trạng thái: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Quản lý đơn hàng"),
        centerTitle: true,
        backgroundColor: Colors.blue,
      ),
      body: FutureBuilder<List<Map<String, dynamic>>>(
        future: _orders,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          }

          if (snapshot.hasError) {
            return const Center(child: Text('Có lỗi xảy ra!'));
          }

          if (!snapshot.hasData || snapshot.data!.isEmpty) {
            return const Center(child: Text('Không có đơn hàng nào!'));
          }

          final orders = snapshot.data!;

          return ListView.builder(
            itemCount: orders.length,
            itemBuilder: (context, index) {
              var order = orders[index];

              return Card(
                margin: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                elevation: 4.0,
                child: Padding(
                  padding: const EdgeInsets.all(16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      // Hiển thị hình ảnh sản phẩm
                      order['productImages'] != null && order['productImages'].isNotEmpty
                          ? Image.network(
                        order['productImages'][0], // Lấy ảnh từ mảng productImages
                        fit: BoxFit.cover, // Điều chỉnh cách hiển thị hình ảnh
                        height: 200.0, // Chiều cao của hình ảnh
                        width: double.infinity, // Độ rộng của hình ảnh
                      )
                          : const Text('Không có hình ảnh'), // Thông báo nếu không có hình ảnh

                      const SizedBox(height: 8.0),
                      Text(
                        "Khách hàng: ${order['customerName']}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                        ),
                      ),
                      const SizedBox(height: 8.0),
                      Text("Sản phẩm: ${order['productName']}"),
                      const SizedBox(height: 4.0),
                      Text("Số lượng: ${order['productQuantity']}"),
                      const SizedBox(height: 4.0),
                      Text("Số điện thoại: ${order['customerPhone']}"),
                      const SizedBox(height: 4.0),
                      Text("Địa chỉ: ${order['customerAddress']}"),
                      const SizedBox(height: 8.0),

                      // Hiển thị Thành tiền
                      Text(
                        "Thành tiền: ${order['fullPrice']  != null ? order['fullPrice'].toString() : 'Chưa có thông tin'}",
                        style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 16.0,
                          color: Colors.green, // Màu sắc cho thành tiền
                        ),
                      ),
                      const SizedBox(height: 8.0),

                      // Hiển thị trạng thái hoặc nút "Xác nhận"
                      order['status'] == true
                          ? const Icon(Icons.check_circle, color: Colors.green, size: 32.0)
                          : ElevatedButton(
                        onPressed: () {
                          if (order['id'] != null) {
                            _updateStatus(order['id']!);
                            setState(() {
                              order['status'] = true; // Cập nhật giao diện
                            });
                          } else {
                            print("ID của đơn hàng là null");
                          }
                        },
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.blue, // Màu nền
                          foregroundColor: Colors.white, // Màu chữ
                          padding: const EdgeInsets.symmetric(horizontal: 16.0, vertical: 8.0),
                          textStyle: const TextStyle(fontSize: 16.0, fontWeight: FontWeight.bold),
                        ),
                        child: const Text('Xác nhận'),
                      ),

                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
