import React, { useEffect } from 'react';
import { Auth } from 'aws-amplify';
import Container from './Container';

function Protected(props) {
  useEffect(() => {
    Auth
      // Check to see if the user is signed in to the app
      .currentAuthenticatedUser()
      // Otherwise, redirect them
      .catch(() => {
        props.history.push('/profile');
      });
    // FIXME: Understand the implications of disabling the warning below
    // eslint-disable-next-line react-hooks/exhaustive-deps
  }, []);

  return (
    <Container>
      <h1>Protected route</h1>
    </Container>
  );
}

export default Protected;
