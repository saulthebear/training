import CartIcon from '../Icons/CartIcon';

function Cart(props) {
  return (
    <button className="flex  items-center rounded-full bg-orange-900 px-8  py-3 font-bold">
      <span>
        <CartIcon />
      </span>
      <span className="mx-3">Your Cart</span>
      <span className="rounded-full bg-orange-700 px-3 py-1">
        {props.itemCount}
      </span>
    </button>
  );
}

export default Cart;
