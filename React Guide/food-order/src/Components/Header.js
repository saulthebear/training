import { Fragment } from 'react';

import CartButton from './Cart/CartButton';

import buffet from '../buffet.jpg';

function Header(props) {
  return (
    <Fragment>
      <header className="flex items-center justify-between bg-orange-700 py-7 px-20">
        <h1 className=" text-3xl font-bold">ReactMeals</h1>
        <CartButton itemCount={2} showCart={props.showCart} />
      </header>

      <div
        className="clip-slant z-0 h-72 w-full bg-cover bg-center bg-no-repeat"
        style={{ backgroundImage: `url(${buffet})` }}
      ></div>
    </Fragment>
  );
}

export default Header;
