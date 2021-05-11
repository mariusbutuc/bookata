import React, { useEffect, useReducer } from 'react';

// Leverage the UUID library to create a unique identifier for the client.
// This way, later on when we implement subscriptions we can identify the client that created the Note.
import { v4 as uuid } from 'uuid';

// The GraphQL client used to interact with the AppSync endpoint (similar to `axios`)
import { API } from 'aws-amplify';

import { List, Input, Button } from 'antd';
import 'antd/dist/antd.css';

// The GraphQL query operation for fetching an array of notes
import { listNotes } from './graphql/queries';

// The GraphQL mutation operation for creating a new Note
// TODO: Understand why we use the "class name" alias below. Because of the `createNote` function?
//       And why not for the `listNotes` query operation?
import {
  createNote as CreateNote,
  deleteNote as DeleteNote,
  updateNote as UpdateNote,
} from './graphql/mutations';

const CLIENT_ID = uuid();

const ADD_NOTE_EVENT = 'ADD_NOTE';
const ERROR_EVENT = 'ERROR';
const RESET_FORM_EVENT = 'RESET_FORM';
const SET_INPUT_EVENT = 'SET_INPUT';
const SET_NOTES_EVENT = 'SET_NOTES';

const initialState = {
  notes: [],
  loading: true,
  error: false,
  form: { name: '', description: '' },
};

function reducer(state, action) {
  switch (action.type) {
    case ADD_NOTE_EVENT:
      return { ...state, notes: [action.note, ...state.notes] };
    case SET_NOTES_EVENT:
      return { ...state, notes: action.notes, loading: false };
    case SET_INPUT_EVENT:
      return { ...state, form: { ...state.form, [action.name]: action.value } };
    case RESET_FORM_EVENT:
      return { ...state, form: initialState.form };
    case ERROR_EVENT:
      return { ...state, error: true, loading: false };
    default:
      return state;
  }
}

export default function App() {
  const [state, dispatch] = useReducer(reducer, initialState);

  async function createNote() {
    const { form } = state;
    if (!form.name || !form.description) {
      // TODO: Consider dispatching an Error here?
      // dispatch({ type: ERROR_EVENT });
      return alert('Please enter a name and description');
    }

    const note = { ...form, clientId: CLIENT_ID, completed: false, id: uuid() };
    dispatch({ type: ADD_NOTE_EVENT, note });
    dispatch({ type: RESET_FORM_EVENT });
    try {
      await API.graphql({
        query: CreateNote,
        variables: { input: note },
      });
      console.log('Note created successfully!');
    } catch (err) {
      console.log('error: ', err);
      // TODO: Consider dispatching an Error here?
      // dispatch({ type: ERROR_EVENT });
    }
  }

  async function deleteNote({ id }) {
    const index = state.notes.findIndex((note) => note.id === id);
    const notes = [
      ...state.notes.slice(0, index),
      ...state.notes.slice(index + 1),
    ];
    // update local state & show an optimistic response
    dispatch({ type: SET_NOTES_EVENT, notes });

    try {
      await API.graphql({ query: DeleteNote, variables: { input: { id } } });
      console.log('Note deleted successfully!');
    } catch (err) {
      console.log('error: ', err);
      // TODO: Consider dispatching an Error here?
      // dispatch({ type: ERROR_EVENT });
    }
  }

  async function updateNote(note) {
    const index = state.notes.findIndex((n) => n.id === note.id);
    // Create a copy of the `notes` array
    const notes = [...state.notes];
    // Update the `completed` value of the selected `note` to be the opposite of what it currently is
    notes[index].completed = !note.completed;
    dispatch({ type: SET_NOTES_EVENT, notes });

    try {
      await API.graphql({
        query: UpdateNote,
        variables: {
          input: { id: note.id, completed: notes[index].completed },
        },
      });
      console.log('Note updated successfully!');
    } catch (err) {
      console.log('error: ', err);
      // TODO: Consider dispatching an Error here?
      // dispatch({ type: ERROR_EVENT });
    }
  }

  async function fetchNotes() {
    try {
      const notesData = await API.graphql({ query: listNotes });
      // NB: deep dot-notation access used (preferred?) in `notes` below over object destructuring 🤔
      dispatch({
        type: SET_NOTES_EVENT,
        notes: notesData.data.listNotes.items,
      });
    } catch (err) {
      console.log('error: ', err);
      dispatch({ type: ERROR_EVENT });
    }
  }

  // NB: `useEffect` is similar to `componentDidMount`. `useEffect` will run after the initial render of the component
  //      is committed to the screen. The second argument to `useEffect` is an array of values, the effect of which
  //      depends on whether it is called again during a re-render. If the array is empty, it will not be called on
  //      additional renders. If the array contains values and those values change, the component will re-render.
  useEffect(() => {
    fetchNotes();
  }, []);

  function onChange(e) {
    dispatch({
      type: SET_INPUT_EVENT,
      name: e.target.name,
      value: e.target.value,
    });
  }

  function renderItem(item) {
    return (
      <List.Item
        style={styles.item}
        actions={[
          <p style={styles.p} onClick={() => deleteNote(item)}>
            Delete
          </p>,
          <p style={styles.p} onClick={() => updateNote(item)}>
            {item.completed ? 'completed' : 'mark completed'}
          </p>,
        ]}
      >
        <List.Item.Meta title={item.name} description={item.description} />
      </List.Item>
    );
  }

  return (
    <div style={styles.container}>
      <Input
        onChange={onChange}
        value={state.form.name}
        placeholder="Note name"
        name="name"
        style={styles.input}
      />
      <Input
        onChange={onChange}
        value={state.form.description}
        placeholder="Note description"
        name="description"
        style={styles.input}
      />
      <Button onClick={createNote} type="primary">
        Create Note
      </Button>
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
