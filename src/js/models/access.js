const connection = require('../connection');
const Sequilize = require('sequelize');

const Account = require('./account.js');

class Access extends Sequilize.Model {}

Access.init(
    {
        role: {
            type: Sequilize.STRING(100),
            primaryKey: true
        },
        account_role: {
            type: Sequilize.STRING(45),
            allowNull: false
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'Access'
    }
);

Account.hasMany(Access);

Access.belongsTo(Account, {
    foreignKey: 'account_role'
});

module.exports = Access