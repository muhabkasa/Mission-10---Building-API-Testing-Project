CREATE TABLE Paket (
    paket_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_paket VARCHAR(50) NOT NULL,
    harga INT NOT NULL,
    resolusi_maksimal VARCHAR(20),
    durasi_hari INT
);

CREATE TABLE Genre (
    genre_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_genre VARCHAR(50) NOT NULL
);

CREATE TABLE Series_Film (
    series_film_id INT PRIMARY KEY AUTO_INCREMENT,
    judul VARCHAR(255) NOT NULL,
    deskripsi TEXT,
    tahun_rilis YEAR,
    rating_usia VARCHAR(10),
    tipe ENUM('Film', 'Series') NOT NULL
);

CREATE TABLE User (
    user_id INT PRIMARY KEY AUTO_INCREMENT,
    nama_lengkap VARCHAR(100) NOT NULL,
    email VARCHAR(100) UNIQUE NOT NULL,
    password VARCHAR(255) NOT NULL,
    paket_id INT,
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
);

CREATE TABLE Episode_Movie (
    episode_id INT PRIMARY KEY AUTO_INCREMENT,
    series_film_id INT,
    judul_episode VARCHAR(255),
    durasi_menit INT,
    url_video VARCHAR(255),
    FOREIGN KEY (series_film_id) REFERENCES Series_Film(series_film_id)
);

CREATE TABLE Series_Genre (
    series_film_id INT,
    genre_id INT,
    PRIMARY KEY (series_film_id, genre_id),
    FOREIGN KEY (series_film_id) REFERENCES Series_Film(series_film_id),
    FOREIGN KEY (genre_id) REFERENCES Genre(genre_id)
);

CREATE TABLE Daftar_Saya (
    daftar_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    series_film_id INT,
    tanggal_ditambahkan TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (series_film_id) REFERENCES Series_Film(series_film_id)
);

CREATE TABLE Orders (
    order_id INT PRIMARY KEY AUTO_INCREMENT,
    user_id INT,
    paket_id INT,
    tanggal_order TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    status_order ENUM('Pending', 'Success', 'Failed') DEFAULT 'Pending',
    FOREIGN KEY (user_id) REFERENCES User(user_id),
    FOREIGN KEY (paket_id) REFERENCES Paket(paket_id)
);

CREATE TABLE Pembayaran (
    pembayaran_id INT PRIMARY KEY AUTO_INCREMENT,
    order_id INT UNIQUE,
    metode_pembayaran VARCHAR(50),
    tanggal_bayar TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    jumlah_bayar INT,
    FOREIGN KEY (order_id) REFERENCES Orders(order_id)
);