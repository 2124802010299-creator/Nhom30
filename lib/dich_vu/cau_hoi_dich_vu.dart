import 'dart:convert';
import 'package:flutter/services.dart';
import '../mo_hinh/cau_hoi.dart';

class CauHoiDichVu {
  static Future<List<CauHoi>> taiCauHoi() async {
    final String data = await rootBundle.loadString('assets/cau_hoi.json');
    final List<dynamic> jsonResult = json.decode(data);
    return jsonResult.map((e) => CauHoi.fromJson(e)).toList();
  }
}
