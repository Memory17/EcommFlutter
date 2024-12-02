import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'addproduct_screen.dart'; // Import màn hình thêm sản phẩm nếu bạn đã tạo

class ProductsManagement extends StatelessWidget {
  const ProductsManagement({super.key});

  // Hàm xóa sản phẩm từ Firestore
  Future<void> _deleteProduct(String productId) async {
    try {
      await FirebaseFirestore.instance.collection('products').doc(productId).delete();
      // Có thể hiển thị thông báo thành công hoặc cập nhật lại UI nếu cần
    } catch (e) {
      print("Lỗi khi xóa sản phẩm: $e");
    }
  }

  // Hàm chỉnh sửa sản phẩm
  void _editProduct(BuildContext context, String productId, String initialProductName, String initialDeliveryTime, String initialSalePrice) {
    final productNameController = TextEditingController(text: initialProductName);
    final deliveryTimeController = TextEditingController(text: initialDeliveryTime);
    final salePriceController = TextEditingController(text: initialSalePrice);

    // Mở dialog hoặc panel chỉnh sửa sản phẩm
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Chỉnh sửa sản phẩm"),
          content: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              TextField(
                controller: productNameController,
                decoration: InputDecoration(labelText: 'Tên sản phẩm'),
              ),
              TextField(
                controller: deliveryTimeController,
                decoration: InputDecoration(labelText: 'Thời gian giao hàng'),
              ),
              TextField(
                controller: salePriceController,
                decoration: InputDecoration(labelText: 'Giá bán'),
                keyboardType: TextInputType.number,
              ),
            ],
          ),
          actions: [
            // Nút "Cập nhật" với màu xanh
            TextButton(
              onPressed: () async {
                // Cập nhật thông tin sản phẩm
                String updatedProductName = productNameController.text;
                String updatedDeliveryTime = deliveryTimeController.text;
                String updatedSalePrice = salePriceController.text;

                // Cập nhật sản phẩm trong Firestore
                try {
                  await FirebaseFirestore.instance.collection('products').doc(productId).update({
                    'productName': updatedProductName,
                    'deliveryTime': updatedDeliveryTime,
                    'salePrice': updatedSalePrice,
                  });

                  Navigator.of(context).pop(); // Đóng dialog
                  // Có thể hiển thị thông báo thành công nếu cần
                } catch (e) {
                  print("Lỗi khi cập nhật sản phẩm: $e");
                }
              },
              child: Text("Cập nhật"),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền xanh
                foregroundColor: Colors.white, // Màu chữ trắng
              ),
            ),
            // Nút "Hủy" với màu xanh
            TextButton(
              onPressed: () {
                Navigator.of(context).pop(); // Đóng dialog mà không cập nhật
              },
              child: Text("Hủy"),
              style: TextButton.styleFrom(
                backgroundColor: Colors.blue, // Màu nền xanh
                foregroundColor: Colors.white, // Màu chữ trắng
              ),
            ),
          ],
        );
      },
    );
  }

  // Hàm điều hướng tới màn hình thêm sản phẩm
  void _navigateToAddProduct(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) =>  AddProductScreen()), // Điều hướng đến màn hình thêm sản phẩm
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Quản lý Sản phẩm",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        actions: [
          IconButton(
            icon: Icon(Icons.add),
            onPressed: () => _navigateToAddProduct(context), // Điều hướng đến màn hình thêm sản phẩm
          ),
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: StreamBuilder<QuerySnapshot>(
          stream: FirebaseFirestore.instance.collection('products').snapshots(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return Center(child: CircularProgressIndicator());
            }

            if (snapshot.hasError) {
              return Center(child: Text('Có lỗi xảy ra!'));
            }

            if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
              return Center(child: Text('Không có sản phẩm nào.'));
            }

            final products = snapshot.data!.docs;

            return ListView.builder(
              itemCount: products.length,
              itemBuilder: (context, index) {
                var product = products[index];
                String productId = product.id;  // Lấy ID của sản phẩm
                String productName = product['productName'] ?? 'Tên sản phẩm';
                String createdAt = product['createdAt'] ?? 'Ngày tạo';
                List<dynamic> productImages = product['productImages'] ?? [];
                String deliveryTime = product['deliveryTime'] ?? 'Thời gian giao hàng';
                String salePrice = product['salePrice'] ?? 'Giá bán';

                return Card(
                  margin: EdgeInsets.symmetric(vertical: 8),
                  child: ListTile(
                    leading: productImages.isNotEmpty
                        ? Image.network(productImages[0], width: 50, height: 50, fit: BoxFit.cover)
                        : Icon(Icons.image, size: 50),
                    title: Text(productName),
                    subtitle: Text('Ngày tạo: $createdAt'),
                    trailing: Row(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        IconButton(
                          icon: Icon(Icons.edit, color: Colors.blue),
                          onPressed: () => _editProduct(
                            context,
                            productId,
                            productName,
                            deliveryTime,
                            salePrice,
                          ), // Chỉnh sửa sản phẩm
                        ),
                        IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () => _deleteProduct(productId), // Xóa sản phẩm
                        ),
                      ],
                    ),
                    onTap: () {
                      // Logic xử lý khi người dùng nhấn vào sản phẩm (nếu cần)
                    },
                  ),
                );
              },
            );
          },
        ),
      ),
    );
  }
}
