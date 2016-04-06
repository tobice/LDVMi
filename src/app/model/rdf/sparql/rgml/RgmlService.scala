package model.rdf.sparql.rgml

import model.entity.PipelineEvaluation
import play.api.db.slick.Session

trait RgmlService {
  def edges(evaluation: PipelineEvaluation)(implicit session: Session): Option[Seq[Edge]]
  def matrix(evaluation: PipelineEvaluation)(implicit session: Session): Option[List[List[Int]]]
}