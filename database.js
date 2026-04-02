const { Pool } = require('pg');

const pool = new Pool({
    host: 'localhost',
    port: 5432,
    database: 'university',
    user: 'sandbox',
    password: 'sandbox'
});


