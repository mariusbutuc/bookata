import React from 'react';
import Button from './Button';
import { styles } from './Form';

function SignUp({ signUp, updateFormState }) {
  return (
    <div style={styles.container}>
      <input
        name="username"
        placeholder="username"
        onChange={updateFormState}
        style={styles.input}
      />
      <input
        type="password"
        name="password"
        placeholder="password"
        onChange={updateFormState}
        style={styles.input}
      />
      <input
        name="email"
        placeholder="email"
        onChange={updateFormState}
        style={styles.input}
      />
      <Button onClick={signUp} title="Sign Up" />
    </div>
  );
}

export default SignUp;
