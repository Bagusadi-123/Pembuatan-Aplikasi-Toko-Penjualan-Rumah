// lib/services/notification_service.dart
import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';

class NotificationItem {
  final String id;
  final String title;
  final String message;
  final DateTime timestamp;
  bool isRead;

  NotificationItem({
    required this.id,
    required this.title,
    required this.message,
    required this.timestamp,
    this.isRead = false,
  });

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'message': message,
      'timestamp': timestamp.toIso8601String(),
      'isRead': isRead,
    };
  }

  factory NotificationItem.fromJson(Map<String, dynamic> json) {
    return NotificationItem(
      id: json['id'],
      title: json['title'],
      message: json['message'],
      timestamp: DateTime.parse(json['timestamp']),
      isRead: json['isRead'] ?? false,
    );
  }
}

class NotificationService {
  // Ganti dengan URL server Anda
  static const String _baseUrl = 'http://localhost:3000'; 

  // TAMBAHKAN: Callback untuk memberi tahu HomePage
  static VoidCallback? onNotificationAdded;

  Future<bool> addNotificationWithFeedback({
    required BuildContext context,
    required String title,
    required String message,
  }) async {
    try {
      final response = await http.post(
        Uri.parse('$_baseUrl/notifications'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({'title': title, 'message': message}),
      );

      if (response.statusCode == 201) { // 201 = Created
         // PANGGIL CALLBACK setelah notifikasi berhasil ditambahkan
        onNotificationAdded?.call();
        
        if (context.mounted) {
          ScaffoldMessenger.of(context).showSnackBar(
            const SnackBar(content: Text('Notifikasi berhasil dikirim!'), backgroundColor: Colors.green),
          );
        }
        return true;
      } else {
        throw Exception('Gagal menambah notifikasi: ${response.body}');
      }
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal mengirim notifikasi: $e'), backgroundColor: Colors.red),
        );
      }
      return false;
    }
  }

  Future<List<NotificationItem>> getNotifications() async {
    try {
      final response = await http.get(Uri.parse('$_baseUrl/notifications'));
      if (response.statusCode == 200) { // 200 = OK
        final List<dynamic> jsonList = jsonDecode(response.body);
        return jsonList.map((json) => NotificationItem.fromJson(json)).toList();
      } else {
        throw Exception('Gagal memuat notifikasi');
      }
    } catch (e) {
      print("Error fetching notifications: $e");
      return [];
    }
  }

  Future<int> getUnreadCountWithFeedback({required BuildContext context}) async {
    try {
      final notifications = await getNotifications();
      final count = notifications.where((notification) => !notification.isRead).length;
      print('DEBUG: Jumlah notifikasi belum dibaca: $count');
      return count;
    } catch (e) {
      if (context.mounted) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(content: Text('Gagal membaca notifikasi: $e'), backgroundColor: Colors.red),
        );
      }
      return 0;
    }
  }

  Future<void> markAllAsRead() async {
    final url = Uri.parse('$_baseUrl/notifications/read-all');
    await http.put(url);
  }
}