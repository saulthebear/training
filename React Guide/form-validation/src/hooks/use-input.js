import { useState, useCallback } from 'react';

function useInput(validationFunction) {
  const [value, setValue] = useState('');
  const [isTouched, setIsTouched] = useState(false);

  const isValid = validationFunction(value);
  const hasError = !isValid && isTouched;

  const reset = useCallback(() => {
    setValue('');
    setIsTouched(false);
  }, []);

  const valueChangeHandler = (event) => setValue(event.target.value);
  const blurHandler = () => setIsTouched(true);

  return {
    hasError,
    valueChangeHandler,
    blurHandler,
    reset,
  };
}

export default useInput;
