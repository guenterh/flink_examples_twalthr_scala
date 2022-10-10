import de.ubleipzig.zdf.fsdb.utils.Helpers

import java.io.InputStream
import org.apache.commons.compress.archivers.{ArchiveEntry, ArchiveInputStream, ArchiveStreamFactory}
import org.apache.commons.compress.compressors.CompressorStreamFactory
import org.apache.commons.compress.archivers.zip.ZipArchiveInputStream
import org.apache.commons.io.input.CloseShieldInputStream


object TestZipFiles {



  import java.io.{BufferedInputStream, File, FileInputStream}

  def getIterator: Iterator[(ArchiveEntry, InputStream)] = {

    val inputStream = new FileInputStream(new File("/var/spark/testzip/1970.zip"))

    println("hello")
    val input = new ZipArchiveInputStream(inputStream);

    new Iterator[(ArchiveEntry, InputStream)] {
      private var latest: ArchiveEntry = _

      override def hasNext: Boolean = {
        latest = input.getNextEntry
        latest != null
      }

      override def next(): (ArchiveEntry, InputStream) =
        (latest, CloseShieldInputStream.wrap(input))
    }
  }

  def main(args: Array[String]): Unit = {
    val it = getIterator
    while (it.hasNext) {
      val item = it.next()
      println(item._1)
      println(Helpers.inputStreamToString(item._2))

    }
  }

}
