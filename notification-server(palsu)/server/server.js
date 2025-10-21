// server.js
const express = require('express');
const cors = require('cors');
const app = express();
const port = 3000;

// "Database" sementara di memori
let notifications = [
    {
        id: '1',
        title: 'Promo Spesial',
        message: 'Dapatkan diskon 10% untuk semua properti komersial minggu ini.',
        timestamp: new Date(Date.now() - 2 * 60 * 60 * 1000).toISOString(),
        isRead: false
    }
];

// Izinkan aplikasi Flutter (dari domain berbeda) mengakses server ini
app.use(cors()); 
// Izinkan server menerima data dalam format JSON
app.use(express.json());

// API untuk mengambil semua notifikasi
app.get('/notifications', (req, res) => {
    res.json(notifications);
});

// API untuk menambah notifikasi baru
app.post('/notifications', (req, res) => {
    const { title, message } = req.body;
    if (!title || !message) {
        return res.status(400).json({ error: 'Title dan message wajib diisi' });
    }
    const newNotification = {
        id: Date.now().toString(),
        title,
        message,
        timestamp: new Date().toISOString(),
        isRead: false
    };
    notifications.unshift(newNotification); // Tambahkan ke awal array
    res.status(201).json(newNotification);
});

// API untuk menandai semua notifikasi sudah dibaca
app.put('/notifications/read-all', (req, res) => {
    notifications.forEach(n => n.isRead = true);
    res.json({ message: 'Semua notifikasi ditandai sudah dibaca' });
});

app.listen(port, () => {
    console.log(`Server notifikasi berjalan di http://localhost:${port}`);
});