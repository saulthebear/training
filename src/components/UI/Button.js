function Button(props) {
  const defaultClasses = 'w-fit rounded bg-purple-900 py-2 px-4 text-white ';
  const passedClasses = props.className;
  const combinedClasses = defaultClasses + passedClasses;
  return (
    <button
      type={props.type || 'button'}
      className={combinedClasses}
      onClick={props.onClick}
    >
      {props.children}
    </button>
  );
}

export default Button;
