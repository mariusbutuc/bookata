import React from 'react';
import Button from './Button';
import { styles } from './Form';

function ResetPasswordSubmit({ resetPasswordSubmit, updateFormState }) {
  return (
    <div style={styles.container}>
      <input
        name="confirmationCode"
        placeholder="Confirmation Code"
        onChange={updateFormState}
        style={styles.input}
      />
      <input
        name="password"
        placeholder="New Password"
        onChange={updateFormState}
        style={styles.input}
      />
      <Button onClick={resetPasswordSubmit} title="Save New Password" />
    </div>
  );
}

export default ResetPasswordSubmit;
