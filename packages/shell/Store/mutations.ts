import { Types } from '@qml/org.muelle.types-1.0';
import Qt from 'qt';
import { Mutations } from '../../shared/flux/flux';
import {
  ADD_TRANSITION,
  ENABLE_MASK,
  HIDE_PANEL,
  LOCK_VISIBLE,
  MASK_GROWING,
  NEXT_ALIGNMENT,
  NEXT_BEHAVIOR,
  NEXT_EDGE,
  NEXT_TASK_COUNT1,
  SEPARATOR_COUNT,
  SHOW_PANEL,
  SHOW_SETTINGS,
  SLIDE_STATUS,
  UPDATE_POSITION,
  UPDATE_TASK_COUNT_1,
  UPDATING_ORIENTATION,
  UPDATING_SCREEN,
} from './mutationTypes';
import { ShellState } from './types';

export const mutations: Mutations<ShellState> = {
  [SLIDE_STATUS](state, status) {
    state.panel.slide = status;
  },
  [UPDATE_POSITION](state) {
    state.panel.edge = state.panel.nextEdge;
    state.panel.alignment = state.panel.nextAlignment;
  },
  [UPDATING_SCREEN](state, value) {
    state.panel.updatingScreen = value;
  },
  [UPDATING_ORIENTATION](state, nextEdge: Types.Edge) {
    const { edge } = state.panel;
    const { Types } = Qt.Muelle;
    // prettier-ignore
    if (
      (nextEdge & Types.Horizontal && edge & Types.Vertical) ||
      (nextEdge & Types.Vertical   && edge & Types.Horizontal)
    ) {
      state.panel.updatingOrientation = true
    } else {
      state.panel.updatingOrientation = false
    }
  },
  [NEXT_EDGE](state, edge) {
    state.panel.nextEdge = edge;
  },
  [NEXT_ALIGNMENT](state, align) {
    state.panel.nextAlignment = align;
  },
  [NEXT_BEHAVIOR](state, behavior) {
    state.panel.behavior = behavior;
  },
  [SHOW_PANEL](state) {
    state.panel.visible = true;
  },
  [HIDE_PANEL](state) {
    state.panel.visible = false;
  },
  [ADD_TRANSITION](state, value) {
    state.animation.addEnabled = value;
  },
  [NEXT_TASK_COUNT1](state, count) {
    state.panel.nextTaskCount1 = count;
  },
  [SEPARATOR_COUNT](state, count) {
    state.panel.separatorCount = count;
  },
  [UPDATE_TASK_COUNT_1](state) {
    state.panel.taskCount1 = state.panel.nextTaskCount1;
  },
  [MASK_GROWING](state, growing) {
    state.geometry.mask.growing = growing;
  },
  [ENABLE_MASK](state, enable) {
    state.geometry.mask.enabled = enable;
  },
  [SHOW_SETTINGS](state, visible) {
    state.settings.visible = visible;
  },
  [LOCK_VISIBLE](state, lock) {
    state.panel.lockVisible = lock;
  },
};
