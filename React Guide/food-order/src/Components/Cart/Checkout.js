import { useRef, useState } from 'react';

const isNotEmpty = (value) => value.trim() !== '';
const isFiveChars = (value) => value.trim().length === 5;

function Checkout(props) {
  const nameInputRef = useRef();
  const streetInputRef = useRef();
  const postalCodeInputRef = useRef();
  const cityInputRef = useRef();

  const [formValidation, setFormValidation] = useState({
    name: true,
    street: true,
    postalCode: true,
    city: true,
  });

  const confirmHandler = (event) => {
    event.preventDefault();

    const enteredName = nameInputRef.current.value;
    const enteredStreet = streetInputRef.current.value;
    const enteredPostalCode = postalCodeInputRef.current.value;
    const enteredCity = cityInputRef.current.value;

    const nameIsValid = isNotEmpty(enteredName);
    const streetIsValid = isNotEmpty(enteredStreet);
    const postalCodeIsValid = isFiveChars(enteredPostalCode);
    const cityIsValid = isNotEmpty(enteredCity);

    const formIsValid =
      nameIsValid && streetIsValid && postalCodeIsValid && cityIsValid;

    setFormValidation({
      name: nameIsValid,
      street: streetIsValid,
      postalCode: postalCodeIsValid,
      city: cityIsValid,
    });

    if (formIsValid) {
      console.log('Form is valid');
    }
  };

  const validInputClasses = 'w-full rounded-md border-2';
  const invalidInputClasses =
    'w-full rounded-md border-2 border-red-700 bg-red-50';
  const formControlClasses = 'mb-5 flex flex-col';
  const labelClasses = 'mr-4 text-lg font-bold';

  return (
    <form onSubmit={confirmHandler}>
      <div className={formControlClasses}>
        <label htmlFor="name" className={labelClasses}>
          Name
        </label>
        <input
          ref={nameInputRef}
          type="text"
          id="name"
          className={
            formValidation.name ? validInputClasses : invalidInputClasses
          }
        />
        {!formValidation.name && (
          <p className=" text-red-700">Name is invalid</p>
        )}
      </div>
      <div className={formControlClasses}>
        <label htmlFor="street" className={labelClasses}>
          Street
        </label>
        <input
          ref={streetInputRef}
          type="text"
          name="street"
          id="street"
          className={
            formValidation.street ? validInputClasses : invalidInputClasses
          }
        />
        {!formValidation.street && (
          <p className=" text-red-700">Street is invalid</p>
        )}
      </div>
      <div className={formControlClasses}>
        <label htmlFor="postalCode" className={labelClasses}>
          Postal Code
        </label>
        <input
          ref={postalCodeInputRef}
          type="text"
          id="postalCode"
          className={
            formValidation.postalCode ? validInputClasses : invalidInputClasses
          }
        />
        {!formValidation.postalCode && (
          <p className=" text-red-700">Postal Code is not five digits</p>
        )}
      </div>
      <div className={formControlClasses}>
        <label htmlFor="city" className={labelClasses}>
          City
        </label>
        <input
          ref={cityInputRef}
          type="text"
          name="city"
          id="city"
          className={
            formValidation.city ? validInputClasses : invalidInputClasses
          }
        />
        {!formValidation.city && (
          <p className=" text-red-700">City is invalid</p>
        )}
      </div>
      <footer className="flex justify-end text-xl">
        <button
          type="button"
          onClick={props.onCancel}
          className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0"
        >
          Cancel
        </button>
        <button
          type="submit"
          className="mr-5 rounded-full bg-orange-900 px-8 py-1 text-white shadow-orange-900 last:mr-0"
        >
          Confirm
        </button>
      </footer>
    </form>
  );
}

export default Checkout;
