import { useContext } from 'react';

import CartContext from '../../store/cart-context';
import CartIcon from '../Icons/CartIcon';

function Cart(props) {
  const cartContext = useContext(CartContext);
  const numberOfItems = cartContext.items.reduce(
    (currNumber, item) => currNumber + item.amount,
    0
  );

  return (
    <button
      className="flex  items-center rounded-full bg-orange-900 px-8  py-3 font-bold"
      onClick={props.showCart}
    >
      <CartIcon />

      <span className="mx-3">Your Cart</span>

      <span className="rounded-full bg-orange-700 px-3 py-1">
        {numberOfItems}
      </span>
    </button>
  );
}

export default Cart;
