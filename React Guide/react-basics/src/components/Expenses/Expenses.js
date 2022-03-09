import { useState } from 'react';

import ExpensesFilter from './ExpensesFilter';
import ExpensesList from './ExpensesList';
import Card from '../UI/Card';

import './Expenses.css';
import ExpensesChart from './ExpensesChart';

function Expenses(props) {
  const [filterYear, setFilterYear] = useState('2019');

  const filteredExpenses = props.items.filter((expense) => {
    const expenseYear = expense.date.getFullYear().toString();
    return expenseYear === filterYear;
  });

  const filterChangeHandler = (year) => {
    setFilterYear(year);
  };

  return (
    <Card className="expenses">
      <ExpensesFilter
        onFilterChange={filterChangeHandler}
        selectedYear={filterYear}
      />

      <ExpensesChart expenses={filteredExpenses} />

      <ExpensesList expenses={filteredExpenses} />
    </Card>
  );
}

export default Expenses;
