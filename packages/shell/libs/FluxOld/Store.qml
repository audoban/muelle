import QtQuick 2.12
import '../../Components'
import '../../Extras'
import '../../shared/functional.ts' as F
import 'types.ts' as T
import 'actions.ts' as Action
import org.kde.taskmanager 0.1
import org.kde.plasma.private.taskmanager 0.1 as TaskManagerApplet

FluxStore {
  id: store

  state: FluxState {}
  mutations: FluxMutations { store: store }
  actions: FluxActions { store: store }

  property DockMenu contextMenu

  readonly property TasksModel tasksModel: TasksModel {
    virtualDesktop: store.virtualDesktopInfo.currentDesktop
    activity: store.activityInfo.currentActivity
    launchInPlace: true
    separateLaunchers: true
    groupMode: TasksModel.GroupApplications
    groupInline: true
    groupingWindowTasksThreshold: -1
    filterByVirtualDesktop: false
    filterByScreen: false
    filterByActivity: true

    onCountChanged: {
      dispatch(Action.updateTaskCount1(count))
    }

    Component.onCompleted: {
      countChanged()
    }
  }

  readonly property ActivityInfo activityInfo:
    ActivityInfo {}

  readonly property VirtualDesktopInfo virtualDesktopInfo:
    VirtualDesktopInfo {}

  readonly property TaskManagerApplet.Backend backend: TaskManagerApplet.Backend {
    taskManagerItem: root
    toolTipItem: Rectangle {
      color: "#c83232"
      visible: true
    }
    onAddLauncher: {
      tasksModel.requestAddLauncher(url)
    }
  }
}