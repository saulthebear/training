import { Link } from 'react-router-dom';
import { useParams, Route } from 'react-router-dom';

import Comments from '../components/comments/Comments';
import HighlightedQuote from '../components/quotes/HighlightedQuote';

const DUMMY_QUOTES = [
  {
    id: 'q1',
    author: 'Max',
    text: 'Learning React is fun!',
  },
  {
    id: 'q2',
    author: 'Maximilian',
    text: 'Learning React is great!',
  },
];

function Quote() {
  const params = useParams();
  const quote = DUMMY_QUOTES.find((quote) => quote.id === params.quoteId);

  if (!quote) {
    return <p>Quote not found</p>;
  }

  const quoteUrl = `/quotes/${params.quoteId}`;

  return (
    <section>
      <HighlightedQuote text={quote.text} author={quote.author} />
      <Route path={quoteUrl} exact>
        <div className="centered">
          <Link className="btn--flat" to={`${quoteUrl}/comments`}>
            Load Comments
          </Link>
        </div>
      </Route>
      <Route path={`${quoteUrl}/comments`}>
        <Comments />
      </Route>
    </section>
  );
}

export default Quote;
