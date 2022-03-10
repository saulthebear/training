function Card(props) {
  return (
    <div className="overflow-scroll rounded-lg">
      {props.header && (
        <div className="bg-purple-700 px-4 py-5 font-bold text-white">
          {props.header}
        </div>
      )}
      <div className="bg-slate-100 px-4 py-5">{props.children}</div>
    </div>
  );
}

export default Card;
