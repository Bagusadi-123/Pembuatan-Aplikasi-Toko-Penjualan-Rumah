// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/bloc/website_bloc.dart';
import 'package:my_project/models/rumah_turunan.dart';
import 'package:my_project/pages/profile_page.dart'; // Import halaman profile
import 'package:my_project/pages/rumah_list_page.dart';
import 'package:my_project/services/rumah_service.dart';
import 'package:my_project/widgets/rumah_card.dart';

import '../models/rumah.dart';

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    final RumahService rumahService = RumahService();
    rumahService.inisialisasiData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Penjualan Rumah'),
        automaticallyImplyLeading: false,
        actions: [
          // Tambahkan logo/profile di pojok kanan atas
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: GestureDetector(
              onTap: () {
                // Navigasi ke halaman profile saat diklik
                Navigator.of(context).push(
                  MaterialPageRoute(builder: (context) => const ProfilePage()),
                );
              },
              child: CircleAvatar(
                radius: 20,
                backgroundImage: AssetImage('assets/images/foto_profile.png'),
              ),
            ),
          ),
        ],
      ),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [
              const Color.fromARGB(255, 222, 212, 212),
              const Color.fromARGB(255, 196, 177, 177),
            ],
          ),
        ),
        child: BlocBuilder<LoginBloc, LoginState>(
          builder: (context, state) {
            return SingleChildScrollView(
              child: Padding(
                padding: const EdgeInsets.all(16.0),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Header user (sekarang hanya menampilkan welcome text)
                    _buildUserHeader(state),
                    const SizedBox(height: 40),

                    // Filter tipe rumah
                    _buildFilterSection(context, rumahService),
                    const SizedBox(height: 16),

                    // Daftar rumah
                    _buildRumahList(rumahService.daftarRumah),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }

  Widget _buildUserHeader(LoginState state) {
    return Center(
      child: Column(
        children: [
          ShaderMask(
            shaderCallback: (bounds) => LinearGradient(
              colors: [
                const Color.fromARGB(255, 223, 148, 35),
                const Color.fromARGB(255, 11, 134, 211),
              ],
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
            ).createShader(bounds),

            child: const Text(
              'Selamat Datang di Toko Properti!',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.white, // Warna ini akan ditimpa oleh gradient
              ),
            ),
          ),
          const SizedBox(height: 10),
        ],
      ),
    );
  }

  Widget _buildFilterSection(BuildContext context, RumahService rumahService) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Filter Tipe Properti',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 8),
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  164,
                  58,
                  92,
                  119,
                ).withValues(alpha: 0.5), // 50% transparan
                foregroundColor: Colors.white, // Warna teks
                elevation: 2, // Mengurangi bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Membuat sudut lebih bulat
                ),
              ),
              onPressed: () {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(builder: (context) => const HomePage()),
                );
              },
              child: const Text('Semua'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  164,
                  58,
                  92,
                  119,
                ).withValues(alpha: 0.5), // 50% transparan
                foregroundColor: Colors.white, // Warna teks
                elevation: 2, // Mengurangi bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Membuat sudut lebih bulat
                ),
              ),
              onPressed: () {
                List<Rumah> filteredRumah = rumahService.daftarRumah
                    .where((rumah) => rumah.tipe == 'Rumah Tinggal')
                    .toList();

                List<RumahTinggal> listRumahTinggal = [];
                for (var rumah in filteredRumah) {
                  if (rumah is RumahTinggal) {
                    listRumahTinggal.add(rumah);
                  }
                }

                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RumahListPage(
                      title: 'Rumah Tinggal',
                      daftarRumah: filteredRumah,
                      rumahTinggal: listRumahTinggal,
                    ),
                  ),
                );
              },
              child: const Text('Rumah Tinggal'),
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: const Color.fromARGB(
                  164,
                  58,
                  92,
                  119,
                ).withValues(alpha: 0.5), // 50% transparan
                foregroundColor: Colors.white, // Warna teks
                elevation: 2, // Mengurangi bayangan
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(
                    20,
                  ), // Membuat sudut lebih bulat
                ),
              ),
              onPressed: () {
                // Filter untuk Rumah Komersial
                List<Rumah> filteredRumah = rumahService.daftarRumah
                    .where((rumah) => rumah.tipe == 'Rumah Komersial')
                    .toList();
                Navigator.of(context).push(
                  MaterialPageRoute(
                    builder: (context) => RumahListPage(
                      title: 'Rumah Komersial',
                      daftarRumah: filteredRumah,
                      rumahTinggal: [],
                    ),
                  ),
                );
              },
              child: const Text('Rumah Komersial'),
            ),
          ],
        ),
      ],
    );
  }

  Widget _buildRumahList(List<Rumah> daftarRumah) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text(
          'Daftar Properti',
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
        const SizedBox(height: 16),
        ListView.builder(
          shrinkWrap: true,
          physics: const NeverScrollableScrollPhysics(),
          itemCount: daftarRumah.length,
          itemBuilder: (context, index) {
            final rumah = daftarRumah[index];
            RumahTinggal? currentRumahTinggal;

            // Periksa apakah rumah adalah RumahTinggal
            if (rumah is RumahTinggal) {
              currentRumahTinggal = rumah;
            }

            return RumahCard(rumah: rumah, rumahTinggal: currentRumahTinggal);
          },
        ),
      ],
    );
  }
}
