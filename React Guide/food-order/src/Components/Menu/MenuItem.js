import { useRef, useContext } from 'react';

import CartContext from '../../store/cart-context';

function MenuItem(props) {
  const cartContext = useContext(CartContext);

  const quantityInputRef = useRef();

  const submitHandler = (event) => {
    event.preventDefault();
    const enteredQuantity = quantityInputRef.current.value;
    const enteredQuantityAsNumber = +enteredQuantity;

    const isEmpty = enteredQuantity.trim().length === 0;
    const isTooSmall = enteredQuantityAsNumber < 1;
    const isTooBig = enteredQuantityAsNumber > 5;

    if (isEmpty || isTooSmall || isTooBig) {
      return;
    }

    cartContext.addItem({
      id: props.id,
      name: props.name,
      quantity: enteredQuantityAsNumber,
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
          <label htmlFor={`quantity_${props.id}`} className="mr-3 font-bold">
            Quantity
          </label>
          <input
            ref={quantityInputRef}
            type="number"
            name="quantity"
            id={`quantity_${props.id}`}
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
