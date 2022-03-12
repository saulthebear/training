function Card(props) {
  const classes = `rounded-xl shadow-lg ${props.bgColor || 'bg-slate-50'} ${
    props.p || 'p-10'
  } ${props.textColor || 'text-zinc-900'} ${props.className}`;

  return <div className={classes}>{props.children}</div>;
}

export default Card;
