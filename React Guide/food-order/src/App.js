import buffet from './buffet.jpg';

function App() {
  return (
    <div className="h-full bg-zinc-800 text-white">
      <nav className="flex justify-between bg-orange-700 py-7 px-20">
        <button className=" text-3xl font-bold">ReactMeals</button>
        <button className="rounded-full bg-orange-900 px-8 py-3 font-bold">
          Your Cart
          <span className="ml-5 rounded-full bg-orange-700 px-3 py-1">2</span>
        </button>
      </nav>
      <div className="h-96 overflow-hidden">
        <div
          style={{ backgroundImage: `url(${buffet})` }}
          className="clip-header-img h-full bg-cover bg-center bg-no-repeat"
        ></div>
      </div>
    </div>
  );
}

export default App;
