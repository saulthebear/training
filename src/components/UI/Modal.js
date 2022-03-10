import { Fragment } from 'react';
import Button from './Button';
import Card from './Card';

function Modal(props) {
  const closeHandler = () => {
    props.onClose();
  };

  return (
    <Fragment>
      <div
        className={
          'absolute inset-0 flex h-full w-full justify-center bg-slate-900/50'
        }
      >
        <div className="mt-20 w-8/12">
          <Card header={props.header}>
            <div className="flex flex-col">
              {props.children}
              <Button className="self-end" onClick={closeHandler}>
                Okay
              </Button>
            </div>
          </Card>
        </div>
      </div>
    </Fragment>
  );
}

export default Modal;
