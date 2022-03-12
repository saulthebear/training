import { Fragment } from 'react';

import Cart from './Cart/CartButton';

import buffet from '../buffet.jpg';

function Header() {
  return (
    <Fragment>
      <header className="flex items-center justify-between bg-orange-700 py-7 px-20">
        <h1 className=" text-3xl font-bold">ReactMeals</h1>
        <Cart itemCount={2} />
      </header>

      <div
        className="clip-slant z-0 h-72 w-full bg-cover bg-center bg-no-repeat"
        style={{ backgroundImage: `url(${buffet})` }}
      ></div>
    </Fragment>
  );
}

export default Header;
