import { useState } from 'react';

import Form from './components/Form';
import Modal from './components/UI/Modal';
import Users from './components/Users';

function App() {
  const [users, setUsers] = useState([
    { username: 'Max', age: 31, id: 1 },
    { username: 'Stefan', age: 28, id: 2 },
  ]);

  const addUserHandler = (user) => {
    setUsers((prevState) => [{ id: Math.random(), ...user }, ...prevState]);
  };

  const [isModalOpen, setIsModalOpen] = useState(false);
  const [modal, setModal] = useState();

  const closeModal = () => {
    setIsModalOpen(false);
  };

  const configureModal = (header, body, onClose) => {
    return (
      <Modal onClose={onClose} header={header}>
        {body}
      </Modal>
    );
  };

  const openModal = (header, content) => {
    setModal(configureModal(header, content, closeModal));
    setIsModalOpen(true);
  };

  return (
    <div className="flex h-full justify-center bg-slate-800">
      <div className="mt-10 flex h-fit w-8/12 flex-col gap-5">
        <Form onSubmit={addUserHandler} onError={openModal} />
        <Users users={users} />
        {isModalOpen && modal}
      </div>
    </div>
  );
}

export default App;
