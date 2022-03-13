function CartItem(props) {
  return (
    <div className="mb-6 flex w-full items-center justify-between">
      <div className="flex flex-col">
        <div className="mb-1 text-2xl font-bold">{props.item.name}</div>
        <div className="flex justify-between">
          <div className="mr-10 font-semibold text-orange-900">
            ${(props.item.unitPrice / 100).toFixed(2)}
          </div>
          <div className="rounded-md  border-2 px-3 py-1 text-sm font-bold">
            x{props.item.quantity}
          </div>
        </div>
      </div>
      <div>
        <div className="flex">
          <button
            onClick={props.onSubtract}
            className="mr-3 rounded-md border-2 border-orange-900 px-5 text-lg font-bold text-orange-900"
          >
            -
          </button>
          <button
            onClick={props.onAdd}
            className="mr-3 rounded-md border-2 border-orange-900 px-5 text-lg font-bold text-orange-900"
          >
            +
          </button>
        </div>
      </div>
    </div>
  );
}

export default CartItem;
