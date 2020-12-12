const dbConfig = require('../../config/database');
const fs = require('fs');
const path = require('path');
const mysql = require('mysql2');

const sqlScript = fs.readFileSync(path.join(__dirname, '../../src/sql/EER.sql')).toString();

const connection = mysql.connect({
    host: dbConfig.DATABASE_HOST,
    user: dbConfig.DATABASE_USERNAME,
    password: dbConfig.DATABASE_PASSWORD,
    database: dbConfig.DATABASE_NAME,
    multipleStatements: true
});

connection.query(sqlScript, function (error) {
    if (error) throw error;
});

process.exit(0);