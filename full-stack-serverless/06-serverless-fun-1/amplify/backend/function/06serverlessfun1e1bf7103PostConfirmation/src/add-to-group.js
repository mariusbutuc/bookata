const aws = require('aws-sdk');

exports.handler = async (event, context, callback) => {
  const cognitoProvider = new aws.CognitoIdentityServiceProvider({
    apiVersion: '2016-04-18',
  });

  const adminGroupName = process.env.GROUP;

  const groupParams = {
    UserPoolId: event.userPoolId,
  };

  const userParams = {
    UserPoolId: event.userPoolId,
    Username: event.userName,
  };

  let isAdmin = false;
  const adminEmails = ['marius+atlist@mailinator.com'];

  // If the user is one of the admins, set isAdmin to true
  if (adminEmails.includes(event.request.userAttributes.email)) {
    isAdmin = true;
  }

  if (isAdmin) {
    groupParams.GroupName = adminGroupName;
    userParams.GroupName = adminGroupName;

    // First check to see if the group exists, and if not create the group
    try {
      await cognitoProvider.getGroup(groupParams).promise();
    } catch (e) {
      await cognitoProvider.createGroup(groupParams).promise();
    }

    // If the user is an administrator, place them in the Admin group
    try {
      await cognitoProvider.adminAddUserToGroup(userParams).promise();
      callback(null, event);
    } catch (e) {
      callback(e);
    }
  } else {
    // If the user is in neither group, proceed with no action
    callback(null, event);
  }
};
