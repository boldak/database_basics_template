const connection = require('../connection');
const Sequilize = require('sequelize');

const User = require('./user.js');
const Project = require('./project.js');

class Access extends Sequilize.Model {}

Access.init(
    {
        id: {
            type: Sequilize.INTEGER,
            primaryKey: true
        },
        role: {
            type: Sequilize.STRING(100),
            allowNull: false
        },
        user_id: {
            type: Sequilize.INTEGER,
            allowNull: true
        },
        project_id: {
            type: Sequilize.INTEGER,
            allowNull: true
        }
    },
    {
        sequelize: connection,
        freezeTableName: true,
        modelName: 'Access'
    }
);

User.hasMany(Access);
Project.hasMany(Access);

Access.belongsTo(User, {
    foreignKey: 'user_id'
});

Access.belongsTo(Project, {
    foreignKey: 'project_id'
});

module.exports = Access