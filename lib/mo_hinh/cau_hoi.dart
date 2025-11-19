class CauHoi {
  final String cauHoi;
  final List<String> luaChon;
  final int dapAn;

  CauHoi({
    required this.cauHoi,
    required this.luaChon,
    required this.dapAn,
  });

  factory CauHoi.fromJson(Map<String, dynamic> json) {
    return CauHoi(
      cauHoi: json['cauhoi'],
      luaChon: List<String>.from(json['luachon']),
      dapAn: json['dapan'],
    );
  }
}
