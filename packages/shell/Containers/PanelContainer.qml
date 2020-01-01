import QtQuick 2.12
import QtQuick.Layouts 1.3
import QtQml.Models 2.3
import org.muelle.types 1.0
import "../Extras"
import "../Components"
import "../libs/functional.js" as F
import "../libs/signal.js" as Signal

Loader {
  id: panelContainer
  objectName: 'PanelContainer'

  asynchronous: false
  sourceComponent: $layout.isHorizontal ? horizontal : vertical

  default property DelegateModel model
  property Item hovered
  property Item dragging
  property Item positioner

  Drag.active: !!(dragging && dragging.drag.active && dragging.hold)
  Drag.hotSpot.x: store.state.icon.size / 2
  Drag.hotSpot.y: store.state.icon.size / 2
  Drag.dragType: Drag.Automatic


  Item {
    Repeater { parent: positioner; model: panelContainer.model }
  }

  children: [
  DropArea {
    id: dropArea

    readonly property rect rect: store.state.geometry.panelRect

    anchors {
      fill: parent
      leftMargin: rect.x
      rightMargin: parent.width - rect.width - rect.x
      topMargin: rect.y
      bottomMargin: parent.height - rect.height - rect.y
    }

    function moveTask() {
      if (dragging && hovered) {
        model.items.move(
          dragging.DelegateModel.itemsIndex,
          hovered.DelegateModel.itemsIndex
        )
      }
    }

    drag.onPositionChanged: {
      const item = positioner.childAt(drag.x, drag.y)
      if (item !== hovered) {
        hovered = item
        moveTask()
      }
    }

    onDropped: {
      const applications = F.Iter
        .from(drop.urls)
        .filter(store.backend.isApplication)
        .each(store.tasksModel.requestAddLauncher)
        .value

      if (applications.length || !hovered) return

      const modelIndex = store.tasksModel.makeModelIndex(hovered.index)

      store.tasksModel.requestOpenUrls(modelIndex, drop.urls)
    }
  }]

  Component {
    id: horizontal
    RowLayout {
      spacing: 0

      FlexSpacing {
        fill: true
        softFill: true

        Layout.preferredWidth: store.state.geometry.panelNextPoint.x
      }
      Row {
        id: row
        spacing: store.state.icon.spacing
        layoutDirection: Qt.LeftToRight
        Layout.maximumHeight: store.state.icon.size
        height: Layout.maximumHeight

        Component.onCompleted: {
          panelContainer.positioner = row
        }

        move: Transition {
          NumberAnimation {
            alwaysRunToEnd: true
            properties: 'x';
            easing.type: Easing.InOutQuad
            duration: store.state.animation.duration / 2
          }
          NumberAnimation {
            property: 'y'
            to: 0
            easing.type: Easing.OutBounce
            duration: store.state.animation.duration
            alwaysRunToEnd: true
          }
        }


        add: Transition {
          NumberAnimation {
            property: 'y'
            from: ($layout.edge === Types.Top ? -1 : 1) * store.state.icon.size
            to: 0
            easing.type: Easing.OutBounce
            duration: store.state.animation.duration
            alwaysRunToEnd: true
          }
        }
      }
      FlexSpacing {
        fill: true
      }
    }
  }

  Component {
    id: vertical
    ColumnLayout {
      spacing: 0
      FlexSpacing {
        fill: true
        softFill: true
        Layout.preferredHeight: store.state.geometry.panelNextPoint.y
      }
      Column {
        id: column
        Layout.fillWidth: true
        spacing: store.state.icon.spacing

        Component.onCompleted: {
          panelContainer.positioner = column
        }

        move: Transition {
          NumberAnimation {
            alwaysRunToEnd: true
            properties: 'y';
            easing.type: Easing.InOutQuad
            duration: store.state.animation.duration / 2
          }
          NumberAnimation {
            property: 'x'
            to: 0
            easing.type: Easing.OutBounce
            duration: store.state.animation.duration
            alwaysRunToEnd: true
          }
        }
        add: Transition {
          NumberAnimation {
            property: 'x'
            from: ($layout.edge === Types.Left ? -1 : 1) * store.state.icon.size
            to: 0
            easing.type: Easing.OutBounce
            duration: 1000
          }
        }
      }
      FlexSpacing {
        fill: true
      }
    }
  }
}