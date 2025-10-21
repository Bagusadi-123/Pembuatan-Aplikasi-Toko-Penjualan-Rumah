// models/rumah_turunan.dart
import 'rumah.dart';

// Kelas turunan untuk rumah tinggal
class RumahTinggal extends Rumah {
  final bool _halamanBelakang;
  final bool _garasi;

  RumahTinggal({
    required super.id,
    required super.jenisRumah,
    required super.jenisRumah1,
    required super.luasTanah,
    required super.luasBangunan,
    required super.jumlahKamarTidur,
    required super.jumlahKamarMandi,
    required super.harga,
    required super.alamat,
    required super.gambar,
    required bool halamanBelakang,
    required bool garasi,
  }) : _halamanBelakang = halamanBelakang,
       _garasi = garasi,
       super(tipe: 'Rumah Tinggal');

  // Getter tambahan
  bool get halamanBelakang => _halamanBelakang;
  bool get garasi => _garasi;

  // Override method infoRumah (polymorphism)
  @override
  String infoRumah() {
    String info = super.infoRumah();
    if (_halamanBelakang) info += ' - Halaman Belakang ✓ \n';
    if (_garasi) info += ' - Garasi ✓';
    return info;
  }
}

// Kelas turunan untuk rumah komersial
class RumahKomersial extends Rumah {
  final String _jenisUsaha;
  final int _jumlahLantai;

  RumahKomersial({
    required super.id,
    required super.jenisRumah,
    required super.jenisRumah1,
    required super.luasTanah,
    required super.luasBangunan,
    required super.jumlahKamarTidur,
    required super.jumlahKamarMandi,
    required super.harga,
    required super.alamat,
    required super.gambar,
    required String jenisUsaha,
    required int jumlahLantai,
  }) : _jenisUsaha = jenisUsaha,
       _jumlahLantai = jumlahLantai,
       super(tipe: 'Rumah Komersial');

  // Getter tambahan
  String get jenisUsaha => _jenisUsaha;
  int get jumlahLantai => _jumlahLantai;

  // Override method infoRumah (polymorphism)
  @override
  String infoRumah() {
    return '${super.infoRumah()} - Usaha: $_jenisUsaha \n - $_jumlahLantai Lantai';
  }
}
