const connection = require('../connection');
const Sequilize = require('sequelize');

class User extends Sequilize.Model {}

User.init(
    {
        id: {
            type: Sequilize.INTEGER,
            primaryKey: true
        },
        name: {
            type: Sequilize.STRING(300),
            allowNull: false
        },
        password: {
            type: Sequilize.STRING(300),
            allowNull: false
        },
        email: {
            type: Sequilize.STRING(200),
            allowNull: false
        },
        activationKey: {
            type: Sequilize.STRING(200),
            allowNull: false
        },
        status: {
            type: Sequilize.STRING(100),
            allowNull: true
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'User'
    }
);

module.exports = User