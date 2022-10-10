package ch.iwerk.flink.examples.twalthr

import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment

object Example_01_DataStream_Motivation {

  def main(args: Array[String]): Unit = {
    val env = StreamExecutionEnvironment.getExecutionEnvironment

    env.fromCollection(ExampleData.CUSTOMERS)
      .executeAndCollect()
      .forEachRemaining(println)


     env.fromElements(ExampleData.CUSTOMERSArray: _*)
        .executeAndCollect
        .forEachRemaining(println)
  }




}