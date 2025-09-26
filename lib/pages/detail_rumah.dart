// pages/detail_rumah.dart
import 'package:flutter/material.dart';
import 'package:my_project/models/rumah.dart';
import 'package:my_project/models/rumah_turunan.dart';

class DetailRumah extends StatelessWidget {
  final Rumah rumah;
  final RumahTinggal? rumahTinggal; // Ubah menjadi nullable

  const DetailRumah({Key? key, required this.rumah, this.rumahTinggal})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Detail Rumah"), backgroundColor: Colors.blue),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Gambar rumah
            Image.asset(
              rumah.gambar,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 250,
                  color: Colors.grey[300],
                  child: const Icon(Icons.home, size: 100, color: Colors.grey),
                );
              },
            ),

            // Detail informasi
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // ID dan Tipe
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        "ID: ${rumah.id}",
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 8,
                          vertical: 4,
                        ),
                        decoration: BoxDecoration(
                          color: Colors.blue[100],
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Text(
                          rumah.jenisRumah1,
                          style: TextStyle(
                            color: Colors.blue[800],
                            fontWeight: FontWeight.bold,
                            fontSize: 16,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 16),

                  // Harga
                  Text(
                    "Harga Rumah",
                    style: const TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: Color.fromARGB(255, 0, 0, 0),
                    ),
                  ),
                  const SizedBox(height: 8),

                  Text(
                    "Rp ${rumah.harga.toString()}",
                    style: const TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.blue,
                    ),
                  ),

                  const SizedBox(height: 8),

                  // Harga per meter
                  Text(
                    "Rp ${rumah.hitungHargaPerMeter().toStringAsFixed(0)} / m²",
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  const SizedBox(height: 20),

                  // Alamat
                  const Text(
                    "Alamat",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 8),
                  Text(rumah.alamat, style: const TextStyle(fontSize: 16)),

                  const SizedBox(height: 20),

                  // Informasi Detail
                  const Text(
                    "Informasi Detail",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 12),

                  // Grid untuk informasi detail
                  GridView.count(
                    crossAxisCount: 3,
                    crossAxisSpacing: 8,
                    mainAxisSpacing: 8,
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    children: [
                      _buildInfoCard(
                        "Luas Tanah",
                        "${rumah.luasTanah} m²",
                        Icons.landscape,
                      ),
                      _buildInfoCard(
                        "Luas Bangunan",
                        "${rumah.luasBangunan} m²",
                        Icons.home,
                      ),
                      _buildInfoCard(
                        "Kamar Tidur",
                        "${rumah.jumlahKamarTidur}",
                        Icons.bed,
                      ),
                      _buildInfoCard(
                        "Kamar Mandi",
                        "${rumah.jumlahKamarMandi}",
                        Icons.bathtub,
                      ),
                      if (rumah.tipe == 'Rumah Tinggal' && rumahTinggal != null)
                        _buildInfoCard(
                          "Halaman Belakang",
                          rumahTinggal!.halamanBelakang ? "Ya" : "Tidak",
                          Icons.yard, // Ikon yang lebih sesuai untuk halaman
                        ),
                      if (rumah.tipe == 'Rumah Tinggal' && rumahTinggal != null)
                        _buildInfoCard(
                          "Garasi",
                          rumahTinggal!.garasi ? "Ya" : "Tidak",
                          Icons.garage,
                        ),
                      if (rumah.tipe == 'Rumah Komersial')
                        _buildInfoCard(
                          "jenis Usaha",
                          (rumah as dynamic).jenisUsaha,
                          Icons.business,
                        ),
                      if (rumah.tipe == 'Rumah Komersial')
                        _buildInfoCard(
                          "jumlah Lantai",
                          "${(rumah as dynamic).jumlahLantai}",
                          Icons.layers,
                        ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // Tombol aksi
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Menghubungi agen untuk ${rumah.id}',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.phone),
                        label: const Text("Hubungi Agen"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                      ElevatedButton.icon(
                        onPressed: () {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(
                                'Menambahkan ${rumah.id} ke favorit',
                              ),
                            ),
                          );
                        },
                        icon: const Icon(Icons.favorite_border),
                        label: const Text("Favorit"),
                        style: ElevatedButton.styleFrom(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 20,
                            vertical: 12,
                          ),
                        ),
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoCard(String title, String value, IconData icon) {
    return Card(
      elevation: 3,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(icon, size: 30, color: Colors.blue),
            const SizedBox(height: 8),
            Text(
              title,
              style: const TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 4),
            Text(
              value,
              style: const TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
