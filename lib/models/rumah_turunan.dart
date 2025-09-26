// models/rumah_turunan.dart
import 'rumah.dart';

// Kelas turunan untuk rumah tinggal
class RumahTinggal extends Rumah {
  bool _halamanBelakang;
  bool _garasi;

  RumahTinggal({
    required String id,
    required String jenisRumah,
    required String jenisRumah1,
    required double luasTanah,
    required double luasBangunan,
    required int jumlahKamarTidur,
    required int jumlahKamarMandi,
    required int harga,
    required String alamat,
    required String gambar,
    required bool halamanBelakang,
    required bool garasi,
  }) : _halamanBelakang = halamanBelakang,
       _garasi = garasi,
       super(
         id: id,
         jenisRumah: jenisRumah,
         jenisRumah1: jenisRumah1,
         tipe: 'Rumah Tinggal',
         luasTanah: luasTanah,
         luasBangunan: luasBangunan,
         jumlahKamarTidur: jumlahKamarTidur,
         jumlahKamarMandi: jumlahKamarMandi,
         harga: harga,
         alamat: alamat,
         gambar: gambar,
       );

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
  String _jenisUsaha;
  int _jumlahLantai;

  RumahKomersial({
    required String id,
    required String jenisRumah,
    required String jenisRumah1,
    required double luasTanah,
    required double luasBangunan,
    required int jumlahKamarTidur,
    required int jumlahKamarMandi,
    required int harga,
    required String alamat,
    required String gambar,
    required String jenisUsaha,
    required int jumlahLantai,
  }) : _jenisUsaha = jenisUsaha,
       _jumlahLantai = jumlahLantai,
       super(
         id: id,
         jenisRumah: jenisRumah,
         jenisRumah1: jenisRumah1,
         tipe: 'Rumah Komersial',
         luasTanah: luasTanah,
         luasBangunan: luasBangunan,
         jumlahKamarTidur: jumlahKamarTidur,
         jumlahKamarMandi: jumlahKamarMandi,
         harga: harga,
         alamat: alamat,
         gambar: gambar,
       );

  // Getter tambahan
  String get jenisUsaha => _jenisUsaha;
  int get jumlahLantai => _jumlahLantai;

  // Override method infoRumah (polymorphism)
  @override
  String infoRumah() {
    return '${super.infoRumah()} - Usaha: $_jenisUsaha \n - $_jumlahLantai Lantai';
  }
}
