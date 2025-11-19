import 'package:flutter/material.dart';
import 'man_hinh/trang_chu.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Ứng dụng Quiz",
      debugShowCheckedModeBanner: false,
      home: TrangChu(),
    );
  }
}
