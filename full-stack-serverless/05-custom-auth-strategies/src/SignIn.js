import React from 'react';
import Button from './Button';
import { styles } from './Form';

function SignIn({ signIn, updateFormState }) {
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
      <Button onClick={signIn} title="Sign In" />
    </div>
  );
}

export default SignIn;
