const dbConnection = require('../../src/js/connection');
const chalk = require('chalk');

(async () => {
    try {
        await dbConnection.authenticate();
        console.log(chalk.green('Connection has been established successfully.'));
        process.exit(0);
    } catch (error) {
        console.log(chalk.red('Database connection not established!'));
        process.exit(0);
    }
})();