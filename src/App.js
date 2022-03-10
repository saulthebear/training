import { useState } from 'react';

import Form from './components/Form';
import Users from './components/Users';

function App() {
  const [users, setUsers] = useState([
    { username: 'Max', age: 31, id: 1 },
    { username: 'Stefan', age: 28, id: 2 },
  ]);

  const addUserHandler = (user) => {
    setUsers((prevState) => [{ id: Math.random(), ...user }, ...prevState]);
  };

  // setUsers([{ name: 'user1' }, { name: 'User 2' }]);

  return (
    <div className="flex h-full justify-center bg-slate-800">
      <div className="mt-10 flex h-fit w-8/12 flex-col gap-5">
        <Form onSubmit={addUserHandler} />
        <Users users={users} />
      </div>
    </div>
  );
}

export default App;
