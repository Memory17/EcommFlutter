import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:intl/intl.dart';

class AddProductScreen extends StatefulWidget {
  @override
  _AddProductScreenState createState() => _AddProductScreenState();
}

class _AddProductScreenState extends State<AddProductScreen> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController _productNameController = TextEditingController();
  final TextEditingController _categoryIdController = TextEditingController();
  final TextEditingController _categoryNameController = TextEditingController();
  final TextEditingController _deliveryTimeController = TextEditingController();
  final TextEditingController _fullPriceController = TextEditingController();
  final TextEditingController _productDescriptionController = TextEditingController();
  final TextEditingController _salePriceController = TextEditingController();

  bool _isSale = false;

  List<String> _productImages = ['', '', ''];  // Placeholder for product images

  Future<void> _addProduct() async {
    try {
      // Đặt thời gian tạo và cập nhật hiện tại
      String createdAt = DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now());
      String updatedAt = createdAt;  // Thời gian tạo và cập nhật giống nhau lúc này

      // Thêm sản phẩm vào Firestore
      DocumentReference newProductRef = await FirebaseFirestore.instance.collection('products').add({
        'categoryId': _categoryIdController.text,
        'categoryName': _categoryNameController.text,
        'createdAt': createdAt,
        'deliveryTime': _deliveryTimeController.text,
        'fullPrice': _fullPriceController.text,
        'isSale': _isSale,
        'productDescription': _productDescriptionController.text,
        'productImages': _productImages,
        'productName': _productNameController.text,
        'salePrice': _salePriceController.text,
        'updatedAt': updatedAt,
      });

      // Cập nhật `productId` với `documentId` của tài liệu
      await newProductRef.update({
        'productId': newProductRef.id, // Gán documentId vào trường productId
        'updatedAt': DateFormat('yyyy-MM-dd HH:mm:ss').format(DateTime.now()),  // Cập nhật thời gian hiện tại
      });

      // Sau khi thêm sản phẩm, chuyển hướng về màn hình danh sách sản phẩm
      Navigator.pop(context);
    } catch (e) {
      print("Lỗi khi thêm sản phẩm: $e");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Thêm Sản phẩm"),
        backgroundColor: Colors.blue,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _formKey,
          child: SingleChildScrollView(
            child: Column(
              children: [
                TextFormField(
                  controller: _productNameController,
                  decoration: InputDecoration(labelText: "Tên sản phẩm"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập tên sản phẩm";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryIdController,
                  decoration: InputDecoration(labelText: "Mã danh mục"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mã danh mục";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _categoryNameController,
                  decoration: InputDecoration(labelText: "Tên danh mục"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập tên danh mục";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _deliveryTimeController,
                  decoration: InputDecoration(labelText: "Thời gian giao hàng"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập thời gian giao hàng";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _fullPriceController,
                  decoration: InputDecoration(labelText: "Giá đầy đủ"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập giá đầy đủ";
                    }
                    return null;
                  },
                ),
                SwitchListTile(
                  title: Text("Có giảm giá"),
                  value: _isSale,
                  onChanged: (bool value) {
                    setState(() {
                      _isSale = value;
                    });
                  },
                ),
                TextFormField(
                  controller: _productDescriptionController,
                  decoration: InputDecoration(labelText: "Mô tả sản phẩm"),
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập mô tả sản phẩm";
                    }
                    return null;
                  },
                ),
                TextFormField(
                  controller: _salePriceController,
                  decoration: InputDecoration(labelText: "Giá Sale"),
                  keyboardType: TextInputType.number,
                  validator: (value) {
                    if (value == null || value.isEmpty) {
                      return "Vui lòng nhập giá Sale";
                    }
                    return null;
                  },
                ),
                // Các trường nhập liệu cho hình ảnh sản phẩm
                TextFormField(
                  decoration: InputDecoration(labelText: "Hình ảnh sản phẩm 1 (URL)"),
                  onChanged: (value) {
                    _productImages[0] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Hình ảnh sản phẩm 2 (URL)"),
                  onChanged: (value) {
                    _productImages[1] = value;
                  },
                ),
                TextFormField(
                  decoration: InputDecoration(labelText: "Hình ảnh sản phẩm 3 (URL)"),
                  onChanged: (value) {
                    _productImages[2] = value;
                  },
                ),
                SizedBox(height: 20),
                ElevatedButton(
                  onPressed: () {
                    if (_formKey.currentState!.validate()) {
                      _addProduct();
                    }
                  },
                  style: ButtonStyle(
                    backgroundColor: MaterialStateProperty.all(Colors.blue),  // Màu nền của nút
                    foregroundColor: MaterialStateProperty.all(Colors.white),
                  ),
                  child: Text("Thêm Sản phẩm"),
                ),

              ],
            ),
          ),
        ),
      ),
    );
  }
}
