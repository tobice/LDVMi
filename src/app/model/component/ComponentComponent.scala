package model.component

import controllers.api.dto
import model.entity.{Component, ComponentId, ComponentTable}
import model.repository.ComponentRepository
import play.api.db.slick._

trait ComponentComponent extends CrudComponent[ComponentId, Component, ComponentTable, ComponentRepository] {

  def save(component: dto.Component)(implicit session: Session): ComponentId

}