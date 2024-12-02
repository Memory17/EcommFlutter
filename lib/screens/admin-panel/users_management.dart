import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'sendmail_screen.dart'; // Import màn hình gửi email

class UsersManagementScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Quản lý người dùng'),
        backgroundColor: Colors.blue,
      ),
      body: StreamBuilder<QuerySnapshot>(
        stream: FirebaseFirestore.instance.collection('users').snapshots(),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          }

          if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
            return Center(child: Text('Không có người dùng nào.'));
          }

          return ListView(
            children: snapshot.data!.docs.map((doc) {
              String email = doc['email'];
              String phone = doc['phone'];
              bool isAdmin = doc['isAdmin']; // Lấy giá trị isAdmin từ Firestore

              return Card(
                child: ListTile(
                  leading: CircleAvatar(
                    backgroundColor: Colors.blue,
                    child: Icon(Icons.person, color: Colors.white),
                  ),
                  title: Text(email),
                  subtitle: Text('Số điện thoại: $phone'),
                  trailing: PopupMenuButton<String>(
                    icon: Icon(Icons.more_vert),
                    onSelected: (value) {
                      if (value == 'send_mail') {
                        // Khi người dùng chọn "Gửi mail", điều hướng tới màn hình gửi email
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SendMailScreen(
                              recipientEmail: email, // Truyền email vào màn hình gửi email
                            ),
                          ),
                        );
                      } else if (value == 'delete') {
                        // Xử lý xóa người dùng
                        if (!isAdmin) {
                          FirebaseFirestore.instance
                              .collection('users')
                              .doc(doc.id)
                              .delete();
                        }
                      }
                    },
                    itemBuilder: (BuildContext context) => [
                      PopupMenuItem(
                        value: 'send_mail',
                        child: Row(
                          children: [
                            Icon(Icons.mail, color: Colors.blue),
                            SizedBox(width: 8),
                            Text('Gửi mail'),
                          ],
                        ),
                      ),
                      PopupMenuItem(
                        value: 'delete',
                        enabled: !isAdmin, // Chỉ bật khi không phải admin
                        child: Row(
                          children: [
                            Icon(Icons.delete, color: isAdmin ? Colors.grey : Colors.red),
                            SizedBox(width: 8),
                            Text('Xóa'),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              );
            }).toList(),
          );
        },
      ),
    );
  }
}
