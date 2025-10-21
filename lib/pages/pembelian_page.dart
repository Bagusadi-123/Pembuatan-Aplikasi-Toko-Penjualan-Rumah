import 'package:flutter/material.dart';
import 'package:my_project/services/notification_service.dart';
import 'package:flutter_rating/flutter_rating.dart';

class Pembelian extends StatefulWidget {
  const Pembelian({super.key});

  @override
  State<Pembelian> createState() => _PembelianState();
}

class _PembelianState extends State<Pembelian> {

  double _rating = 0.0;
  final int _starCount = 5;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Pembelian Rumah"),
        backgroundColor: Colors.grey,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Data Unit Section
            _buildDataUnitSection(),
            const SizedBox(height: 24),

            // Rincian Harga Section
            _buildRincianHargaSection(),
            const SizedBox(height: 24),

            // Rincian Pembayaran Section
            _buildRincianPembayaranSection(),
            const SizedBox(height: 32),

            // Tombol Konfirmasi
            _buildKonfirmasiButton(context),
          ],
        ),
      ),
    );
  }

  Widget _buildDataUnitSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Data Unit',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Type', 'Rumah Minimalis 3 Kamar'),
            _buildInfoRow('Luas Bangunan', '90 m²'),
            _buildInfoRow('Blok/Nomor', 'A-15'),
            _buildInfoRow('Luas Tanah', '120 m²'),
          ],
        ),
      ),
    );
  }

  Widget _buildRincianHargaSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rincian Harga',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.green[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Harga Unit', 'Rp 750.000.000'),
            _buildInfoRow('PPN (11%)', 'Rp 82.500.000'),
            const Divider(thickness: 2),
            _buildInfoRow('Total Harga Jual', 'Rp 832.500.000', isTotal: true),
          ],
        ),
      ),
    );
  }

  Widget _buildRincianPembayaranSection() {
    return Card(
      elevation: 4,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      child: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              'Rincian Pembayaran',
              style: TextStyle(
                fontSize: 18,
                fontWeight: FontWeight.bold,
                color: Colors.orange[800],
              ),
            ),
            const SizedBox(height: 16),
            _buildInfoRow('Cara Pembayaran', 'KPR (Kredit)'),
            _buildInfoRow('Booking Fee', 'Rp 5.000.000'),
            _buildInfoRow('Uang Muka (20%)', 'Rp 166.500.000'),
            _buildInfoRow('Plafon Kredit', 'Rp 666.000.000'),
          ],
        ),
      ),
    );
  }

  Widget _buildInfoRow(String label, String value, {bool isTotal = false}) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            label,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.normal,
              color: isTotal ? Colors.green[800] : Colors.black87,
            ),
          ),
          Text(
            value,
            style: TextStyle(
              fontSize: 16,
              fontWeight: isTotal ? FontWeight.bold : FontWeight.w600,
              color: isTotal ? Colors.green[800] : Colors.black,
            ),
          ),
        ],
      ),
    );
  }

  // untuk menampilkan dialog rating
  void _showRatingDialog(BuildContext context) {
    showDialog(
      context: context,
      barrierDismissible: false, // Mencegah dialog tertutup saat klik di luar
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Beri Rating'),
          content: Column(
            // Agar ukuran dialog menyesuaikan isinya
            mainAxisSize: MainAxisSize.min, 
            children: [
              const Text('Bagaimana pengalaman Anda dalam melakukan pembelian?'),
              const SizedBox(height: 20),
              // Gunakan variabel state _rating dan _starCount
              StarRating(
                size: 40.0,
                rating: _rating,
                color: Colors.orange,
                borderColor: Colors.grey,
                allowHalfRating: true,
                starCount: _starCount,
                onRatingChanged: (rating) => setState(() {
                  _rating = rating; // Perbarui state saat rating berubah
                }),
              ),
              const SizedBox(height: 20),
            ],
          ),
          actions: [
            TextButton(
              onPressed: () {
                // Tutup dialog dan kembali ke halaman home
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Lewati'),
            ),
            ElevatedButton(
              onPressed: () {
                // TODO: Di sini Anda bisa menambahkan logika untuk menyimpan rating ke server/database
                // Contoh: print('Rating yang dikirim: $_rating');
                
                // Tutup dialog dan kembali ke halaman home
                Navigator.of(context).popUntil((route) => route.isFirst);
              },
              child: const Text('Kirim'),
            ),
          ],
        );
      },
    );
  }

  Widget _buildKonfirmasiButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () async {
           // 1. Tampilkan dialog konfirmasi dan tunggu hasilnya
          final bool? shouldProceed = await showDialog<bool>(
            context: context,
            builder: (BuildContext dialogContext) {
              return AlertDialog(
                title: const Text('Konfirmasi Pembelian'),
                content: const Text(
                  'Apakah Anda yakin ingin melanjutkan pembelian rumah ini?',
                ),
                actions: [
                  TextButton(
                     // Kembalikan nilai false jika batal
                    onPressed: () => Navigator.of(dialogContext).pop(false),
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    // Kembalikan nilai true jika konfirmasi
                    onPressed: () => Navigator.of(dialogContext).pop(true),
                    child: const Text('Konfirmasi'),
                  ),
                ],
              );      
            },
          );      
          // 2. Jika pengguna menekan 'Konfirmasi' (shouldProceed adalah true)
          if (shouldProceed == true) {
            // Kirim notifikasi ke server
            final success = await NotificationService().addNotificationWithFeedback(
              // Gunakan 'context' dari build method, yang masih valid
              context: context, 
              title: 'Pembelian Berhasil',
              message: 'Pembelian rumah Anda telah berhasil dikonfirmasi. Silakan lanjut ke proses selanjutnya.',
            );
             // Jika penyimpanan notifikasi berhasil, tampilkan snackbar sukses pembelian
            if (success) {
               ScaffoldMessenger.of(context).showSnackBar(
                 const SnackBar(
                   content: Text('Pembelian berhasil dikonfirmasi!'),
                   backgroundColor: Colors.green,
                 ),
               );
             }        
            // 3. Tampilkan dialog rating menggunakan 'context' yang valid
            _showRatingDialog(context);
          }
        },
        style: ElevatedButton.styleFrom(
          backgroundColor: Colors.blue[700],
          foregroundColor: Colors.white,
          padding: const EdgeInsets.symmetric(vertical: 16),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(12),
          ),
        ),
        child: const Text(
          'Konfirmasi Pembelian',
          style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
        ),
      ),
    );
  }
}
