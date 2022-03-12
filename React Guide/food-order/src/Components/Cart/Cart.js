import { useContext } from 'react';

import Modal from '../UI/Modal';
import CartItem from './CartItem';
import CartContext from '../../store/cart-context';

const handleOrder = () => {
  console.log('Ordering...');
};

function Cart(props) {
  const cartContext = useContext(CartContext);
  const cartItems = cartContext.items;
  const totalPrice = (cartContext.totalPrice / 100).toFixed(2);

  return (
    <Modal onClose={props.hideCart}>
      {cartItems.map((item) => (
        <CartItem
          name={item.name}
          unitPrice={item.unitPrice}
          quantity={item.quantity}
          key={item.id}
        />
      ))}

      <div className="mb-6 flex justify-between border-t-2 border-orange-900 pt-3 text-3xl font-bold">
        <div>Total Price</div>
        <div>${totalPrice}</div>
      </div>

      <div className="flex justify-end text-xl">
        <button
          onClick={props.hideCart}
          className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0"
        >
          Close
        </button>
        <button
          onClick={handleOrder}
          className="mr-5 rounded-full bg-orange-900 px-8 py-1 text-white shadow-orange-900 last:mr-0"
        >
          Order
        </button>
      </div>
    </Modal>
  );
}

export default Cart;
