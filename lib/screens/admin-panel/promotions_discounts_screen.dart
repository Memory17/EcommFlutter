import 'package:flutter/material.dart';

class PromotionsDiscountsScreen extends StatefulWidget {
  const PromotionsDiscountsScreen({super.key});

  @override
  State<PromotionsDiscountsScreen> createState() => _PromotionsDiscountsScreenState();
}

class _PromotionsDiscountsScreenState extends State<PromotionsDiscountsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Khuyến mãi và Giảm giá",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildPromotionCard(
              "Giảm giá 50% cho sản phẩm điện thoại",
              "Áp dụng cho tất cả các mẫu điện thoại.",
              "Từ 01/12 đến 15/12",
              Colors.green,
            ),
            _buildPromotionCard(
              "Giảm giá 30% cho tai nghe không dây",
              "Khuyến mãi áp dụng cho tất cả các mặt hàng đồ gia dụng.",
              "Từ 10/12 đến 25/12",
              Colors.red,
            ),
            _buildPromotionCard(
              "Giảm giá 20% cho đơn hàng trên 500k",
              "Áp dụng cho tất cả các sản phẩm, không giới hạn loại hàng.",
              "Liên tục trong tháng 12",
              Colors.orange,
            ),
            _buildPromotionCard(
              "Mua 1 tặng 1 sản phẩm phụ kiện",
              "Khuyến mãi mua 1 tặng 1 các sản phẩm phụ kiện điện thoại.",
              "Từ 01/12 đến hết hàng",
              Colors.blue,
            ),
            _buildPromotionCard(
              "Giảm giá 10% cho khách hàng mới",
              "Áp dụng cho tất cả khách hàng lần đầu tiên mua sắm.",
              "Từ 01/12 đến 31/12",
              Colors.purple,
            ),
            _buildPromotionCard(
              "Giảm giá 15% cho nhóm sản phẩm laptop",
              "Áp dụng cho các sản phẩm laptop trong danh mục khuyến mãi.",
              "Từ 01/12 đến hết tháng",
              Colors.cyan,
            ),
            _buildPromotionCard(
              "Ưu đãi sinh nhật - Giảm 20%",
              "Dành cho khách hàng có sinh nhật trong tháng.",
              "Từ 01/12 đến hết tháng",
              Colors.yellow,
            ),
            _buildPromotionCard(
              "Voucher giảm giá 50k cho đơn hàng trên 500k",
              "Sử dụng voucher giảm giá cho các đơn hàng lớn.",
              "Liên tục đến hết năm",
              Colors.green,
            ),
          ],
        ),
      ),
    );
  }

  // Hàm để xây dựng mỗi mục khuyến mãi
  Widget _buildPromotionCard(String title, String description, String period, Color promotionColor) {
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
          leading: Icon(
            Icons.discount,
            size: 40,
            color: promotionColor,
          ),
          title: Text(
            title,
            style: TextStyle(fontSize: 18.0, fontWeight: FontWeight.bold),
          ),
          subtitle: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(description),
              SizedBox(height: 4.0),
              Text(
                "Thời gian: $period",
                style: TextStyle(fontWeight: FontWeight.bold),
              ),
            ],
          ),
          trailing: Icon(Icons.arrow_forward_ios, color: Colors.blue),
        ),
      ),
    );
  }
}
