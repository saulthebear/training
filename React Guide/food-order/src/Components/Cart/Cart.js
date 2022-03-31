import { useContext, useState, Fragment } from 'react';

import Modal from '../UI/Modal';
import CartItem from './CartItem';
import CartContext from '../../store/cart-context';
import Checkout from './Checkout';

function Cart(props) {
  const cartContext = useContext(CartContext);
  const cartItems = cartContext.items;
  const totalPrice = (cartContext.totalPrice / 100).toFixed(2);
  const hasItems = cartContext.items.length > 0;

  const [showOrderForm, setShowOrderForm] = useState(false);
  const [isSubmitting, setIsSubmitting] = useState(false);
  const [didSubmit, setDidSubmit] = useState(false);

  const handleOrder = () => {
    setShowOrderForm(true);
  };
  const itemSubtractHandler = (id) => {
    cartContext.removeItem(id);
  };
  const itemAddHandler = (item) => {
    const singleQuantityItem = { ...item, quantity: 1 };
    cartContext.addItem(singleQuantityItem);
  };

  const submitOrderHandler = async (userData) => {
    setIsSubmitting('true');

    await fetch(
      'https://reactguide-49a53-default-rtdb.firebaseio.com/orders.json',
      {
        method: 'POST',
        body: JSON.stringify({
          user: userData,
          orderedItems: cartContext.items,
        }),
      }
    );

    setIsSubmitting(false);
    setDidSubmit(true);
    cartContext.clearCart();
  };

  const modalActions = (
    <footer className="flex justify-end text-xl">
      <button
        onClick={props.hideCart}
        className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0"
      >
        Close
      </button>
      {hasItems && (
        <button
          onClick={handleOrder}
          className="mr-5 rounded-full bg-orange-900 px-8 py-1 text-white shadow-orange-900 last:mr-0"
        >
          Order
        </button>
      )}
    </footer>
  );

  const cartModalContent = (
    <Fragment>
      {cartItems.map((item) => (
        <CartItem
          key={item.id}
          onSubtract={itemSubtractHandler.bind(null, item.id)}
          onAdd={itemAddHandler.bind(null, item)}
          item={item}
        />
      ))}

      <div className="mb-6 flex justify-between border-t-2 border-orange-900 pt-3 text-3xl font-bold">
        {hasItems && (
          <Fragment>
            <div>Total Price</div>
            <div>${totalPrice}</div>
          </Fragment>
        )}
        {!hasItems && <p>No items in cart.</p>}
      </div>

      {showOrderForm && (
        <Checkout onCancel={props.hideCart} onConfirm={submitOrderHandler} />
      )}

      {!showOrderForm && modalActions}
    </Fragment>
  );

  const isSubmittingModalContent = <p>Submitting order...</p>;

  const didSubmitModalContent = (
    <Fragment>
      <p>Order submitted.</p>
      <footer className="flex justify-end text-xl">
        <button
          onClick={props.hideCart}
          className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0"
        >
          Close
        </button>
      </footer>
    </Fragment>
  );

  return (
    <Modal onClose={props.hideCart}>
      {!isSubmitting && !didSubmit && cartModalContent}
      {isSubmitting && isSubmittingModalContent}
      {didSubmit && didSubmitModalContent}
    </Modal>
  );
}

export default Cart;
