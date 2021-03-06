/* Muelle
 * Copyright (C) 2019 Smith Ar
 *
 * This program is free software: you can redistribute it and/or modify
 * it under the terms of the GNU General Public License as published by
 * the Free Software Foundation, either version 3 of the License, or
 * (at your option) any later version.
 *
 * This program is distributed in the hope that it will be useful,
 * but WITHOUT ANY WARRANTY; without even the implied warranty of
 * MERCHANTABILITY or FITNESS FOR A PARTICULAR PURPOSE.  See the
 * GNU General Public License for more details.
 *
 * You should have received a copy of the GNU General Public License
 * along with this program.  If not, see <https://www.gnu.org/licenses/>.
 */

#ifndef LAYOUT_HPP
#define LAYOUT_HPP

#include "docktypes.hpp"
#include <QDebug>
#include <QFlags>
#include <QObject>
#include <QQmlEngine>
#include <QtGlobal>

///*
//   Assign and emit a signal
//   M: Member, V: new value, S: signal
//*/
//#define DOCK_ASSIGN(M, V) \
//  if (M != V) { \
//    M = V; \
//  }

namespace Muelle {
class Layout : public QObject {
  Q_OBJECT
  Q_DISABLE_COPY(Layout)
  Q_PROPERTY(
      Muelle::Types::Edge edge READ edge WRITE setEdge NOTIFY edgeChanged)
  Q_PROPERTY(Muelle::Types::Orientation orientation READ orientation NOTIFY
                 orientationChanged)
  Q_PROPERTY(Muelle::Types::Alignment alignment READ alignment WRITE
                 setAlignment NOTIFY alignmentChanged)
  Q_PROPERTY(uint layout READ layout NOTIFY layoutChanged)
  Q_PROPERTY(bool isHorizontal READ isHorizontal NOTIFY orientationChanged)
  Q_PROPERTY(bool isVertical READ isVertical NOTIFY orientationChanged)

public:
  explicit Layout(QObject *parent = nullptr) noexcept;
  virtual ~Layout();

  constexpr Types::Edge edge() const noexcept;
  constexpr Types::Orientation orientation() const noexcept;
  constexpr Types::Alignment alignment() const noexcept;
  constexpr uint layout() const noexcept;

  constexpr bool isHorizontal() const noexcept;
  constexpr bool isVertical() const noexcept;

  void setEdge(Types::Edge edge) noexcept;
  void setAlignment(Types::Alignment alignment) noexcept;

signals:
  void edgeChanged();
  void orientationChanged();
  void alignmentChanged();
  void layoutChanged();

private:
  Types::Orientation mOrientation = Types::Orientation::Horizontal;
  Types::Edge mEdge = Types::Edge::Bottom;
  Types::Alignment mAlignment = Types::Alignment::Center;
};

constexpr Types::Edge Layout::edge() const noexcept { return mEdge; }

constexpr Types::Orientation Layout::orientation() const noexcept {
  return mOrientation;
}

constexpr Types::Alignment Layout::alignment() const noexcept {
  return mAlignment;
}

constexpr uint Layout::layout() const noexcept {
  return static_cast<uint>(mEdge) | static_cast<uint>(mAlignment);
}

constexpr bool Layout::isHorizontal() const noexcept {
  return mOrientation == Types::Orientation::Horizontal;
}

constexpr bool Layout::isVertical() const noexcept {
  return mOrientation == Types::Orientation::Vertical;
}
} // namespace Muelle
#endif // LAYOUT_HPP
