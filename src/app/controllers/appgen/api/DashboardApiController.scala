package controllers.appgen.api

import play.api.mvc._
import controllers.api.JsonImplicits._
import controllers.appgen.api.JsonImplicits._
import controllers.appgen.api.rest.SecuredRestController
import model.appgen.entity.Visualizer.Visualizer
import model.appgen.entity.{Discovery, UserDataSource, UserDataSourceId, UserPipelineDiscoveryId}
import model.appgen.repository.UserDataSourcesRepository
import model.appgen.rest.AddVisualizerRequest._
import model.appgen.rest.UpdateVisualizerRequest._
import model.appgen.rest.EmptyRequest.EmptyRequest
import model.appgen.rest.PaginatedRequest._
import scaldi.Injector
import model.appgen.rest.Response._
import model.appgen.rest.RestRequestWithUser
import model.appgen.rest.UpdateDataSourceRequest.UpdateDataSourceRequest
import model.appgen.service.{ApplicationsService, DiscoveriesService, VisualizerService}
import model.entity.VisualizationConfigurationId
import model.repository.ComponentTemplateRepository
import org.h2.constant.ErrorCode
import org.h2.jdbc.JdbcSQLException

import scala.util.{Failure, Success}

class DashboardApiController(implicit inj: Injector) extends SecuredRestController {
  val applicationsService = inject[ApplicationsService]
  val discoveriesService = inject[DiscoveriesService]
  val userDataSourcesRepository = inject[UserDataSourcesRepository]
  val visualizerService = inject[VisualizerService]
  val componentTemplateRepository = inject[ComponentTemplateRepository]

  def getApplications = RestAction[PaginatedRequest] { implicit request => json =>
    Ok(SuccessResponse(data = Seq(
      "items" -> applicationsService.findByUser(request.user, json.paginationInfo).map(_.removeConfiguration),
      "totalCount" -> applicationsService.countByUser(request.user)
    )))
  }

  def getDiscoveries = RestAction[PaginatedRequest] { implicit request => json =>
    Ok(SuccessResponse(data = Seq(
      "items" -> discoveriesService.findByUser(request.user, json.paginationInfo),
      "totalCount" -> discoveriesService.countByUser(request.user)
    )))
  }

  def getDiscovery(id: Long) = RestAction[EmptyRequest] { implicit request => json =>
    withDiscovery(UserPipelineDiscoveryId(id)) { discovery =>
      Ok(SuccessResponse(data = Seq("discovery" -> discovery)))
    }
  }

  def deleteDiscovery(id: Long) = RestAction[EmptyRequest] { implicit request => json =>
    withDiscovery(UserPipelineDiscoveryId(id)) { discovery =>
      discoveriesService.delete(discovery)
      Ok(SuccessResponse("The discovery has been deleted"))
    }
  }

  def deleteAllDiscoveries = RestAction[EmptyRequest] { implicit request => json =>
    discoveriesService.findByUser(request.user).foreach(discovery =>
      discoveriesService.delete(discovery))
    Ok(SuccessResponse("All discoveries have been deleted"))
  }

  private def withDiscovery(id: UserPipelineDiscoveryId)
    (func: (Discovery) => Result)
    (implicit request: RestRequestWithUser): Result = {
    discoveriesService.findById(request.user, id) match {
      case Some(discovery) => func(discovery)
      case None => BadRequest(ErrorResponse("The discovery does not exist or is not accessible"))
    }
  }

  def getDataSources = RestAction[PaginatedRequest] { implicit request => json =>
    Ok(SuccessResponse(data = Seq(
      "items" -> userDataSourcesRepository.findByUser(request.user, json.paginationInfo),
      "totalCount" -> userDataSourcesRepository.countByUser(request.user)
    )))
  }

  def deleteDataSource(id: Long) = RestAction[EmptyRequest] { implicit request => json =>
    withUserDataSource(UserDataSourceId(id)) { userDataSource =>
      // Here we're also deleting just the user meta data which is part of appgen. The actual
      // LDVM component remains untouched.
      userDataSourcesRepository.deleteById(userDataSource.id.get)
      Ok(SuccessResponse("The data source has been deleted"))
    }
  }

  def updateDataSource(id: Long) = RestAction[UpdateDataSourceRequest] { implicit request => json =>
    withUserDataSource(UserDataSourceId(id)) { userDataSource =>
      userDataSourcesRepository.save(userDataSource.copy(name = json.name, isPublic = json.isPublic))
      Ok(SuccessResponse("The data source has been updated"))
    }
  }

  private def withUserDataSource(id: UserDataSourceId)
    (func: (UserDataSource) => Result)
    (implicit request: RestRequestWithUser): Result = {
    userDataSourcesRepository.findById(request.user, id) match {
      case Some(userDataSource) => func(userDataSource)
      case None => BadRequest(ErrorResponse("The data source does not exist or is not accessible"))
    }
  }

  def getVisualizerComponents = RestAction[EmptyRequest] { implicit request => json =>
    val visualizerComponents = visualizerService.getVisualizerComponents
    Ok(SuccessResponse(data = Seq("visualizerComponents" -> visualizerComponents)))
  }

  def addVisualizer = RestAction[AddVisualizerRequest] { implicit request => json =>
    // Send back error response with the form field validation message
    def fail(message: String) = BadRequest(ErrorResponse(message,
      Seq("componentTemplateUri" -> message)))

    requireAdmin {
      componentTemplateRepository.findByUri(json.componentTemplateUri) map { component =>
        visualizerService.addVisualizer(component) match {
          case Success(visualizer) =>
            Ok(SuccessResponse("The visualizer has been created", data = Seq("visualizer" -> visualizer)))
          case Failure(e: JdbcSQLException) =>
            if (e.getErrorCode == ErrorCode.DUPLICATE_KEY_1)
              fail("A visualizer for this component already exists")
            else
              fail(e.getMessage)
          case Failure(e) => fail(e.getMessage)
        }
      } getOrElse {
        fail("Adding failed. Probably invalid component URI.")
      }
    }
  }

  def deleteVisualizer(id: Long) = RestAction[EmptyRequest] { implicit request => json =>
    requireAdmin {
      withVisualizer(VisualizationConfigurationId(id)) { visualizer =>
        visualizerService.deleteVisualizer(visualizer)
        Ok(SuccessResponse("The visualizer has been deleted"))
      }
    }
  }

  def updateVisualizer(id: Long) = RestAction[UpdateVisualizerRequest] { implicit request => json =>
    requireAdmin {
      withVisualizer(VisualizationConfigurationId(id)) { visualizer =>
        visualizerService.updateVisualizer(visualizer, json)
        Ok(SuccessResponse("The visualizer has been updated"))
      }
    }
  }

  private def withVisualizer(id: VisualizationConfigurationId)
    (func: (Visualizer) => Result)
    (implicit request: RestRequestWithUser): Result = {
    visualizerService.getVisualizer(id) match {
      case Some(visualizer) => func(visualizer)
      case None => BadRequest(ErrorResponse("The visualizer does not exist"))
    }
  }

  private def requireAdmin(func: => Result)(implicit request: RestRequestWithUser): Result = {
    if (request.user.isAdmin)
      func
    else
      Unauthorized(ErrorResponse("You need to be administrator to perform this operation"))
  }
}
