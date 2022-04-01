import { useParams, Route } from 'react-router-dom';

import Comments from '../components/comments/Comments';

function Quote() {
  const params = useParams();
  return (
    <section>
      <h1>Quote details...</h1>
      <p>{params.quoteId}</p>
      <Route path="/quote/:quoteId/comments">
        <Comments />
      </Route>
    </section>
  );
}

export default Quote;
