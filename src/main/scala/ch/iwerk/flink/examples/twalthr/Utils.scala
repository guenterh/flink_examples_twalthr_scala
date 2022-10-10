package ch.iwerk.flink.examples.twalthr

import com.fasterxml.jackson.databind.{ObjectMapper, SerializationFeature}
import com.fasterxml.jackson.datatype.jsr310.JavaTimeModule

object Utils {

  def getMapper: ObjectMapper = {
    val mapper = new ObjectMapper
    mapper.registerModule(new JavaTimeModule)
    mapper.configure(SerializationFeature.WRITE_DATES_AS_TIMESTAMPS, false)
  }
}
