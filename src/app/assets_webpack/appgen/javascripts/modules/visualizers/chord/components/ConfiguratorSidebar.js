import React from 'react'
import Paper from 'material-ui/lib/paper'
import ListsManagerContainer from '../containers/ListsManagerContainer'
import SelectedListManager from '../containers/SelectedListManager'

const ConfiguratorSidebar = () => {
  return (
    <Paper zDepth={2}>
      <ListsManagerContainer />
      <SelectedListManager />
    </Paper>
  )
};

export default ConfiguratorSidebar;