const models = require('../../src/js/models');
const Table = require("cli-table3");
const _ = require("lodash-node");
const chalk = require("chalk");

const toTable =  (data, ...fields) => {
    let res = new Table( { head: fields.map( f => _.last(f.split("."))) } );
    data.forEach(item => {
        let d = [];
        fields.forEach( field => {
            d.push( _.get(item, field) || " ");
        });
        res.push(d);
    });
    return res.toString();
};


(async () => {
    const accountsList = await models.Account.findAll();
    console.log(chalk.green(`Accounts list`));
    console.log(toTable(accountsList, "role", "email", "login", "password", "state", "avatar"));

    const accessList = await models.Access.findAll({
        include: [{
            model: models.Account,
            through: {
                attributes: ['role']
            }
        }]
    });
    console.log(chalk.green(`Accesses List`));

    console.log(accessList.map(access => `Access: ${access.role}
${toTable(access.Account, "role", "Access.dataValues.role")}`).join("\n"));
})();