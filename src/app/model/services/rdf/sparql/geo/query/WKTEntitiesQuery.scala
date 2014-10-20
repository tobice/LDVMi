package model.services.rdf.sparql.geo.query

import model.services.rdf.sparql.geo.WKTQueryData
import model.services.rdf.sparql.query.SparqlQuery
import model.services.rdf.sparql.{ValueFilter, VariableGenerator}


class WKTEntitiesQuery(queryData: WKTQueryData) extends SparqlQuery {

  lazy val variableGenerator = new VariableGenerator

  def get: String = {
    val q = prefixes +
      """
        | SELECT ?s ?p %v WHERE {
        |   ?s <http://www.opengis.net/ont/geosparql#hasGeometry> ?g .
        |   ?g <http://www.opengis.net/ont/geosparql#asWKT> ?p .
        |
        |   %r
        | }
      """
        .replaceAll(
          "%r", getRestrictions(queryData.filters))
        .replaceAll("%v", if (queryData.filters.nonEmpty) { "?v1" } else {"" })
        .stripMargin
    q
  }

  private def prefixes =
    """
      |

    """.stripMargin

  private def getRestrictions(rule: Map[String, Seq[ValueFilter]]): String = {
    rule.map { case (uri, valueFilters) =>
      """
        |  ?s <%s> %v
        |  %rf
      """
        .replaceAll("%s", uri)
        .replaceAll("%v", variableGenerator.next.getVariable)
        .replaceAll("%rf", restrictionFilters(variableGenerator.getVariable, valueFilters))
        .stripMargin
    }.mkString("\n")
  }

  private def restrictionFilters(variable: String, filters: Seq[ValueFilter]): String = {
    filters.filterNot(_.isActive.getOrElse(false)).map { f =>
      labelOrUri(f).map { s =>
        """
          |  FILTER(%v != %fv)
        """
          .replaceAll("%v", variable)
          .replaceAll("%fv", s)
          .stripMargin
      }
    }.filter(_.isDefined).map(_.get).mkString("\n")
  }

  private def labelOrUri(f: ValueFilter) = {
    f match {
      case u if f.uri.isDefined => u.uri.map("<" + _ + ">")
      case l if f.label.isDefined => l.label.map("'" + _ + "'")
      case _ => None
    }
  }

}

object WKTEntitiesQuery {

  object NodeVariables extends Enumeration {
    type NodeVariables = Value
    val geolocatedEntity = Value("s")
    val wkt = Value("p")
  }

}