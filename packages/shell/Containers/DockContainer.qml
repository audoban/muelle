import QtQuick 2.14
import QtQuick.Layouts 1.1
import QtQml.Models 2.3
import org.muelle.types 1.0
import org.muelle.extra 1.0
import org.kde.taskmanager 0.1 as TaskManager
import 'qrc:/shared/functional.ts' as F
import 'qrc:/shell/Components'
import 'qrc:/shared/components'
import 'qrc:/shell/Store/actions.ts' as Action


Item {
  id: dockContainer

  EdgeSlideAnimation {
    target: panelContainer

    onSlideInFinished: {
      store.dispatch(Action.slideInFinished())
    }
    onSlideOutFinished: {
      store.dispatch(Action.slideOutFinished())
    }
  }

  PanelContainer {
    id: panelContainer
    anchors.centerIn: dockContainer
    width: dockContainer.width
    height: dockContainer.height

    DelegateModel {
      Component.onCompleted: {
        Qt.callLater(() => {
          model = Qt.binding(() => store.tasksModel)
        })
      }

      Component.onDestruction: {
        model = null
      }

      delegate: IconTaskContainer {
        id: icon
        panel: panelContainer
      }
    }
  }
}
