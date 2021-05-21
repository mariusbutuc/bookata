import React, { useState } from 'react';
import { Auth } from 'aws-amplify';

import SignIn from './SignIn';
import SignUp from './SignUp';
import ConfirmSignUp from './ConfirmSignUp';
import ResetPassword from './ResetPassword';
import ResetPasswordSubmit from './ResetPasswordSubmit';

// Keep the input fields in the form state
const initialFormState = {
  username: '',
  password: '',
  email: '',
  confirmationCode: '',
};

function Form(props) {
  const [formType, updateFormType] = useState('signIn');
  const [formState, updateFormState] = useState(initialFormState);

  /**
   * Create a new `formState` object updating the new values coming from the input event
   *
   * Problem: `updateFormState` is expecting a new object with all the fields in `initialFormState` in order to update
   *          the form state. Yet a form handler profides only the single form event that is being typed.
   *
   * @param {Object} event - The form input event to be transformed in a new `formState` object
   */
  function updateForm(event) {
    const newFormState = {
      ...formState,
      [event.target.name]: event.target.value,
    };

    updateFormState(newFormState);
  }

  /**
   * Check the current `formType` that is set in the state and reder the proper form.
   *
   * @returns {(SignUp|ConfirmSignUp|SignIn|ResetPassword|ResetPasswordSubmit|null)} - the Auth form to be rendered
   */
  function renderForm() {
    switch (formType) {
      case 'signUp':
        return (
          <SignUp
            signUp={() => signUp(formState, updateFormType)}
            updateFormState={(e) => updateForm(e)}
          />
        );

      case 'confirmSignUp':
        return (
          <ConfirmSignUp
            confirmSignUp={() => confirmSignUp(formState, updateFormType)}
            updateFormState={(e) => updateForm(e)}
          />
        );

      case 'signIn':
        return (
          <SignIn
            signIn={() => signIn(formState, props.setUser)}
            updateFormState={(e) => updateForm(e)}
          />
        );

      case 'resetPassword':
        return (
          <ResetPassword
            resetPassword={() => resetPassword(formState, updateFormType)}
            updateFormState={(e) => updateForm(e)}
          />
        );

      case 'resetPasswordSubmit':
        return (
          <ResetPasswordSubmit
            resetPasswordSubmit={() =>
              resetPasswordSubmit(formState, updateFormType)
            }
            updateFormState={(e) => updateForm(e)}
          />
        );

      default:
        return null;
    }
  }

  return (
    <div>
      {renderForm()}
      {formType === 'signUp' && (
        <p style={styles.toggleForm}>
          Already have an account?{' '}
          <span style={styles.anchor} onClick={() => updateFormType('signIn')}>
            Sign In
          </span>
        </p>
      )}
      {formType === 'signIn' && (
        <>
          <p style={styles.toggleForm}>
            Need an account?{' '}
            <span
              style={styles.anchor}
              onClick={() => updateFormType('signUp')}
            >
              Sign Up
            </span>
          </p>
          <p style={{ ...styles.toggleForm, ...styles.resetPassword }}>
            Forgot your password?{' '}
            <span
              style={styles.anchor}
              onClick={() => updateFormType('resetPassword')}
            >
              Reset Password
            </span>
          </p>
        </>
      )}
    </div>
  );
}

async function signUp({ username, password, email }, updateFormType) {
  try {
    await Auth.signUp({ username, password, attributes: { email } });
    console.log('Sign up success!');
    updateFormType('confirmSignUp');
  } catch (err) {
    console.log('Error signing up: ', err);
  }
}

async function confirmSignUp({ username, confirmationCode }, updateFormType) {
  try {
    await Auth.confirmSignUp(username, confirmationCode);
    updateFormType('signIn');
  } catch (err) {
    console.log('Error signing up: ', err);
  }
}

async function signIn({ username, password }, setUser) {
  try {
    const user = await Auth.signIn(username, password);
    const userInfo = { username: user.username, ...user.attributes };
    // `setUser` will be passed into the `Form` component as a prop from the `Profile` component. It allows us to
    // re-render the `Profile` component in order to show or hide the form once the user has successfully signed in.
    setUser(userInfo);
  } catch (err) {
    console.log('Error signing in: ', err);
  }
}

async function resetPassword({ username }, updateFormType) {
  try {
    await Auth.forgotPassword(username);
    updateFormType('forgotPasswordSubmit');
  } catch (err) {
    console.log('Error submitting username to reset password: ', err);
  }
}

async function resetPasswordSubmit(
  { username, confirmationCode, password },
  updateFormType
) {
  try {
    await Auth.forgotPasswordSubmit(username, confirmationCode, password);
    updateFormType('signIn');
  } catch (err) {
    console.log('Error updating password: ', err);
  }
}

const styles = {
  container: {
    display: 'flex',
    flexDirection: 'column',
    marginTop: 150,
    justifyContent: 'center',
    alignItems: 'center',
  },
  input: {
    height: 45,
    marginTop: 8,
    width: 300,
    maxWidth: 300,
    padding: '0px 8px',
    fontSize: 16,
    outline: 'none',
    border: 'none',
    borderBottom: '2px solid rgba(0, 0, 0, .3)',
  },
  toggleForm: {
    fontWeight: 600,
    padding: '0px 25px',
    marginTop: '15px',
    marginBottom: 0,
    textAlign: 'center',
    color: 'rgba(0, 0, 0, 0.6)',
  },
  resetPassword: {
    marginTop: '5px',
  },
  anchor: {
    color: '#006bfc',
    cursor: 'pointer',
  },
};

export { styles, Form as default };
