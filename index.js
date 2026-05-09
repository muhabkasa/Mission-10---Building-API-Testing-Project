const express = require('express');
const db = require('./db'); 
const app = express();

app.use(express.json());

app.get('/movies', (req, res) => {
    const sql = "SELECT * FROM movies";
    db.query(sql, (err, result) => {
        if (err) return res.status(500).send(err);
        res.json(result);
    });
});

app.get('/movie/:id', (req, res) => {
    const { id } = req.params;
    const sql = "SELECT * FROM movies WHERE id = ?";
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        if (result.length === 0) return res.status(404).send("Film tidak ditemukan!");
        res.json(result[0]);
    });
});

app.post('/movie', (req, res) => {
    const { title, genre, year } = req.body;
    const sql = "INSERT INTO movies (title, genre, year) VALUES (?, ?, ?)";
    db.query(sql, [title, genre, year], (err, result) => {
        if (err) return res.status(500).send(err);
        res.status(201).send("Film berhasil ditambahkan!");
    });
});

app.patch('/movie/:id', (req, res) => {
    const { id } = req.params;
    const { title, genre, year } = req.body;
    const sql = "UPDATE movies SET title = ?, genre = ?, year = ? WHERE id = ?";
    db.query(sql, [title, genre, year, id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send("Data film berhasil diubah!");
    });
});

app.delete('/movie/:id', (req, res) => {
    const { id } = req.params;
    const sql = "DELETE FROM movies WHERE id = ?";
    db.query(sql, [id], (err, result) => {
        if (err) return res.status(500).send(err);
        res.send("Film berhasil dihapus!");
    });
});

app.listen(3000, () => {
    console.log('Server running on http://localhost:3000');
});