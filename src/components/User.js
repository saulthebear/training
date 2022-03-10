function User(props) {
  return (
    <li className="mb-3 border border-slate-300 bg-white p-2 last:mb-0">
      {props.user.username} ({props.user.age} years old)
    </li>
  );
}

export default User;
