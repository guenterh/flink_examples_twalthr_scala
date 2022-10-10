package ch.iwerk.flink.examples.twalthr

import org.apache.flink.api.common.serialization.DeserializationSchema
import org.apache.flink.api.common.typeinfo.TypeInformation

class CustomerDeserializer extends DeserializationSchema[Customer]{

  override def deserialize(message: Array[Byte]): Customer =
    Utils.getMapper.readValue(message, classOf[Customer])

  override def isEndOfStream(nextElement: Customer): Boolean = false

  override def getProducedType: TypeInformation[Customer] = TypeInformation.of(classOf[Customer])
}
