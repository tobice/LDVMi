package model.service.impl

import model.entity._
import model.service.CompatibilityService
import model.service.component.{BindingContext, InternalComponent, InternalComponent$}
import play.api.db.slick._
import scaldi.{Injectable, Injector}

class CompatibilityServiceImpl(implicit inj: Injector) extends CompatibilityService with Injectable {

  def check(bindingSet: DataPortBindingSet)(implicit session: Session) = {
    val componentInstances = bindingSet.componentInstances

    componentInstances.map { componentInstance =>
      InternalComponent(componentInstance).check(BindingContext(bindingSet))
    }

  }
}