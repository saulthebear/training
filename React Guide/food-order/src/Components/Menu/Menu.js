import Card from '../UI/Card';
import MenuItem from './MenuItem';

function Menu() {
  const menu = [
    {
      name: 'Sushi',
      description: 'Finest fish and veggies',
      priceInCents: 2999,
      id: Math.random(),
    },
    {
      name: 'Schnitzel',
      description: 'A German specialty!',
      priceInCents: 1650,
      id: Math.random(),
    },
    {
      name: 'BBQ Burger',
      description: 'American and meaty',
      priceInCents: 1299,
      id: Math.random(),
    },
    {
      name: 'Green Bowl',
      description: 'Healthy... and green...',
      priceInCents: 1899,
      id: Math.random(),
    },
  ];

  return (
    <Card className="max-w-5x mx-auto w-[90%]">
      {menu.map((item) => (
        <MenuItem
          key={item.id}
          name={item.name}
          description={item.description}
          priceInCents={item.priceInCents}
        />
      ))}
    </Card>
  );
}

export default Menu;
