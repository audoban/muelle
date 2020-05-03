#include "dockcontainer.hpp"

namespace Muelle {

Container::Container(QObject *parent)
    : QObject(parent), mEngine(new EnhancedQmlEngine(this)),
      mTheme(new Plasma::Theme(this)),
      mConfig(KSharedConfig::openConfig(QStringLiteral("muellerc"))) {

  Muelle::registerExtensions(*mEngine);

  const auto updateScreens = [&] {
    mScreens.clear();
    foreach (auto screen, qGuiApp->screens()) {
      mScreens[screen->name()] = QVariant::fromValue(screen);
    }
    emit screensChanged();
  };
  updateScreens();

  connect(qGuiApp, &QGuiApplication::screenAdded, updateScreens);
  connect(qGuiApp, &QGuiApplication::screenRemoved, updateScreens);

  mEngine->rootContext()->setContextProperty(QStringLiteral("$container"),
                                             this);
}

void Container::loadConfiguration() {
  auto groups = mConfig->group("shell").groupList();

  if (groups.isEmpty()) {
    auto uuid = createDefaultView();
    loadView(uuid);
    mConfig->sync();
  } else {
    foreach (auto uuid, groups) { loadView(uuid); }
  }
}

bool Container::loadView(const UUID &uuid) {
  auto group = mConfig->group("shell");
  if (!group.hasGroup(uuid))
    return false;

  auto screen = findScreen(group.readEntry("screen", "Primary"));

  if (!screen)
    return false;

  auto shellGroup = group.group(uuid);
  auto view = new View(mEngine, shellGroup);

  mViews[uuid] = view;
  view->setScreen(screen);
  view->init();

  return true;
}

void Container::unloadView(const UUID &uuid) {
  if (!mViews.contains(uuid))
    return;

  std::exchange(mViews[uuid], nullptr)->deleteLater();
}

UUID Container::createDefaultView() {
  const auto screens = QApplication::screens();

  auto uuid = QUuid::createUuid().toString(QUuid::StringFormat::WithoutBraces);
  mConfig->group("shell").group(uuid).writeEntry("screen", "Primary");

  return uuid;
}

QScreen *Container::findScreen(const QString &name) const {
  if (name == "Primary") {
    return QApplication::primaryScreen();
  }

  const auto screens = QApplication::screens();

  auto screen =
      std::find_if(std::cbegin(screens), std::cend(screens),
                   [&](auto screen) { return name == screen->name(); });

  return screen != std::cend(screens) ? *screen : nullptr;
}

Plasma::Theme *Container::theme() { return mTheme; }

Container *Container::instance() noexcept {
  static auto container{new Container()};

  return container;
}

QMap<QString, QVariant> Container::screensVariant() const noexcept {
  return mScreens;
}
} // namespace Muelle
