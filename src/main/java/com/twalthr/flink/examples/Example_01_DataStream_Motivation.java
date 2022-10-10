package com.twalthr.flink.examples;

import org.apache.flink.streaming.api.environment.StreamExecutionEnvironment;
import org.apache.flink.util.CloseableIterator;

/** Basic example of generating data and printing it. */
public class Example_01_DataStream_Motivation {

  public static void main(String[] args) throws Exception {
    StreamExecutionEnvironment env = StreamExecutionEnvironment.getExecutionEnvironment();

    CloseableIterator<Customer> it =   env.fromElements(ExampleData.CUSTOMERS)
        .executeAndCollect();

        it.forEachRemaining(System.out::println);
  }
}
