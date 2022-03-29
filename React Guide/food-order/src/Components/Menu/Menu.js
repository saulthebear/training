import { useEffect, useState } from 'react';

import Card from '../UI/Card';
import MenuItem from './MenuItem';

function Menu() {
  const [menu, setMenu] = useState([]);
  const [isLoading, setIsLoading] = useState(false);
  const [httpError, setHttpError] = useState(null);

  useEffect(() => {
    const fetchMeals = async () => {
      setIsLoading(true);
      const response = await fetch(
        'https://reactguide-49a53-default-rtdb.firebaseio.com/meals.json'
      );

      if (!response.ok) {
        throw new Error('Something went wrong!');
      }

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
      setIsLoading(false);
    };

    fetchMeals().catch((error) => {
      setIsLoading(false);
      setHttpError(error.message);
    });
  }, []);

  if (isLoading) {
    return (
      <Card className="mx-auto w-[90%] max-w-5xl">
        <p className="text-center">Loading...</p>
      </Card>
    );
  }

  if (httpError) {
    return (
      <Card className="mx-auto w-[90%] max-w-5xl">
        <p className="text-center">{httpError}</p>
      </Card>
    );
  }

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
