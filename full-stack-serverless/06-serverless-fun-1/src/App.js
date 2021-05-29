import React, { useEffect, useState } from 'react';
import { Auth } from 'aws-amplify';
import { withAuthenticator, AmplifySignOut } from '@aws-amplify/ui-react';
import './App.css';

function App() {
  const [user, updateUser] = useState(null);

  useEffect(() => {
    Auth.currentAuthenticatedUser()
      .then((user) => updateUser(user))
      .catch((err) => console.log(err));
  }, []);

  return (
    <div className="App">
      <header>
        <h1>Hello World</h1>
        {_isAdmin(user) && <p>Welcome, Admin</p>}
      </header>
      <AmplifySignOut />
    </div>
  );
}

function _isAdmin(user) {
  let isAdmin = false;

  if (user) {
    const {
      signInUserSession: {
        idToken: { payload },
      },
    } = user;
    console.log('payload: ', payload);

    if (
      payload['cognito:groups'] &&
      payload['cognito:groups'].includes('Admin')
    ) {
      isAdmin = true;
    }
  }

  return isAdmin;
}

export default withAuthenticator(App);
