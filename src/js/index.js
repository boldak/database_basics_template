const models = require('./models');

const userMapper = (user) => {
    console.log(user.id + ' | ' + user.name + ' | ' + user.email + ' | ' + user.nickname);
};

const projectMapper = (project) => {
    console.log('#' + project.id + ' | ' + project.name);
};


(async () => {
    console.log('--------');
    console.log('Users list');
    console.log('--------');
    const usersList = await models.User.findAll();
    usersList.map(userMapper);


    console.log('\n--------');
    console.log('Projects List');
    console.log('--------');
    const projectsList = (await models.Project.findAll());
    projectsList.map(projectMapper);

    console.log('\n\n--------');
    console.log('Project - User');
    console.log('--------');
    const projects = await models.Project.findAll({
        include: [{
            model: models.User,
            through: {
                attributes: ['role']
            }
        }]
    });
    projects.map(project => {
        console.log('#' + project.id + ' | ' + project.name);
        project.users.map(user => {
            console.log(user.id + ' | ' + user.name + ' | ' + user.project_user.dataValues.role);
        });
    })
})();