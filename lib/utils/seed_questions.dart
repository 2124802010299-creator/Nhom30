import 'package:cloud_firestore/cloud_firestore.dart';

class SeedQuestions {
  static final _ref =
  FirebaseFirestore.instance.collection('questions');

  static Future<void> _clear(String category) async {
    final snap = await _ref.where('category', isEqualTo: category).get();
    for (final d in snap.docs) {
      await d.reference.delete();
    }
  }

  static Future<void> _seed(
      String category, List<Map<String, dynamic>> data) async {
    await _clear(category);
    for (final q in data) {
      await _ref.add(q);
    }
  }

  // ================== CONG_NGHE ==================
  static Future<void> seedCongNghe() async {
    final data = [
      {
        "category": "cong_nghe",
        "content": "Flutter sử dụng ngôn ngữ lập trình nào?",
        "options": ["Java", "Kotlin", "Dart", "Swift"],
        "correctIndex": 2
      },
      {
        "category": "cong_nghe",
        "content": "Firebase là dịch vụ của công ty nào?",
        "options": ["Google", "Meta", "Amazon", "Microsoft"],
        "correctIndex": 0
      },
      {
        "category": "cong_nghe",
        "content": "Flutter có thể phát triển ứng dụng cho nền tảng nào?",
        "options": ["Android", "iOS", "Web", "Tất cả"],
        "correctIndex": 3
      },
      {
        "category": "cong_nghe",
        "content": "Hot Reload trong Flutter dùng để làm gì?",
        "options": [
          "Khởi động lại app",
          "Cập nhật UI nhanh",
          "Xóa cache",
          "Build release"
        ],
        "correctIndex": 1
      },
      {
        "category": "cong_nghe",
        "content": "IDE phổ biến để lập trình Flutter là gì?",
        "options": ["VS Code", "Eclipse", "NetBeans", "Xcode"],
        "correctIndex": 0
      },
      {
        "category": "cong_nghe",
        "content": "Widget nào dùng cho UI có trạng thái thay đổi?",
        "options": [
          "StatelessWidget",
          "StatefulWidget",
          "InheritedWidget",
          "Container"
        ],
        "correctIndex": 1
      },
      {
        "category": "cong_nghe",
        "content": "Firebase Authentication dùng để làm gì?",
        "options": [
          "Lưu ảnh",
          "Xác thực người dùng",
          "Lưu file",
          "Phân tích dữ liệu"
        ],
        "correctIndex": 1
      },
      {
        "category": "cong_nghe",
        "content": "API là viết tắt của cụm từ nào?",
        "options": [
          "Application Programming Interface",
          "Advanced Program Internet",
          "Applied Program Interface",
          "Application Process Integration"
        ],
        "correctIndex": 0
      },
      {
        "category": "cong_nghe",
        "content": "Git dùng để làm gì?",
        "options": [
          "Thiết kế UI",
          "Quản lý mã nguồn",
          "Viết tài liệu",
          "Deploy server"
        ],
        "correctIndex": 1
      },
      {
        "category": "cong_nghe",
        "content": "HTTP là giao thức thuộc tầng nào?",
        "options": [
          "Tầng mạng",
          "Tầng ứng dụng",
          "Tầng vật lý",
          "Tầng liên kết"
        ],
        "correctIndex": 1
      },
    ];

    await _seed("cong_nghe", data);
  }

// ================== TOAN_HOC ==================
  static Future<void> seedToanHoc() async {
    final data = [
      {
        "category": "toan_hoc",
        "content": "2 + 3 = ?",
        "options": ["4", "5", "6", "7"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "5 × 6 = ?",
        "options": ["30", "25", "35", "20"],
        "correctIndex": 0
      },
      {
        "category": "toan_hoc",
        "content": "12 : 3 = ?",
        "options": ["2", "3", "4", "6"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "10 − 4 = ?",
        "options": ["5", "6", "7", "4"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "Diện tích hình vuông cạnh 4 là?",
        "options": ["8", "12", "16", "20"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "Chu vi hình chữ nhật 3×5 là?",
        "options": ["16", "15", "30", "8"],
        "correctIndex": 0
      },
      {
        "category": "toan_hoc",
        "content": "Số nguyên tố nhỏ nhất là?",
        "options": ["0", "1", "2", "3"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "7² = ?",
        "options": ["14", "21", "49", "28"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "√16 = ?",
        "options": ["2", "4", "6", "8"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "Số nào chia hết cho 2?",
        "options": ["3", "5", "7", "8"],
        "correctIndex": 3
      },
      {
        "category": "toan_hoc",
        "content": "1/2 + 1/2 = ?",
        "options": ["1", "2", "1/2", "0"],
        "correctIndex": 0
      },
      {
        "category": "toan_hoc",
        "content": "Hình tam giác có bao nhiêu cạnh?",
        "options": ["2", "3", "4", "5"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "15 − 7 = ?",
        "options": ["6", "7", "8", "9"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "9 × 9 = ?",
        "options": ["81", "72", "99", "90"],
        "correctIndex": 0
      },
      {
        "category": "toan_hoc",
        "content": "100 : 10 = ?",
        "options": ["5", "10", "20", "50"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "Số chẵn là số?",
        "options": [
          "Chia hết cho 2",
          "Chia hết cho 3",
          "Lớn hơn 0",
          "Nhỏ hơn 0"
        ],
        "correctIndex": 0
      },
      {
        "category": "toan_hoc",
        "content": "Góc vuông có số đo là?",
        "options": ["45°", "60°", "90°", "120°"],
        "correctIndex": 2
      },
      {
        "category": "toan_hoc",
        "content": "5 + 0 = ?",
        "options": ["0", "5", "10", "1"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "Số nào lớn nhất?",
        "options": ["12", "21", "18", "15"],
        "correctIndex": 1
      },
      {
        "category": "toan_hoc",
        "content": "Hình tròn có bao nhiêu tâm?",
        "options": ["0", "1", "2", "Vô số"],
        "correctIndex": 1
      },
    ];

    await _seed("toan_hoc", data);
  }
// ================== LICH_SU ==================
  static Future<void> seedLichSu() async {
    final data = [
      {
        "category": "lich_su",
        "content": "Chiến thắng Điện Biên Phủ diễn ra năm nào?",
        "options": ["1945", "1954", "1968", "1975"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Ngày Quốc khánh Việt Nam là ngày nào?",
        "options": ["30/4", "2/9", "19/5", "7/5"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Bác Hồ đọc Tuyên ngôn Độc lập tại đâu?",
        "options": [
          "Phủ Chủ tịch",
          "Quảng trường Ba Đình",
          "Nhà hát Lớn",
          "Hồ Gươm"
        ],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Cuộc khởi nghĩa Hai Bà Trưng nổ ra vào năm nào?",
        "options": ["40", "248", "542", "938"],
        "correctIndex": 0
      },
      {
        "category": "lich_su",
        "content": "Ngô Quyền chiến thắng quân Nam Hán trên sông nào?",
        "options": ["Sông Hồng", "Sông Bạch Đằng", "Sông Đà", "Sông Mã"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Chiến thắng Bạch Đằng năm 938 do ai lãnh đạo?",
        "options": ["Trần Hưng Đạo", "Lý Thường Kiệt", "Ngô Quyền", "Quang Trung"],
        "correctIndex": 2
      },
      {
        "category": "lich_su",
        "content": "Nhà Trần thành lập vào năm nào?",
        "options": ["1009", "1225", "1400", "1428"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Ai là người lãnh đạo phong trào Tây Sơn?",
        "options": [
          "Nguyễn Huệ",
          "Nguyễn Nhạc",
          "Nguyễn Lữ",
          "Cả ba anh em"
        ],
        "correctIndex": 3
      },
      {
        "category": "lich_su",
        "content": "Vua Quang Trung đại phá quân Thanh vào năm nào?",
        "options": ["1785", "1788", "1789", "1792"],
        "correctIndex": 2
      },
      {
        "category": "lich_su",
        "content": "Chiến dịch Hồ Chí Minh toàn thắng năm nào?",
        "options": ["1954", "1968", "1973", "1975"],
        "correctIndex": 3
      },
      {
        "category": "lich_su",
        "content": "Hiệp định Giơ-ne-vơ được ký kết năm nào?",
        "options": ["1946", "1954", "1960", "1973"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Nhà nước Văn Lang do ai đứng đầu?",
        "options": [
          "An Dương Vương",
          "Hùng Vương",
          "Lạc Long Quân",
          "Thục Phán"
        ],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Kinh đô đầu tiên của nước ta là ở đâu?",
        "options": ["Thăng Long", "Cổ Loa", "Hoa Lư", "Phú Xuân"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Lý Thái Tổ dời đô ra Thăng Long năm nào?",
        "options": ["939", "968", "1010", "1225"],
        "correctIndex": 2
      },
      {
        "category": "lich_su",
        "content": "Ba lần kháng chiến chống quân Nguyên – Mông diễn ra dưới triều đại nào?",
        "options": ["Nhà Lý", "Nhà Trần", "Nhà Hồ", "Nhà Lê"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Ai là tác giả Bình Ngô đại cáo?",
        "options": [
          "Nguyễn Trãi",
          "Lê Lợi",
          "Lý Thường Kiệt",
          "Trần Hưng Đạo"
        ],
        "correctIndex": 0
      },
      {
        "category": "lich_su",
        "content": "Khởi nghĩa Lam Sơn bùng nổ năm nào?",
        "options": ["1407", "1418", "1427", "1428"],
        "correctIndex": 1
      },
      {
        "category": "lich_su",
        "content": "Vị vua đầu tiên của nhà Nguyễn là ai?",
        "options": [
          "Gia Long",
          "Minh Mạng",
          "Thiệu Trị",
          "Tự Đức"
        ],
        "correctIndex": 0
      },
      {
        "category": "lich_su",
        "content": "Cách mạng tháng Tám thành công năm nào?",
        "options": ["1930", "1941", "1945", "1954"],
        "correctIndex": 2
      },
      {
        "category": "lich_su",
        "content": "Ai là Chủ tịch nước đầu tiên của Việt Nam?",
        "options": [
          "Tôn Đức Thắng",
          "Hồ Chí Minh",
          "Phạm Văn Đồng",
          "Võ Nguyên Giáp"
        ],
        "correctIndex": 1
      },
    ];

    await _seed("lich_su", data);
  }

// ================== TAM_LINH ==================
  static Future<void> seedTamLinh() async {
    final data = [
      {
        "category": "tam_linh",
        "content": "Phong thủy chủ yếu nghiên cứu về điều gì?",
        "options": [
          "Âm nhạc",
          "Sự hài hòa giữa con người và môi trường",
          "Toán học",
          "Y học"
        ],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Trong ngũ hành, Kim sinh ra hành nào?",
        "options": ["Thủy", "Mộc", "Hỏa", "Thổ"],
        "correctIndex": 0
      },
      {
        "category": "tam_linh",
        "content": "Ngũ hành gồm bao nhiêu yếu tố?",
        "options": ["3", "4", "5", "6"],
        "correctIndex": 2
      },
      {
        "category": "tam_linh",
        "content": "Yếu tố nào KHÔNG thuộc ngũ hành?",
        "options": ["Kim", "Mộc", "Phong", "Thủy"],
        "correctIndex": 2
      },
      {
        "category": "tam_linh",
        "content": "Trong phong thủy, hướng nào thường được coi là hướng tốt?",
        "options": [
          "Hướng hợp mệnh gia chủ",
          "Hướng Tây",
          "Hướng ngẫu nhiên",
          "Hướng không có ánh sáng"
        ],
        "correctIndex": 0
      },
      {
        "category": "tam_linh",
        "content": "Âm dương thể hiện điều gì?",
        "options": [
          "Hai mặt đối lập nhưng bổ sung cho nhau",
          "Chỉ điều xấu",
          "Chỉ điều tốt",
          "Không liên quan nhau"
        ],
        "correctIndex": 0
      },
      {
        "category": "tam_linh",
        "content": "Trong ngũ hành, Mộc sinh ra hành nào?",
        "options": ["Kim", "Hỏa", "Thủy", "Thổ"],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Phong thủy có nguồn gốc chủ yếu từ đâu?",
        "options": ["Ấn Độ", "Trung Quốc", "Việt Nam", "Nhật Bản"],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Con số nào thường được xem là con số may mắn?",
        "options": ["4", "7", "8", "13"],
        "correctIndex": 2
      },
      {
        "category": "tam_linh",
        "content": "Số 4 trong quan niệm Á Đông thường tượng trưng cho điều gì?",
        "options": [
          "May mắn",
          "Trung lập",
          "Không có ý nghĩa",
          "Không may mắn"
        ],
        "correctIndex": 3
      },
      {
        "category": "tam_linh",
        "content": "Trong ngũ hành, Thủy khắc hành nào?",
        "options": ["Hỏa", "Kim", "Mộc", "Thổ"],
        "correctIndex": 0
      },
      {
        "category": "tam_linh",
        "content": "Màu sắc nào thường gắn với hành Mộc?",
        "options": ["Đỏ", "Xanh lá", "Trắng", "Vàng"],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Trong phong thủy, gương thường được dùng để làm gì?",
        "options": [
          "Trang trí",
          "Phản xạ và điều chỉnh năng lượng",
          "Che chắn ánh sáng",
          "Tạo ảo giác"
        ],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Hành Thổ thường liên quan đến yếu tố nào?",
        "options": ["Nước", "Cây cối", "Đất đai", "Kim loại"],
        "correctIndex": 2
      },
      {
        "category": "tam_linh",
        "content": "Ngũ hành tương sinh có nghĩa là gì?",
        "options": [
          "Các hành hỗ trợ lẫn nhau",
          "Các hành đối kháng nhau",
          "Không liên quan nhau",
          "Chỉ tồn tại một hành"
        ],
        "correctIndex": 0
      },
      {
        "category": "tam_linh",
        "content": "Trong quan niệm dân gian, thắp hương thường mang ý nghĩa gì?",
        "options": [
          "Trang trí",
          "Kết nối tâm linh và tưởng nhớ",
          "Tạo mùi thơm",
          "Xua đuổi côn trùng"
        ],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Hành Kim thường gắn với màu nào?",
        "options": ["Xanh", "Đỏ", "Trắng", "Đen"],
        "correctIndex": 2
      },
      {
        "category": "tam_linh",
        "content": "Trong phong thủy, cây xanh thường mang ý nghĩa gì?",
        "options": [
          "Trang trí đơn thuần",
          "Mang sinh khí và năng lượng tích cực",
          "Chắn gió",
          "Giảm ánh sáng"
        ],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Con số 9 thường tượng trưng cho điều gì?",
        "options": [
          "Kết thúc",
          "May mắn và trường tồn",
          "Xui xẻo",
          "Không ý nghĩa"
        ],
        "correctIndex": 1
      },
      {
        "category": "tam_linh",
        "content": "Phong thủy chủ yếu hướng đến mục tiêu nào?",
        "options": [
          "Làm giàu nhanh",
          "Cân bằng và hài hòa cuộc sống",
          "Dự đoán tương lai",
          "Thay đổi số phận ngay lập tức"
        ],
        "correctIndex": 1
      },
    ];

    await _seed("tam_linh", data);
  }


  static Future<void> seedAll() async {
    await seedCongNghe();
    await seedToanHoc();
    await seedLichSu();
    await seedTamLinh();
  }
}
