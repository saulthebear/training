import ReactDOM from 'react-dom';
import { Fragment } from 'react';

import Card from './Card';

function Modal(props) {
  return (
    <Fragment>
      {ReactDOM.createPortal(
        <div className="fixed inset-0">
          <div className="absolute inset-0 z-40 bg-slate-900/70 backdrop-blur-sm"></div>
          <Card className="relative top-1/3 z-50 m-auto w-[90%] max-w-5xl">
            {props.children}
          </Card>
        </div>,
        document.getElementById('overlays')
      )}
    </Fragment>
  );
}

export default Modal;
