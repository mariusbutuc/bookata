// Leverage React hooks
import React, { useEffect, useReducer } from 'react';

// The GraphQL client used to interact with the AppSync endpoint (similar to `axios`)
import { API } from 'aws-amplify';

// UI component from the Ant Design library to render a list
import { List } from 'antd';
import 'antd/dist/antd.css';

// The GraphQL query operation for fetching an array of notes
import { listNotes } from './graphql/queries';

const initialState = {
  notes: [],
  loading: true,
  error: false,
  form: { name: '', description: '' },
};

function reducer(state, action) {
  switch (action.type) {
    case 'SET_NOTES':
      return { ...state, notes: action.notes, loading: false };
    case 'ERROR':
      return { ...state, loading: false, error: true };
    default:
      return state;
  }
}

export default function App() {
  const [state, dispatch] = useReducer(reducer, initialState);

  async function fetchNotes() {
    try {
      const notesData = await API.graphql({ query: listNotes });
      // NB: deep dot-notation access used (preferred?) in `notes` below over object destructuring 🤔
      dispatch({ type: 'SET_NOTES', notes: notesData.data.listNotes.items });
    } catch (err) {
      console.log('error: ', err);
      dispatch({ type: 'ERROR' });
    }
  }

  // NB: `useEffect` is similar to `componentDidMount`. `useEffect` will run after the initial render of the component
  //      is committed to the screen. The second argument to `useEffect` is an array of values, the effect of which
  //      depends on whether it is called again during a re-render. If the array is empty, it will not be called on
  //      additional renders. If the array contains values and those values change, the component will re-render.
  useEffect(() => {
    fetchNotes();
  }, []);

  function renderItem(item) {
    return (
      <List.Item style={styles.item}>
        <List.Item.Meta title={item.name} description={item.description} />
      </List.Item>
    );
  }

  return (
    <div style={styles.container}>
      <List
        loading={state.loading}
        dataSource={state.notes}
        renderItem={renderItem}
      />
    </div>
  );
}

const styles = {
  container: { padding: 20 },
  input: { marginBottom: 10 },
  item: { textAlign: 'left' },
  p: { color: '#1890ff' },
};
