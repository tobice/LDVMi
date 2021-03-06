package model

import scala.slick.lifted.TableQuery

package object entity {

  val componentTemplatesQuery = TableQuery[ComponentTemplateTable]
  val analyzerTemplatesQuery = TableQuery[AnalyzerTemplateTable]
  val transformerTemplatesQuery = TableQuery[TransformerTemplateTable]
  val visualizerTemplatesQuery = TableQuery[VisualizerTemplateTable]
  val dataSourceTemplatesQuery = TableQuery[DataSourceTemplateTable]

  val visualizationConfigurationsQuery = TableQuery[VisualizationConfigurationTable]

  val componentFeaturesQuery = TableQuery[FeatureToComponentTable]
  val featuresQuery = TableQuery[FeatureTable]
  val bindingSetsQuery = TableQuery[DataPortBindingSetTable]
  val bindingsQuery = TableQuery[DataPortBindingTable]
  val nestedBindingsQuery = TableQuery[NestedDataPortBindingTable]

  val pipelineDiscoveriesQuery = TableQuery[PipelineDiscoveryTable]
  val pipelineEvaluationQuery = TableQuery[PipelineEvaluationTable]
  val pipelineEvaluationQueryQuery = TableQuery[PipelineEvaluationQueryTable]
  val pipelineEvaluationResultsQuery = TableQuery[PipelineEvaluationResultTable]
  val pipelinesQuery = TableQuery[PipelineTable]

  val dataPortTemplatesQuery = TableQuery[DataPortTemplateTable]
  val outputTemplatesQuery = TableQuery[OutputTemplateTable]
  val inputTemplatesQuery = TableQuery[InputTemplateTable]

  val componentInstancesQuery = TableQuery[ComponentInstanceTable]
  val analyzerInstancesQuery = TableQuery[AnalyzerInstanceTable]
  val transformerInstancesQuery = TableQuery[TransformerInstanceTable]
  val visualizerInstancesQuery = TableQuery[VisualizerInstanceTable]
  val dataSourceInstancesQuery = TableQuery[DataSourceInstanceTable]

  val componentInstanceMembershipQuery = TableQuery[ComponentInstanceMembershipTable]

  val dataPortBindingSetsQuery = TableQuery[DataPortBindingSetTable]
  val dataPortBindingsQuery = TableQuery[DataPortBindingTable]
  val dataPortInstancesQuery = TableQuery[DataPortInstanceTable]
  val inputInstancesQuery = TableQuery[InputInstanceTable]
  val outputInstancesQuery = TableQuery[OutputInstanceTable]

  val descriptorsQuery = TableQuery[DescriptorTable]

}
