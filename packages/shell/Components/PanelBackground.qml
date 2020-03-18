import QtQuick 2.12
import org.muelle.extra 1.0 as Muelle
import '../../shared/functional.ts' as F

Item {
  readonly property rect backgroundRect: store.state.geometry.backgroundRect

  x: backgroundRect.x
  y: backgroundRect.y
  width: backgroundRect.width
  height: backgroundRect.height

  // Rectangle {
  //   antialiasing: true
  //   color: '#222D32'
  //   border.width: 0
  //   radius: 2
  //   opacity: 1
    
  //   anchors.fill: parent
  // }

  Muelle.Rectangle {
    anchors.fill: parent
    color: '#222D32'
    radius {
      topLeft: 4
      topRight: 4
    } 
  }
}