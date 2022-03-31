function Checkout(props) {
  const confirmHandler = (event) => {
    event.preventDefault();
  };

  return (
    <form onSubmit={confirmHandler}>
      <div className="mb-5 flex flex-col">
        <label htmlFor="name" className="mr-4 text-lg font-bold">
          Name
        </label>
        <input type="text" id="name" className="w-full rounded-md border-2" />
      </div>
      <div className="mb-5 flex flex-col">
        <label htmlFor="street" className="mr-4 text-lg font-bold">
          Street
        </label>
        <input
          type="text"
          name="street"
          id="street"
          className="w-full rounded-md border-2"
        />
      </div>
      <div className="mb-5 flex flex-col">
        <label htmlFor="postalCode" className="mr-4 text-lg font-bold">
          Postal Code
        </label>
        <input
          type="text"
          id="postalCode"
          className="w-full rounded-md border-2"
        />
      </div>
      <div className="mb-5 flex flex-col">
        <label htmlFor="city" className="mr-4 text-lg font-bold">
          City
        </label>
        <input
          type="text"
          name="city"
          id="city"
          className="w-full rounded-md border-2"
        />
      </div>
      <footer className="flex justify-end text-xl">
        <button
          type="button"
          onClick={props.onCancel}
          className="mr-5 rounded-full border-2 border-orange-900 px-8 py-1 text-orange-900 shadow-orange-900 last:mr-0"
        >
          Cancel
        </button>
        <button
          type="submit"
          className="mr-5 rounded-full bg-orange-900 px-8 py-1 text-white shadow-orange-900 last:mr-0"
        >
          Confirm
        </button>
      </footer>
    </form>
  );
}

export default Checkout;
