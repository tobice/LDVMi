import React, { Component, PropTypes } from 'react'
import { List } from 'immutable'
import { connect } from 'react-redux'
import { createStructuredSelector } from 'reselect'
import { getSampleNodes } from '../ducks/sampleNodeUris'
import { PromiseStatus } from '../../../core/models'
import PromiseResult from '../../../core/components/PromiseResult'
import { Graph } from "../models";
import D3ChordContainer from './D3ChordContainer'
import Alert from '../../../../components/Alert'
import { graphSelector } from "../ducks/graph";
import { sampleNodeUrisSelector, sampleNodeUrisStatusSelector } from "../ducks/sampleNodeUris";
import { applicationSelector } from "../../../manageApp/ducks/application";
import { Application } from "../../../manageApp/models";

class SampleVisualization extends Component {
  static propTypes = {
    dispatch: PropTypes.func.isRequired,
    application: PropTypes.instanceOf(Application).isRequired,
    graph: PropTypes.instanceOf(Graph).isRequired,
    nodeUris: PropTypes.instanceOf(List).isRequired,
    status: PropTypes.instanceOf(PromiseStatus).isRequired
  };

  componentWillMount() {
    const { dispatch, application } = this.props;
    dispatch(getSampleNodes(application.id));
  }

  render() {
    const { graph, nodeUris, status } = this.props;

    if (!status.done) {
      return <PromiseResult status={status} loadingMessage="Loading sample graph nodes..."/>
    }

    return <div>
      {graph.nodeCount > nodeUris.size &&
        <Alert warning>
          This is just a sample visualization based on a random subset of the data!
        </Alert>
      }
      <D3ChordContainer nodeUris={nodeUris} />
    </div>
  }
}

const selector = createStructuredSelector({
  application: applicationSelector,
  graph: graphSelector,
  nodeUris: sampleNodeUrisSelector,
  status: sampleNodeUrisStatusSelector
});

export default connect(selector)(SampleVisualization)