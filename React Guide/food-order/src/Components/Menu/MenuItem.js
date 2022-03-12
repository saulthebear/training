import { useRef, useContext } from 'react';

import CartContext from '../../store/cart-context';

function MenuItem(props) {
  const cartContext = useContext(CartContext);

  const amountInputRef = useRef();

  const submitHandler = (event) => {
    event.preventDefault();
    const enteredAmount = amountInputRef.current.value;
    const enteredAmountAsNumber = +enteredAmount;

    const isEmpty = enteredAmount.trim().length === 0;
    const isTooSmall = enteredAmountAsNumber < 1;
    const isTooBig = enteredAmountAsNumber > 5;

    if (isEmpty || isTooSmall || isTooBig) {
      return;
    }

    cartContext.addItem({
      id: props.id,
      name: props.name,
      amount: enteredAmountAsNumber,
      unitPrice: props.priceInCents,
    });
  };

  return (
    <div className="mb-3 flex justify-between border-b-2 pb-5 last:mb-0">
      <div className="flex flex-col">
        <p className=" text-2xl font-semibold">{props.name}</p>
        <p className="italic">{props.description}</p>
        <p className="text-xl font-bold text-orange-700">
          ${(props.priceInCents / 100).toFixed(2)}
        </p>
      </div>
      <form className="flex flex-col items-center" onSubmit={submitHandler}>
        <div className="mb-3">
          <label htmlFor={`amount_${props.id}`} className="mr-3 font-bold">
            Amount
          </label>
          <input
            ref={amountInputRef}
            type="number"
            name="amount"
            id={`amount_${props.id}`}
            min="1"
            step="1"
            defaultValue={1}
            className="w-12 rounded-md border-2 border-zinc-300  text-center"
          />
        </div>
        <button
          type="submit"
          className=" rounded-full bg-orange-700 px-8 py-1 font-bold text-white"
        >
          + Add
        </button>
      </form>
    </div>
  );
}

export default MenuItem;
