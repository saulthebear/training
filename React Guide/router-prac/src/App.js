import { Route, Switch, Redirect } from 'react-router-dom';
import NewQuote from './pages/NewQuote';
import Quote from './pages/Quote';
import Quotes from './pages/Quotes';

function App() {
  return (
    <div>
      <Switch>
        <Route path="/" exact>
          <Redirect to="/quotes" />
        </Route>
        <Route path="/quotes" exact>
          <Quotes />
        </Route>
        <Route path="/quotes/:quoteId">
          <Quote />
        </Route>
        <Route path="/new-quote">
          <NewQuote />
        </Route>
      </Switch>
    </div>
  );
}

export default App;
