import QtQuick 2.14
import org.kde.taskmanager 0.1
import org.kde.plasma.private.taskmanager 0.1 as TaskManagerApplet

import 'qrc:/shell/helpers/memoComponent.ts' as MC
import 'qrc:/shell/Components'
import 'qrc:/shared/components'
import 'qrc:/shared/functional.ts' as F
import 'qrc:/shared/flux'
import 'mutations.ts' as M
import 'sagaRoot.ts' as Saga
import 'actions.ts' as Action

FluxStore {
  id: store

  readonly property ShellState state: ShellState {}
  _state: state
  mutations: M.mutations
  sagaRoot: Saga.sagaRoot

  property DockMenu contextMenu

  readonly property TasksModel tasksModel: state.tasksModel

  readonly property ActivityInfo activityInfo:
    ActivityInfo {}

  readonly property VirtualDesktopInfo virtualDesktopInfo:
    VirtualDesktopInfo {}

  readonly property TaskManagerApplet.Backend backend: TaskManagerApplet.Backend {
    taskManagerItem: root
    toolTipItem: Item {
      visible: true
    }
    onAddLauncher: {
      tasksModel.requestAddLauncher(url)
    }
    Component.onCompleted: {
    }
  }

  readonly property PropertyBuffer propertyBuffer: PropertyBuffer {}
}
