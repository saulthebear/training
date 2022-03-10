import Button from './UI/Button';
import Card from './UI/Card';

function Form(props) {
  const ERROR_AGE = 'ERROR_AGE';
  const ERROR_GENERAL = 'ERROR_GENERAL';

  const handleSubmit = (event) => {
    event.preventDefault();
    const form = event.target;

    const usernameInput = form.querySelector('#username').value.trim();
    const ageInput = form.querySelector('#age').value.trim();

    const validUsername = usernameInput != '';
    const validAge = ageInput && +ageInput > 0;

    if (validUsername && validAge) {
      props.onSubmit({ username: usernameInput, age: +ageInput });
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
        />
        <Button type="submit">Add User</Button>
      </form>
    </Card>
  );
}

export default Form;
