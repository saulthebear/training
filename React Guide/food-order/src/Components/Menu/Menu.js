import Card from '../UI/Card';
import MenuItem from './MenuItem';

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

function Menu() {
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
    <Card className="max-w-5x mx-auto w-[90%]">
      <ul>{menuItems}</ul>
    </Card>
  );
}

export default Menu;
