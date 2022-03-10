import { useState } from 'react';

import Form from './components/Form';
import Users from './components/Users';

function App() {
  const [users, setUsers] = useState([
    { name: 'Max', age: 31 },
    { name: 'Stefan', age: 28 },
  ]);

  // setUsers([{ name: 'user1' }, { name: 'User 2' }]);

  return (
    <div className="flex h-full justify-center bg-slate-800">
      <div className="mt-10 flex h-fit w-8/12 flex-col gap-5">
        <Form />
        <Users users={users} />
      </div>
    </div>
  );
}

export default App;
