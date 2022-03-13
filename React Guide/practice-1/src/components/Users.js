import Card from './UI/Card';
import User from './User';

function Users(props) {
  const userComponents = props.users.map((user) => (
    <User user={user} key={user.id} />
  ));

  return (
    <Card>
      <ul>{userComponents}</ul>
    </Card>
  );
}

export default Users;
