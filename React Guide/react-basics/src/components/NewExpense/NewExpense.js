import { useState } from 'react';

import ExpenseForm from './ExpenseForm';

import './NewExpense.css';

function NewExpense(props) {
  const [isFormOpen, setIsFormOpen] = useState(false);

  const openFormHandler = () => {
    setIsFormOpen(true);
  };

  const closeFormHandler = () => {
    setIsFormOpen(false);
  };

  const saveExpenseDataHandler = (enteredExpenseData) => {
    const expenseData = {
      ...enteredExpenseData,
      id: Math.random().toString(),
    };
    props.onAddExpense(expenseData);

    closeFormHandler();
  };

  let content = <button onClick={openFormHandler}>Add an Expense</button>;

  if (isFormOpen) {
    content = (
      <ExpenseForm
        onSaveExpenseData={saveExpenseDataHandler}
        onCancel={closeFormHandler}
      />
    );
  }

  return <div className="new-expense">{content}</div>;
}

export default NewExpense;
