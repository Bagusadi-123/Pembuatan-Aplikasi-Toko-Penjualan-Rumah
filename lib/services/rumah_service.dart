// services/rumah_service.dart
import '../models/rumah.dart';
import '../models/rumah_turunan.dart';

class RumahService {
  // Menggunakan polymorphism - list bisa berisi berbagai jenis rumah
  List<Rumah> _daftarRumah = [];

  List<Rumah> get daftarRumah => _daftarRumah;

  // Inisialisasi data dummy
  void inisialisasiData() {
    _daftarRumah = [
      RumahTinggal(
        id: 'RT001',
        jenisRumah: 'Rumah Minimalis \n',
        jenisRumah1: 'Rumah Minimalis',
        luasTanah: 120,
        luasBangunan: 90,
        jumlahKamarTidur: 3,
        jumlahKamarMandi: 2,
        harga: 750000000,
        alamat: 'Jl. Melati No. 10, Jakarta',
        gambar: 'assets/images/gambar-rumah.jpg',
        halamanBelakang: true,
        garasi: true,
      ),
      RumahTinggal(
        id: 'RT002',
        jenisRumah: 'Rumah Modern \n',
        jenisRumah1: 'Rumah Modern',
        luasTanah: 150,
        luasBangunan: 110,
        jumlahKamarTidur: 4,
        jumlahKamarMandi: 3,
        harga: 950000000,
        alamat: 'Jl. Anggrek No. 5, Bandung',
        gambar: 'assets/images/gambar-rumah2.jpg',
        halamanBelakang: true,
        garasi: false,
      ),
      RumahKomersial(
        id: 'RK001',
        jenisRumah: '',
        jenisRumah1: 'Rumah Modern',
        luasTanah: 200,
        luasBangunan: 180,
        jumlahKamarTidur: 2,
        jumlahKamarMandi: 2,
        harga: 1500000000,
        alamat: 'Jl. Sudirman No. 25, Surabaya',
        gambar: 'assets/images/gambar_rumah3.png',
        jenisUsaha: 'Ruko',
        jumlahLantai: 3,
      ),
      RumahKomersial(
        id: 'RK002',
        jenisRumah: '',
        jenisRumah1: 'Rumah Modern',
        luasTanah: 300,
        luasBangunan: 250,
        jumlahKamarTidur: 4,
        jumlahKamarMandi: 3,
        harga: 2500000000,
        alamat: 'Jl. Gatot Subroto No. 15, Jakarta',
        gambar: 'assets/images/gambar-rumah4.png',
        jenisUsaha: 'Kantor',
        jumlahLantai: 4,
      ),
    ];
  }

  // Method untuk mencari rumah berdasarkan tipe (polymorphism)
  List<Rumah> cariRumahBerdasarkanTipe(String tipe) {
    return _daftarRumah.where((rumah) => rumah.tipe == tipe).toList();
  }
}
