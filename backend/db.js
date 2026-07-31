const mysql = require("mysql2");
const loadVaultSecrets = require("./config/vault");

const vaultSecrets = loadVaultSecrets();

const connection = mysql.createConnection({
    host: process.env.DB_HOST,

    user: vaultSecrets.DB_USER || process.env.DB_USER,

    password: vaultSecrets.DB_PASSWORD || process.env.DB_PASSWORD,

    database: process.env.DB_NAME,

    port: process.env.DB_PORT
});

connection.connect((err) => {
    if (err) {
        console.error("Database connection failed:", err);
        return;
    }

    console.log("Connected to MySQL");
});

module.exports = connection;