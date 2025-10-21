// home_page.dart
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:my_project/bloc/website_bloc.dart';
import 'package:my_project/models/rumah_turunan.dart';
import 'package:my_project/pages/profile_page.dart'; // Import halaman profile
import 'package:my_project/pages/rumah_list_page.dart';
import 'package:my_project/services/rumah_service.dart';
import 'package:my_project/widgets/rumah_card.dart';
import 'package:my_project/services/notification_service.dart'; // Import layanan
import 'package:badges/badges.dart' as badges;
import 'package:my_project/pages/notification_page.dart';

import '../models/rumah.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _unreadCount = 0;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
     // DAFTARKAN fungsi _loadUnreadCount ke dalam callback NotificationService
    NotificationService.onNotificationAdded = _loadUnreadCount;
    _loadUnreadCount();
  }

  @override
  void dispose() {
    // PENTING: Lepaskan pendaftaran saat widget dihancurkan untuk mencegah memory leak
    NotificationService.onNotificationAdded = null;
    super.dispose();
  }

  Future<void> _loadUnreadCount() async {
    // GANTI dengan fungsi baru
    final count = await NotificationService().getUnreadCountWithFeedback(context: context);
    setState(() {
      _unreadCount = count;
      _isLoading = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    final RumahService rumahService = RumahService();
    rumahService.inisialisasiData();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Toko Penjualan Rumah'),
        automaticallyImplyLeading: false,
        actions: [
          // Tambahkan notifikasi badge dengan angka
          Padding(
            padding: const EdgeInsets.only(right: 16.0),
            child: _isLoading
                ? const SizedBox(
                    width: 24,
                    height: 24,
                    child: CircularProgressIndicator(
                      strokeWidth: 2,
                      color: Colors.white,
                    ),
                  )
                : badges.Badge(
                    position: badges.BadgePosition.topEnd(top: -8, end: -4),
                    showBadge: _unreadCount > 0,
                    ignorePointer: false,
                    badgeContent: Text(
                      _unreadCount.toString(),
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 12,
                      ),
                    ),
                    badgeAnimation: badges.BadgeAnimation.rotation(
                      animationDuration: const Duration(seconds: 1),
                      colorChangeAnimationDuration: const Duration(seconds: 1),
                      loopAnimation: false,
                      curve: Curves.fastOutSlowIn,
                      colorChangeAnimationCurve: Curves.easeInCubic,
                    ),
                    badgeStyle: badges.BadgeStyle(
                      shape: badges.BadgeShape.circle,
                      badgeColor: Colors.red,
                      padding: const EdgeInsets.all(5),
                      borderSide: const BorderSide(color: Colors.white, width: 2),
                      elevation: 0,
                    ),
                    child: IconButton(
                      icon: const Icon(Icons.notifications),
                      onPressed: () async {
                        // Navigasi ke halaman notifikasi
                        await Navigator.of(context).push(
                          MaterialPageRoute(builder: (context) => const NotificationPage()),
                        );
                        // Setelah kembali dari halaman notifikasi, refresh badge
                        _loadUnreadCount();
                      },
                    ),
                  ),
          ),

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
