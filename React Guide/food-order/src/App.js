import { useState } from 'react';

import Cart from './Components/Cart/Cart';
import Header from './Components/Header';
import Menu from './Components/Menu/Menu';
import Card from './Components/UI/Card';

function App() {
  const [isCartOpen, setIsCartOpen] = useState(false);

  const showCart = () => setIsCartOpen(true);
  const hideCart = () => setIsCartOpen(false);

  return (
    <div className="min-h-full bg-zinc-800 pb-10 text-lg text-white">
      {isCartOpen && <Cart hideCart={hideCart} />}

      <Header showCart={showCart} />

      <main>
        <Card
          className="relative mx-auto -mt-40 mb-10 flex w-3/4 max-w-3xl flex-col items-center text-center"
          bgColor="bg-zinc-700"
          textColor="text-white"
        >
          <h2 className="mb-5 text-2xl font-bold">
            Delicious Food, Delivered To You
          </h2>
          <p className="mb-4 max-w-prose">
            Choose your favorite meal from our broad selection of available
            meals and enjoy delicious lunch or dinner at home.
          </p>
          <p className=" max-w-prose">
            All our meals are cooked with high quality ingredients, just-in-time
            and of course by expereinced chefs!
          </p>
        </Card>

        <Menu />
      </main>
    </div>
  );
}

export default App;
