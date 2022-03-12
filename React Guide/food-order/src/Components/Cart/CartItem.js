function CartItem(props) {
  return (
    <div className="mb-6 flex w-full items-center justify-between">
      <div className="flex flex-col">
        <div className="mb-1 text-2xl font-bold">{props.name}</div>
        <div class="flex justify-between">
          <div class="mr-10 font-semibold text-orange-900">
            ${(props.unitPrice / 100).toFixed(2)}
          </div>
          <div class="rounded-md  border-2 px-3 py-1 text-sm font-bold">
            x{props.amount}
          </div>
        </div>
      </div>
      <div>
        <div className="flex">
          <button className="mr-3 rounded-md border-2 border-orange-900 px-5 text-lg font-bold text-orange-900">
            -
          </button>
          <button className="mr-3 rounded-md border-2 border-orange-900 px-5 text-lg font-bold text-orange-900">
            +
          </button>
        </div>
      </div>
    </div>
  );
}

export default CartItem;
