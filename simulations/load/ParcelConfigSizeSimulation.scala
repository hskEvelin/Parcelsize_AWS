package parcel_config_size

import scala.concurrent.duration._

import io.gatling.core.Predef._
import io.gatling.http.Predef._
import io.gatling.jdbc.Predef._
  
class ParcelConfigSizeSimulation extends Simulation {

	val httpProtocol = http
		.baseURL("http://vm.parcel.aps.com:1150")
		.inferHtmlResources(BlackList(""".*\.css""", """.*\.js""", """.*\.ico"""), WhiteList())
		.acceptHeader("text/html,application/xhtml+xml,application/xml;q=0.9,*/*;q=0.8")
		.acceptEncodingHeader("gzip, deflate")
		.acceptLanguageHeader("de,en-US;q=0.7,en;q=0.3")
		.userAgentHeader("Mozilla/5.0 (X11; Ubuntu; Linux x86_64; rv:57.0) Gecko/20100101 Firefox/57.0")

	val headers_0 = Map("Upgrade-Insecure-Requests" -> "1")

	val headers_1 = Map("Accept" -> "*/*")

	val headers_2 = Map(
		"Accept" -> "application/json, text/plain, */*",
		"Content-Type" -> "text/plain",
		"Origin" -> "http://vm.parcel.aps.com:1150")

    val uri1 = "vm.parcel.aps.com"

	val scn = scenario("ParcelConfigSizeSimulation")
		.exec(http("request_0")
			.get("/ParcelConfigService/")
			.headers(headers_0)
			.resources(http("request_1")
			.get("/ParcelConfigService/images/icon_pakete.png")
			.headers(headers_1)))
		.pause(6)
		.exec(http("request_2")
			.post("http://" + uri1 + ":1100/parcel/sent/size")
			.headers(headers_2)
			.body(RawFileBody("ParcelConfigSizeSimulation_0002_request.txt")))

	setUp(scn.inject(atOnceUsers(1000))).protocols(httpProtocol)
}
