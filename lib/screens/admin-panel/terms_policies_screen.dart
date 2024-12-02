import 'package:flutter/material.dart';

class TermsPoliciesScreen extends StatelessWidget {
  const TermsPoliciesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.blue,
        title: Text(
          "Điều khoản và Chính sách",
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            _buildSectionTitle("Điều khoản sử dụng"),
            _buildSectionContent(
              "Chúng tôi cung cấp các dịch vụ trực tuyến để bạn có thể tiếp cận và sử dụng sản phẩm của chúng tôi. Việc sử dụng dịch vụ của chúng tôi đồng nghĩa với việc bạn đồng ý với các điều khoản và chính sách dưới đây.",
            ),
            _buildSectionTitle("Chính sách bảo mật"),
            _buildSectionContent(
              "Chúng tôi cam kết bảo vệ quyền riêng tư của bạn. Các thông tin cá nhân mà bạn cung cấp sẽ được bảo mật và sử dụng chỉ để phục vụ mục đích cung cấp dịch vụ.",
            ),
            _buildSectionTitle("Điều khoản thanh toán"),
            _buildSectionContent(
              "Thanh toán sẽ được thực hiện qua các phương thức được hỗ trợ trên nền tảng của chúng tôi. Bạn đồng ý với các khoản phí và phương thức thanh toán khi sử dụng dịch vụ của chúng tôi.",
            ),
            _buildSectionTitle("Chính sách hoàn trả"),
            _buildSectionContent(
              "Nếu bạn không hài lòng với sản phẩm hoặc dịch vụ, bạn có thể yêu cầu hoàn trả theo các điều kiện và quy trình hoàn trả được chúng tôi quy định.",
            ),
            _buildSectionTitle("Điều khoản sử dụng dịch vụ hỗ trợ"),
            _buildSectionContent(
              "Chúng tôi cung cấp dịch vụ hỗ trợ qua các kênh liên hệ được cung cấp. Tuy nhiên, chúng tôi không chịu trách nhiệm đối với các yêu cầu ngoài phạm vi hỗ trợ của chúng tôi.",
            ),
            _buildSectionTitle("Chính sách bảo hành"),
            _buildSectionContent(
              "Các sản phẩm và dịch vụ của chúng tôi đi kèm với chính sách bảo hành. Điều kiện và thời gian bảo hành sẽ được thông báo rõ ràng khi bạn mua sản phẩm.",
            ),
          ],
        ),
      ),
    );
  }

  // Hàm tạo tiêu đề cho mỗi mục
  Widget _buildSectionTitle(String title) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Text(
        title,
        style: TextStyle(
          fontSize: 20.0,
          fontWeight: FontWeight.bold,
          color: Colors.blue,
        ),
      ),
    );
  }

  // Hàm tạo nội dung chi tiết cho mỗi mục
  Widget _buildSectionContent(String content) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 16.0),
      child: Text(
        content,
        style: TextStyle(fontSize: 16.0, color: Colors.black87),
        textAlign: TextAlign.justify,
      ),
    );
  }
}
