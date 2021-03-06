import QtQuick 2.14
import org.muelle.types 1.0
import 'qrc:/shared/components'

QObject {
  objectName: '@State/Panel'

  property bool lockVisible: false
  property bool visible: false
  readonly property bool hidden: !visible

  property string slide: 'none'

  property bool updatingOffset: false
  property bool updatingEdge: nextEdge !== edge
  property bool updatingOrientation: false
  property bool updatingLaunchers: false
  property bool updatingScreen: false

  property int nextEdge: $configuration.edge || Types.Top
  property int nextAlignment: Types.Center

  readonly property int orientation: edge & Types.Top || edge & Types.Bottom
      ? Types.Horizontal : Types.Vertical

  readonly property bool isHorizontal: orientation === Types.Horizontal
  readonly property bool isVertical: orientation === Types.Vertical
  property int alignment: Types.Center
  property int edge: nextEdge
  property int behavior: Types.DodgeActive

  // counter of not grouped tasks
  property int nextTaskCount1: 0
  property int taskCount1: 0
  property int separatorCount: 0

  property bool growing: nextTaskCount1 > taskCount1
  property bool shrinking: nextTaskCount1 < taskCount1

  Spy {
    properties: spy`taskCount1`
  }
}
