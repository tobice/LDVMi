import React, { PropTypes } from 'react'
import { createStructuredSelector } from 'reselect'
import { connect } from 'react-redux'
import { labelEditorEnabledSelector } from '../ducks/labelEditor'
import ActivatedEditableLabel from '../components/ActivatedEditableLabel'
import Label from '../../core/containers/Label'

const EditableLabel = ({ dispatch, uri, label, editorEnabled }) => {

  // TODO: Here inject the custom label

  if (!editorEnabled) {
    return <Label uri={uri} label={label} />;
  }

  return (
    <ActivatedEditableLabel edit={() => alert('Hello!')}>
      <Label uri={uri} label={label} />
    </ActivatedEditableLabel>
  )
};

EditableLabel.propTypes = {
  uri: PropTypes.string.isRequired,
  label: PropTypes.any.isRequired,
  editorEnabled: PropTypes.bool.isRequired
};

const selector = createStructuredSelector({
  editorEnabled: labelEditorEnabledSelector
});

export default connect(selector)(EditableLabel);