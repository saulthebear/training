import { useEffect, useState } from 'react';

import Card from '../UI/Card';
import MenuItem from './MenuItem';

function Menu() {
  const [menu, setMenu] = useState([]);

  useEffect(() => {
    const fetchMeals = async () => {
      const response = await fetch(
        'https://reactguide-49a53-default-rtdb.firebaseio.com/meals.json'
      );
      const responseData = await response.json();

      const loadedMeals = [];
      for (const key in responseData) {
        loadedMeals.push({
          id: key,
          name: responseData[key].name,
          description: responseData[key].description,
          priceInCents: responseData[key].priceInCents,
        });
      }

      setMenu(loadedMeals);
    };

    fetchMeals();
  }, []);

  const menuItems = menu.map((item) => (
    <li key={item.id} className="pb-5 last:pb-0">
      <MenuItem
        name={item.name}
        description={item.description}
        priceInCents={item.priceInCents}
        id={item.id}
      />
    </li>
  ));

  return (
    <Card className="mx-auto w-[90%] max-w-5xl">
      <ul>{menuItems}</ul>
    </Card>
  );
}

export default Menu;
