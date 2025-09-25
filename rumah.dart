// models/rumah.dart
class Rumah {
  String _id;
  String _jenisRumah;
  String _jenisRumah1;
  String _tipe;
  double _luasTanah;
  double _luasBangunan;
  int _jumlahKamarTidur;
  int _jumlahKamarMandi;
  int _harga;
  String _alamat;
  String _gambar;

  Rumah({
    required String id,
    required String jenisRumah,
    required String jenisRumah1,
    required String tipe,
    required double luasTanah,
    required double luasBangunan,
    required int jumlahKamarTidur,
    required int jumlahKamarMandi,
    required int harga,
    required String alamat,
    required String gambar,
  }) : _id = id,
       _jenisRumah = jenisRumah,
       _jenisRumah1 = jenisRumah1,
       _tipe = tipe,
       _luasTanah = luasTanah,
       _luasBangunan = luasBangunan,
       _jumlahKamarTidur = jumlahKamarTidur,
       _jumlahKamarMandi = jumlahKamarMandi,
       _harga = harga,
       _alamat = alamat,
       _gambar = gambar;

  // Getter untuk encapsulation
  String get id => _id;
  String get jenisRumah => _jenisRumah;
  String get jenisRumah1 => _jenisRumah1;
  String get tipe => _tipe;
  double get luasTanah => _luasTanah;
  double get luasBangunan => _luasBangunan;
  int get jumlahKamarTidur => _jumlahKamarTidur;
  int get jumlahKamarMandi => _jumlahKamarMandi;
  int get harga => _harga;
  String get alamat => _alamat;
  String get gambar => _gambar;

  // Method untuk menghitung harga per meter
  double hitungHargaPerMeter() {
    return _harga / _luasBangunan;
  }

  // Method untuk menampilkan informasi rumah
  String infoRumah() {
    return '$_jenisRumah - Luas: $_luasBangunan  m² \n';
  }
}
