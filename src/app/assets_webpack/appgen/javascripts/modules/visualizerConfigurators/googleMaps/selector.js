import { createSelector } from 'reselect'
import parentSelector from '../selector'
import { MODULE_PREFIX } from './prefix'
import { Filter, Option } from './models'

/** Select state of this module */
export const moduleSelector = createSelector(
  [parentSelector],
  parentState => parentState[MODULE_PREFIX]
);
export default moduleSelector;

