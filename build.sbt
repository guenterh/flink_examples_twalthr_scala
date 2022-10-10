
ThisBuild / organization := "ch.iwerk"
ThisBuild / version      := "01"

assembly / assemblyMergeStrategy := {
  case PathList("META-INF", xs @ _*) => MergeStrategy.discard
  case x => MergeStrategy.first
}



lazy val scala_api_symbiosis = (project in file("."))
  .settings(
    name := "scala_table_stream_api_perfect_symbiosis",
    scalaVersion:= "2.13.8",
    assembly / assemblyJarName := "table_stream_api_perfect_symbiosis_scala.jar",
    assembly / mainClass := Some("ch.iwerk.flink.examples.twalthr.Example_01_DataStream_Motivation"),

    libraryDependencies += "org.apache.flink" % "flink-streaming-java" % "1.15.2" % "provided",
    libraryDependencies += "org.apache.flink" % "flink-clients" % "1.15.2" % "provided",
    // https://mvnrepository.com/artifact/org.apache.flink/flink-connector-jdbc
    libraryDependencies += "org.apache.flink" % "flink-connector-jdbc" % "1.15.2" % "provided",


    libraryDependencies += "org.apache.flink" % "flink-table-planner-loader" % "1.15.2" % "provided",
    //libraryDependencies += "org.apache.flink" % "flink-table-common" % "1.15.1"
    //libraryDependencies += "org.apache.flink" % "flink-table-api-java" % "1.15.1"
    libraryDependencies += "org.apache.flink" % "flink-table-api-java-bridge" % "1.15.2" % "provided",
    libraryDependencies += "org.apache.flink" % "flink-table-runtime" % "1.15.2" % "provided",
    //libraryDependencies += "org.apache.flink" % "flink-connector-kafka" % "1.15.1"
    //< 2.15 is vulnerable

    libraryDependencies += "mysql" % "mysql-connector-java" % "8.0.28",
    //libraryDependencies += "org.scala-lang.modules" %% "scala-xml" % "1.3.0",
    // https://mvnrepository.com/artifact/com.fasterxml.jackson.core/jackson-databind
    libraryDependencies += "com.fasterxml.jackson.core" % "jackson-databind" % "2.13.4",
    // https://mvnrepository.com/artifact/com.fasterxml.jackson.datatype/jackson-datatype-jsr310
    libraryDependencies += "com.fasterxml.jackson.datatype" % "jackson-datatype-jsr310" % "2.13.4",
    // https://mvnrepository.com/artifact/org.testcontainers/mysql
    //libraryDependencies += "org.testcontainers" % "mysql" % "1.17.5" % Test,
      libraryDependencies += "org.testcontainers" % "mysql" % "1.17.5",

    // https://mvnrepository.com/artifact/com.ververica/flink-sql-connector-mysql-cdc
    libraryDependencies += "com.ververica" % "flink-sql-connector-mysql-cdc" % "2.2.1",


    // https://mvnrepository.com/artifact/org.apache.flink/flink-connector-kafka
    libraryDependencies += "org.apache.flink" % "flink-connector-kafka" % "1.15.2",
    // https://mvnrepository.com/artifact/org.apache.flink/flink-connector-base
    libraryDependencies += "org.apache.flink" % "flink-connector-base" % "1.15.2",
    // https://mvnrepository.com/artifact/org.apache.flink/flink-json
    //libraryDependencies += "org.apache.flink" % "flink-json" % "1.15.2" % Test
      libraryDependencies += "org.apache.flink" % "flink-json" % "1.15.2",

      libraryDependencies += "org.apache.logging.log4j" % "log4j-slf4j-impl" % "2.19.0",
      // https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-api
      libraryDependencies += "org.apache.logging.log4j" % "log4j-api" % "2.19.0",
        // https://mvnrepository.com/artifact/org.apache.logging.log4j/log4j-core
        libraryDependencies += "org.apache.logging.log4j" % "log4j-core" % "2.19.0",
      // https://mvnrepository.com/artifact/org.slf4j/jul-to-slf4j
      libraryDependencies += "org.slf4j" % "jul-to-slf4j" % "2.0.0"


  )
