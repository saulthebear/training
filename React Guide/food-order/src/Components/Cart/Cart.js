import Card from '../UI/Card';
import Modal from '../UI/Modal';
import CartItem from './CartItem';

function Cart(props) {
  const cartItems = [
    {
      name: 'Sushi',
      description: 'Finest fish and veggies',
      priceInCents: 2999,
      amount: 2,
      id: Math.random(),
    },
    {
      name: 'Schnitzel',
      description: 'A German specialty!',
      priceInCents: 1650,
      amount: 1,
      id: Math.random(),
    },
  ];

  return (
    <Modal>
      {cartItems.map((item) => (
        <CartItem
          name={item.name}
          unitPrice={item.priceInCents}
          amount={item.amount}
          key={item.id}
        />
      ))}

      <div class="mb-6 flex justify-between border-t-2 border-orange-900 pt-3 text-3xl font-bold">
        <div>Total Amount</div>
        <div>$33.00</div>
      </div>

      <div class="flex justify-end text-xl">
        <button className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0">
          Close
        </button>
        <button className="mr-5 rounded-full bg-orange-900 px-8 py-1 text-white shadow-orange-900 last:mr-0">
          Order
        </button>
      </div>
    </Modal>
  );
}

export default Cart;
