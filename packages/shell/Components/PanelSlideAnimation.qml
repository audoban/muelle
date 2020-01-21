import QtQuick 2.12
import '../../shared/components'
import '../Store/actions.ts' as Action

QObject {
  id: slide
  property Item target

  property real value: 0
  property real distance: store.state.icon.size

  Connections {
    target: store.state.panel

    onSlideChanged: {
      const slide = target.slide
      if (slide === 'slide-in-running') {
        slideIn.start()
      } else if (slide === 'slide-out-running') {
        slideOut.start()
      }
    }
  }

  SequentialAnimation {
    id: slideIn
    alwaysRunToEnd: false

    ScriptAction {
      script: slideOut.stop()
    }
    SmoothedAnimation {
      target: slide
      property: 'value'
      velocity: store.state.animation.velocity
      easing.type: Easing.OutCubic
      to: 0
    }
    ScriptAction {
      script: store.dispatch(Action.slideInFinished())
    }
  }

  SequentialAnimation {
    id: slideOut
    alwaysRunToEnd: false

    ScriptAction {
      script: slideIn.stop()
    }
    SmoothedAnimation {
      target: slide
      property: 'value'
      velocity: store.state.animation.velocity
      easing.type: Easing.InCubic
      to: -distance
    }
    ScriptAction {
      script: store.dispatch(Action.slideOutFinished())
    }
  }

  StateLayoutEdge {
    reset: PropertyChanges {
      target: slide.target
      anchors {
        verticalCenterOffset: 0
        horizontalCenterOffset: 0
      }
    }
    top: PropertyChanges {
      target: slide.target
      anchors.verticalCenterOffset: slide.value
    }
    right: PropertyChanges {
      target: slide.target
      anchors.horizontalCenterOffset: -slide.value
    }
    bottom: PropertyChanges {
      target: slide.target
      anchors.verticalCenterOffset: -slide.value
    }
    left: PropertyChanges {
      target: slide.target
      anchors.horizontalCenterOffset: slide.value
    }
  }
}