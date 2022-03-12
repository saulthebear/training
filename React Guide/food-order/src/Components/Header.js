import Cart from './Cart/CartButton';
function Header() {
  return (
    <header className="flex items-center justify-between bg-orange-700 py-7 px-20">
      <h1 className=" text-3xl font-bold">ReactMeals</h1>
      <Cart itemCount={2} />
    </header>
  );
}

export default Header;
