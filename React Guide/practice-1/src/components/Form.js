import { useState } from 'react';

import Button from './UI/Button';
import Card from './UI/Card';

function Form(props) {
  const ERROR_AGE = 'ERROR_AGE';
  const ERROR_GENERAL = 'ERROR_GENERAL';

  const [enteredUsername, setEnteredUsername] = useState('');
  const [enteredAge, setEnteredAge] = useState('');

  const usernameChangeHandler = (event) => {
    setEnteredUsername(event.target.value);
  };

  const ageChangeHandler = (event) => {
    setEnteredAge(event.target.value);
  };

  const resetInputs = () => {
    setEnteredUsername('');
    setEnteredAge('');
  };

  const handleSubmit = (event) => {
    event.preventDefault();

    const validUsername = enteredUsername !== '';
    const validAge = enteredAge && +enteredAge > 0;

    if (validUsername && validAge) {
      props.onSubmit({ username: enteredUsername, age: +enteredAge });
      resetInputs();
      return;
    }

    let errorType = validAge ? ERROR_GENERAL : ERROR_AGE;
    handleError(errorType);
  };

  const handleError = (errorType) => {
    let title = 'Invalid input';
    let content =
      errorType === ERROR_AGE
        ? 'Age must be greater than 0.'
        : 'Please enter a valid name and age.';
    props.onError(title, content);
  };
  return (
    <Card>
      <form className="flex flex-col" onSubmit={handleSubmit}>
        <label className="mb-1 font-bold" htmlFor="username">
          Username
        </label>
        <input
          className="mb-3 rounded border-2 p-1 px-3"
          type="text"
          id="username"
          onChange={usernameChangeHandler}
          value={enteredUsername}
        />

        <label className="mb-1 font-bold" htmlFor="age">
          Age (Year)
        </label>
        <input
          className="mb-3 rounded border-2 p-1 px-3"
          type="number"
          id="age"
          min="0"
          step="1"
          onChange={ageChangeHandler}
          value={enteredAge}
        />
        <Button type="submit">Add User</Button>
      </form>
    </Card>
  );
}

export default Form;
