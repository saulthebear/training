import buffet from './buffet.jpg';

function App() {
  return (
    <div className="min-h-full bg-zinc-800 pb-10 text-lg text-white">
      <header className="flex items-center justify-between bg-orange-700 py-7 px-20">
        <h1 className=" text-3xl font-bold">ReactMeals</h1>
        <button className="flex  items-center rounded-full bg-orange-900 px-8  py-3 font-bold">
          <span>
            <svg
              xmlns="http://www.w3.org/2000/svg"
              width="16"
              height="16"
              fill="currentColor"
              class="bi bi-cart3"
              viewBox="0 0 16 16"
            >
              <path d="M0 1.5A.5.5 0 0 1 .5 1H2a.5.5 0 0 1 .485.379L2.89 3H14.5a.5.5 0 0 1 .49.598l-1 5a.5.5 0 0 1-.465.401l-9.397.472L4.415 11H13a.5.5 0 0 1 0 1H4a.5.5 0 0 1-.491-.408L2.01 3.607 1.61 2H.5a.5.5 0 0 1-.5-.5zM3.102 4l.84 4.479 9.144-.459L13.89 4H3.102zM5 12a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm7 0a2 2 0 1 0 0 4 2 2 0 0 0 0-4zm-7 1a1 1 0 1 1 0 2 1 1 0 0 1 0-2zm7 0a1 1 0 1 1 0 2 1 1 0 0 1 0-2z" />
            </svg>
          </span>
          <span className="mx-3">Your Cart</span>
          <span className="rounded-full bg-orange-700 px-3 py-1">2</span>
        </button>
      </header>

      <div
        className="clip-slant z-0 h-72 w-full bg-cover bg-center bg-no-repeat"
        style={{ backgroundImage: `url(${buffet})` }}
      ></div>

      <div class="relative mx-auto -mt-40 mb-10 flex w-3/4 max-w-3xl flex-col items-center rounded-lg bg-zinc-700 p-10 text-center shadow-xl">
        <h2 className="mb-5 text-2xl font-bold">
          Delicious Food, Delivered To You
        </h2>
        <p className="mb-4 max-w-prose">
          Choose your favorite meal from our broad selection of available meals
          and enjoy delicious lunch or dinner at home.
        </p>
        <p className=" max-w-prose">
          All our meals are cooked with high quality ingredients, just-in-time
          and of course by expereinced chefs!
        </p>
      </div>

      <div className="mx-auto w-[90%] max-w-5xl rounded-lg bg-slate-50 p-10 text-zinc-900 shadow-xl">
        <div className="mb-3 flex justify-between border-b-2 pb-5 last:mb-0">
          <div className="flex flex-col">
            <p className=" text-2xl font-semibold">Sushi</p>
            <p className="italic">Finest fish and veggies</p>
            <p className="text-xl font-bold text-orange-700">$22.99</p>
          </div>
          <div className="flex flex-col items-center">
            <div className="mb-3">
              <label htmlFor="amount" className="mr-3 font-bold">
                Amount
              </label>
              <input
                type="number"
                name="amount"
                id="amount"
                min="0"
                step="1"
                className=" w-12 rounded-md border-2 border-zinc-300  text-center"
              />
            </div>
            <button className=" rounded-full bg-orange-700 px-8 py-1 font-bold text-white">
              + Add
            </button>
          </div>
        </div>

        <div className="mb-3 flex justify-between border-b-2 pb-5 last:mb-0">
          <div className="flex flex-col">
            <p className=" text-2xl font-semibold">Schnitzel</p>
            <p className="italic">A German specialty!</p>
            <p className="text-xl font-bold text-orange-700">$16.50</p>
          </div>
          <div className="flex flex-col items-center">
            <div className="mb-3">
              <label htmlFor="amount" className="mr-3 font-bold">
                Amount
              </label>
              <input
                type="number"
                name="amount"
                id="amount"
                min="0"
                step="1"
                className=" w-12 rounded-md border-2 border-zinc-300  text-center"
              />
            </div>
            <button className=" rounded-full bg-orange-700 px-8 py-1 font-bold text-white">
              + Add
            </button>
          </div>
        </div>
      </div>
    </div>
  );
}

export default App;
