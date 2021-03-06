package model.appgen.rest

import model.appgen.entity.User
import play.api.db.slick.Session
import play.api.mvc._
import play.api.libs.json.JsValue

sealed case class RestRequestWithUser(
  dbSession: Session,
  user: User,
  private val request: Request[JsValue]) extends WrappedRequest(request)

