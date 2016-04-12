import { OrderedMap } from 'immutable'
import { createSelector } from 'reselect'
import prefix from '../prefix'
import createAction from '../../../../misc/createAction'
import moduleSelector from '../selector'
import { randomString } from '../../../../misc/utils'
import { NodeList } from '../models'

// Actions

export const ADD_LIST = prefix('ADD_LIST');
export function addList() {
  const id = randomString(5);
  return createAction(ADD_LIST, { id });
}

export const REMOVE_LIST = prefix('REMOVE_LIST');
export function removeList(id) {
  return createAction(REMOVE_LIST, { id });
}

export const UPDATE_LIST = prefix('UPDATE_LIST');
export function updateList(id, update) {
  return createAction(UPDATE_LIST, { id, update });
}

// Reducer

const initialState = new OrderedMap();

export default function listsReducer(state = initialState, action) {
  const { payload } = action;

  switch (action.type) {
    case ADD_LIST:
      return state.set(payload.id, new NodeList({ id: payload.id }));

    case REMOVE_LIST:
      return state.remove(payload.id);

    case UPDATE_LIST:
      return state.update(payload.id, list => list.mergeDeep(payload.update));
    
  } 
  
  return state;
}

// Selectors

export const listsSelector = createSelector(moduleSelector, state => state.lists);