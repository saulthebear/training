import useInput from '../hooks/use-input';

const BasicForm = (props) => {
  const {
    hasError: nameHasError,
    valueChangeHandler: nameChangeHandler,
    blurHandler: nameBlurHandler,
  } = useInput((input) => input.trim().length > 0);

  const {
    hasError: surnameHasError,
    valueChangeHandler: surnameChangeHandler,
    blurHandler: surnameBlurHandler,
  } = useInput((input) => input.trim().length > 0);

  const {
    hasError: emailHasError,
    valueChangeHandler: emailChangeHandler,
    blurHandler: emailBlurHandler,
  } = useInput((input) => input.trim().includes('@'));

  const nameClasses = nameHasError ? 'form-control invalid' : 'form-control';
  const surnameClasses = surnameHasError
    ? 'form-control invalid'
    : 'form-control';
  const emailClasses = emailHasError ? 'form-control invalid' : 'form-control';

  return (
    <form>
      <div className="control-group">
        <div className={nameClasses}>
          <label htmlFor="name">First Name</label>
          <input
            type="text"
            id="name"
            onChange={nameChangeHandler}
            onBlur={nameBlurHandler}
          />
        </div>
        <div className={surnameClasses}>
          <label htmlFor="name">Last Name</label>
          <input
            type="text"
            id="name"
            onChange={surnameChangeHandler}
            onBlur={surnameBlurHandler}
          />
        </div>
      </div>
      <div className={emailClasses}>
        <label htmlFor="name">E-Mail Address</label>
        <input
          type="text"
          id="name"
          onChange={emailChangeHandler}
          onBlur={emailBlurHandler}
        />
      </div>
      <div className="form-actions">
        <button>Submit</button>
      </div>
    </form>
  );
};

export default BasicForm;
