function Card(props) {
  return (
    <div className="rounded-lg bg-slate-100 px-4 py-5">{props.children}</div>
  );
}

export default Card;
