import QtQuick 2.14
import org.muelle.types 1.0
import org.muelle.extra 1.0
import 'qrc:/shared/components'
import 'qrc:/shared/functional.ts' as F
import 'qrc:/shell/Store/actions.ts' as Action

QObject {
  id: manager
  objectName: 'BehaviorManager'

  signal forceUpdate

  Component.onCompleted: {
    setTimeout(() => dodgeWindow.scanWindows(), 2000)
  }

  PressureDetector {
    id: pressure
    view: $view
    edge: store.state.panel.edge
    threshold: 20
    enabled: store.state.panel.hidden

    onThresholdReached: {
      store.dispatch(Action.slideIn())
    }
  }

  PanelBehavior {
    id: behavior
    view: $view
    behavior: store.state.panel.behavior
  }

  ConnectionGroup {
    id: autoHide
    enabled: behavior.behavior === Types.AutoHide

    Connections {
      target: $view
      function onEntered() { 
        store.dispatch(Action.slideIn()) 
      }
      function onExited() { 
        store.dispatch(Action.slideOut()) 
      }
    }
  }

  ConnectionGroup {
    id: dodgeWindow
    enabled: [Types.DodgeAll, Types.DodgeActive].includes(behavior.behavior)

    onEnabledChanged: {
      enabled && forceUpdate()
    }

    property var dodge: F.debounce(() => {
      // console.count('dodge')
      // console.log($view.containsMouse, $view.dragging, !behavior.dodge)
      if (store.state.panel.updatingScreen) return

      if ($view.containsMouse || !behavior.dodge) {
        if (store.state.panel.slide === 'slide-out-running' ||
            store.state.panel.hidden
        ) {
          store.dispatch(Action.slideIn())
        }
      } else {
        if (store.state.panel.slide === 'slide-in-running' ||
            store.state.panel.visible
        ) {
          store.dispatch(Action.slideOut())
        }
      }
    }, 50)

    property var scanWindows: F.debounce(behavior.scanWindows, 400)

    Connections {
      target: $view
      function onEntered() { dodgeWindow.dodge() }
      function onExited() { dodgeWindow.dodge() }
    }
    Connections {
      target: behavior
      function onDodgeChanged() { dodgeWindow.dodge() }
    }
    Connections {
      target: manager
      function onForceUpdate() { dodgeWindow.scanWindows() }
    }
    Connections {
      target: store.state.panel

      function onUpdatingScreenChanged() {
        if (!target.updatingScreen) dodgeWindow.scanWindows()
      }
      function onUpdatingOffsetChanged() {
        if (!target.updatingOffset) dodgeWindow.scanWindows()
      }
      function onUpdatingEdgeChanged() {
        if (!target.updatingEdge) dodgeWindow.scanWindows()
      }
    }
  }

  ConnectionGroup {
    id: alwaysVisible
    enabled: behavior.behavior === Types.AlwaysVisible

    property var updateStruts:
      F.debounce(() => enabled && behavior.updateStruts(), 1000)

    onEnabledChanged: {
      if (enabled) {
        forceUpdate()
        store.dispatch(Action.slideIn())
      }
    }

    Connections {
      target: store.state.geometry.panel
      function onSizeChanged() { alwaysVisible.updateStruts() }
    }
  }
}
