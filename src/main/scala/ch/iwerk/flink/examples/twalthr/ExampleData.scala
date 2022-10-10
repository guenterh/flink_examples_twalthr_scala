package ch.iwerk.flink.examples.twalthr

import java.time.LocalDate
import java.util
import scala.jdk.CollectionConverters._


object ExampleData {

  val CUSTOMERS: util.List[Customer] = List(
    Customer(12L, "Alice", LocalDate.of(1984, 3, 12)),
    Customer(32L, "Bob", LocalDate.of(1990, 10, 14)),
    Customer(7L, "Kyle", LocalDate.of(1979, 2, 23))
  ).asJava

  val CUSTOMERSArray: Array[Customer] = Array(
    Customer(12L, "Alice", LocalDate.of(1984, 3, 12)),
    Customer(32L, "Bob", LocalDate.of(1990, 10, 14)),
    Customer(7L, "Kyle", LocalDate.of(1979, 2, 23))

  )


}
