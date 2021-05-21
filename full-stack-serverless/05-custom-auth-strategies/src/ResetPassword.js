import React from 'react';
import Button from './Button';
import { styles } from './Form';

function ResetPassword({ resetPassword, updateFormState }) {
  return (
    <div style={styles.container}>
      <input
        name="username"
        placeholder="username"
        onChange={updateFormState}
        style={styles.input}
      />
      <Button onClick={resetPassword} title="Reset Password" />
    </div>
  );
}

export default ResetPassword;
