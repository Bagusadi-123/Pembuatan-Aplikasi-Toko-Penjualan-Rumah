import 'package:flutter/material.dart';
import 'package:my_project/models/rumah_turunan.dart';
import 'package:my_project/pages/detail_rumah.dart';
import 'package:my_project/pages/pembelian_page.dart';

import '../models/rumah.dart';

class RumahCard extends StatelessWidget {
  final Rumah rumah;
  final RumahTinggal? rumahTinggal;

  const RumahCard({super.key, required this.rumah, required this.rumahTinggal});

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 3,
      margin: const EdgeInsets.only(bottom: 16),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Gambar rumah
          ClipRRect(
            borderRadius: const BorderRadius.vertical(top: Radius.circular(10)),
            child: Image.asset(
              rumah.gambar,
              height: 180,
              width: double.infinity,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) {
                return Container(
                  height: 180,
                  color: Colors.grey[300],
                  child: const Icon(Icons.home, size: 80, color: Colors.grey),
                );
              },
            ),
          ),

          // Detail rumah
          Padding(
            padding: const EdgeInsets.all(16),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Tipe dan harga (menggunakan polymorphism)
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      rumah.tipe,
                      style: const TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    Text(
                      'Rp ${rumah.harga.toString()}',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                  ],
                ),

                const SizedBox(height: 8),

                // Info rumah (menggunakan polymorphism)
                Text(rumah.infoRumah(), style: const TextStyle(fontSize: 14)),

                const SizedBox(height: 8),

                // Alamat
                Text(
                  rumah.alamat,
                  style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                ),

                const SizedBox(height: 12),

                // Harga per meter (menggunakan method dari kelas induk)
                Text(
                  'Harga per m²: Rp ${rumah.hitungHargaPerMeter().toStringAsFixed(0)}',
                  style: TextStyle(
                    fontSize: 12,
                    color: Colors.grey[700],
                    fontStyle: FontStyle.italic,
                  ),
                ),

                const SizedBox(height: 12),

                // Tombol aksi
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    TextButton(
                      onPressed: () {
                        if (rumah is RumahTinggal) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRumah(
                                rumah: rumah,
                                rumahTinggal: rumah as RumahTinggal,
                              ),
                            ),
                          );
                        } else {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => DetailRumah(rumah: rumah),
                            ),
                          );
                        }
                      },
                      child: const Text('Detail'),
                    ),
                    const SizedBox(width: 8),
                    ElevatedButton(
                      onPressed: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(builder: (context) => Pembelian()),
                        );
                      },
                      child: const Text('Beli'),
                    ),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
