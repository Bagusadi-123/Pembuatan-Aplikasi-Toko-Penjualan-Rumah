import 'package:flutter/material.dart';
import 'package:my_project/models/rumah_turunan.dart';

import 'package:my_project/widgets/rumah_card.dart';

import '../models/rumah.dart';

class RumahListPage extends StatelessWidget {
  final String title;
  final List<Rumah> daftarRumah;
  final List<RumahTinggal> rumahTinggal;

  const RumahListPage({
    super.key,
    required this.title,
    required this.daftarRumah,
    required this.rumahTinggal,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text(title), automaticallyImplyLeading: true),
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topCenter,
            end: Alignment.bottomCenter,
            colors: [Colors.blue.shade50, Colors.white],
          ),
        ),
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                  ),
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

                    return RumahCard(
                      rumah: rumah,
                      rumahTinggal: currentRumahTinggal,
                    );
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
