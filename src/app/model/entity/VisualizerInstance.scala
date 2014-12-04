package model.entity

import model.repository.EagerBox
import org.joda.time.DateTime
import CustomUnicornPlay._
import CustomUnicornPlay.driver.simple._

case class VisualizerInstanceId(id: Long) extends AnyVal with BaseId
object VisualizerInstanceId extends IdCompanion[VisualizerInstanceId]

case class VisualizerInstanceEagerBox(visualizer: VisualizerInstance, component: Component) extends EagerBox[VisualizerInstance](visualizer)

case class VisualizerInstance(
  id: Option[VisualizerInstanceId],
  componentInstanceId: ComponentInstanceId,
  visualizerId: VisualizerId,
  var createdUtc: Option[DateTime] = None,
  var modifiedUtc: Option[DateTime] = None
) extends IdEntity[VisualizerInstanceId]


class VisualizerInstanceTable(tag: Tag) extends IdEntityTable[VisualizerInstanceId, VisualizerInstance](tag, "visualizer_instances") {

  def visualizer = foreignKey("fk_vit_dst_component_id", visualizerId, visualizersQuery)(_.id)

  def visualizerId = column[VisualizerId]("visualizer_id", O.NotNull)

  def * = (id.?, componentInstanceId, visualizerId, createdUtc, modifiedUtc) <> (VisualizerInstance.tupled, VisualizerInstance.unapply _)

  def componentInstance = foreignKey("fk_vit_cit_component_instance_id", componentInstanceId, componentInstancesQuery)(_.id)

  def componentInstanceId = column[ComponentInstanceId]("component_instance_id", O.NotNull)
}