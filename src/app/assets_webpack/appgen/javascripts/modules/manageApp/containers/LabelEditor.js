import React, { PropTypes } from 'react'
import { Map } from 'immutable'
import { connect } from 'react-redux'
import { createSelector, createStructuredSelector } from 'reselect'
import { dialogClose } from '../../core/ducks/dialog'
import { labelEditorResourceUriSelector } from '../ducks/labelEditor'
import { customLabelsSelector } from '../ducks/customLabels'
import { updateCustomLabel } from '../ducks/customLabels'
import LabelEditorDialog from '../dialogs/LabelEditorDialog'

function variantsFromValues(values) {
  const variants = {};
  for (let variant of values.variants) {
    variants[variant.lang] = variant.label;
  }
  return variants;
}

function variantsToValues(variants) {
  // variants is Immutable.Map which is not really consistent with the inverse function above
  // but whatever, it's immutable cause it comes from the state and the API is just so easy
  // to work with...
  return {
    variants: variants.map((label, lang) => ({ lang, label })).toList().toJS()
  }
}

const LabelEditor = ({ dispatch, resourceUri, variants }) => {

  const handleSubmit = values => {
    const variants = variantsFromValues(values);
    dispatch(updateCustomLabel(resourceUri, variants));
  };

  const initialValues = variantsToValues(variants);
  console.log(initialValues);

  return <LabelEditorDialog
      resourceUri={resourceUri}
      dialogClose={dialogName => dispatch(dialogClose(dialogName))}
      onSubmit={handleSubmit}
      initialValues={initialValues}
    />
};

LabelEditor.propTypes = {
  dispatch: PropTypes.func.isRequired,
  resourceUri: PropTypes.string.isRequired,
  variants: PropTypes.instanceOf(Map).isRequired
};

const variantsSelector = createSelector(
  [labelEditorResourceUriSelector, customLabelsSelector],
  (resourceUri, customLabels) => customLabels.getIn([resourceUri, 'variants']) || new Map()
);

const selector = createStructuredSelector({
  resourceUri: labelEditorResourceUriSelector,
  variants: variantsSelector
});

export default connect(selector)(LabelEditor)