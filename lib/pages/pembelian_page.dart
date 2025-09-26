import 'package:flutter/material.dart';

class Pembelian extends StatelessWidget{
  const Pembelian ({Key? key}) : super (key : key);

  @override
  Widget build (BuildContext  context) {
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
            _buildInfoRow(
              'Total Harga Jual', 
              'Rp 832.500.000',
              isTotal: true,
            ),
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

  Widget _buildKonfirmasiButton(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      child: ElevatedButton(
        onPressed: () {
          showDialog(
            context: context,
            builder: (BuildContext context) {
              return AlertDialog(
                title: const Text('Konfirmasi Pembelian'),
                content: const Text('Apakah Anda yakin ingin melanjutkan pembelian rumah ini?'),
                actions: [
                  TextButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                    },
                    child: const Text('Batal'),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.of(context).pop();
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Pembelian berhasil dikonfirmasi!'),
                          backgroundColor: Colors.green,
                        ),
                      );
                    },
                    child: const Text('Konfirmasi'),
                  ),
                ],
              );
            },
          );
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
