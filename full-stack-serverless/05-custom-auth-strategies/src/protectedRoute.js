import React, { useEffect } from 'react';
import { Auth } from 'aws-amplify';

const protectedRoute =
  (Comp, route = '/profile') =>
  (props) => {
    async function checkAuthState() {
      try {
        await Auth.currentAuthenticatedUser();
      } catch (err) {
        props.history.push(route);
      }
    }

    // When the component loads, check if the user is signed in.
    useEffect(() => {
      checkAuthState();
      // FIXME: Understand the implications of disabling the warning below
      // eslint-disable-next-line react-hooks/exhaustive-deps
    }, []);

    return <Comp {...props} />;
  };

export default protectedRoute;
