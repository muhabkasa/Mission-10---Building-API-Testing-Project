const mysql = require('mysql2');

const db = mysql.createConnection({
    host: 'localhost',
    user: 'root',
    password: '',
    database: 'movie_app',
    port: 3306 // Ubah angka ini menjadi 3306 menyesuaikan XAMPP kamu saat ini
});

db.connect((err) => {
    if (err) {
        console.error('Gagal terkoneksi ke database:', err.message);
        return;
    }
    console.log('Berhasil terkoneksi ke database MySQL!');
});

module.exports = db;