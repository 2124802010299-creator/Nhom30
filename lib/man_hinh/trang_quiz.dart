import 'dart:async';
import 'package:flutter/material.dart';
import '../mo_hinh/cau_hoi.dart';
import '../dich_vu/cau_hoi_dich_vu.dart';
import '../theme/colors.dart';
import 'trang_ket_qua.dart';
import 'package:audioplayers/audioplayers.dart';

class TrangQuiz extends StatefulWidget {
  const TrangQuiz({super.key});

  @override
  State<TrangQuiz> createState() => _TrangQuizState();
}

class _TrangQuizState extends State<TrangQuiz> {
  List<CauHoi> danhSachCauHoi = [];
  int chiSoHienTai = 0;
  int diem = 0;

  // TIMER
  int thoiGian = 15;
  Timer? demNguoc;
  double tienTrinh = 1.0;

  // Âm thanh
  final player = AudioPlayer();

  @override
  void initState() {
    super.initState();
    taiDuLieu();
  }

  void taiDuLieu() async {
    danhSachCauHoi = await CauHoiDichVu.taiCauHoi();
    setState(() {});
    batDauDemNguoc();
  }

  // ======================
  // 🔥 HÀM TIMER
  // ======================
  void batDauDemNguoc() {
    thoiGian = 15;
    tienTrinh = 1.0;

    demNguoc?.cancel();

    demNguoc = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        thoiGian--;
        tienTrinh = thoiGian / 15;

        if (thoiGian <= 0) {
          demNguoc?.cancel();
          chuyenCau();
        }
      });
    });
  }

  // ======================
  // 🔥 CHUYỂN CÂU
  // ======================
  void chuyenCau() {
    if (chiSoHienTai < danhSachCauHoi.length - 1) {
      setState(() {
        chiSoHienTai++;
      });
      batDauDemNguoc();
    } else {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(
          builder: (_) => TrangKetQua(
            diem: diem,
            tongSoCau: danhSachCauHoi.length,
          ),
        ),
      );
    }
  }

  // ======================
  // 🔥 KHI CHỌN ĐÁP ÁN
  // ======================
  Future<void> kiemTraDapAn(int index) async {
    demNguoc?.cancel();

    if (index == danhSachCauHoi[chiSoHienTai].dapAn) {
      diem++;
      await player.play(AssetSource("am_thanh/dung.mp3"));
    } else {
      await player.play(AssetSource("am_thanh/sai.mp3"));
    }

    chuyenCau();
  }

  @override
  Widget build(BuildContext context) {
    if (danhSachCauHoi.isEmpty) {
      return const Scaffold(
        body: Center(child: CircularProgressIndicator()),
      );
    }

    final cau = danhSachCauHoi[chiSoHienTai];

    return Scaffold(
      appBar: AppBar(
        title: const Text("Ứng dụng Quiz"),
        backgroundColor: AppColors.primary,
      ),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            // =====================
            // 🔥 THANH TIẾN TRÌNH
            // =====================
            LinearProgressIndicator(
              value: tienTrinh,
              backgroundColor: Colors.grey[300],
              color: thoiGian > 10
                  ? Colors.green
                  : thoiGian > 5
                  ? Colors.orange
                  : Colors.red,
              minHeight: 10,
            ),

            const SizedBox(height: 20),

            // =====================
            // 🔥 HIỂN THỊ CÂU HỎI
            // =====================
            Container(
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: AppColors.card,
                borderRadius: BorderRadius.circular(14),
              ),
              child: Text(
                cau.cauHoi,
                style: const TextStyle(
                    fontSize: 22, fontWeight: FontWeight.bold),
              ),
            ),

            const SizedBox(height: 30),

            // =====================
            // 🔥 CÁC ĐÁP ÁN
            // =====================
            ...List.generate(cau.luaChon.length, (i) {
              return Container(
                margin: const EdgeInsets.only(bottom: 12),
                width: double.infinity,
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.white,
                    foregroundColor: AppColors.primary,
                    padding:
                    const EdgeInsets.symmetric(vertical: 14),
                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(12),
                      side: const BorderSide(
                        color: AppColors.primary,
                      ),
                    ),
                  ),
                  onPressed: () => kiemTraDapAn(i),
                  child: Text(
                    cau.luaChon[i],
                    style: const TextStyle(fontSize: 18),
                  ),
                ),
              );
            }),
          ],
        ),
      ),
    );
  }
}
