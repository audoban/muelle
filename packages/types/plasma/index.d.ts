import Qt from 'qt';

declare module 'plasma/org.kde.plasma.private.taskmanager-0.1' {
  export interface TasksModel extends Qt.QtObject {
    sourceModel: Qt.QtObject; // TaskManager::FlattenTaskGroupsProxyModel(0x16259b0),
    filterRegExp: RegExp;
    filterRegularExpression: RegExp;
    filterKeyColumn: number;
    dynamicSortFilter: boolean;
    filterCaseSensitivity: number;
    sortCaseSensitivity: number;
    isSortLocaleAware: boolean;
    sortRole: number;
    filterRole: number;
    recursiveFilteringEnabled: boolean;
    count: number;
    launcherCount: number;
    launcherList: string[];
    anyTaskDemandsAttention: boolean;
    virtualDesktop: number;
    screenGeometry: Qt.rect;
    activity: string;
    filterByVirtualDesktop: boolean;
    filterByScreen: boolean;
    filterByActivity: boolean;
    filterNotMinimized: boolean;
    sortMode: number;
    separateLaunchers: boolean;
    launchInPlace: boolean;
    groupMode: number;
    groupInline: boolean;
    groupingWindowTasksThreshold: number;
    groupingAppIdBlacklist: Object;
    groupingLauncherUrlBlacklist: Object;
    activeTask: object; // QModelIndex,
    objectNameChanged(): void;
    dataChanged(): void;
    headerDataChanged(): void;
    layoutChanged(): void;
    layoutAboutToBeChanged(): void;
    rowsAboutToBeInserted(): void;
    rowsInserted(): void;
    rowsAboutToBeRemoved(): void;
    rowsRemoved(): void;
    columnsAboutToBeInserted(): void;
    columnsInserted(): void;
    columnsAboutToBeRemoved(): void;
    columnsRemoved(): void;
    modelAboutToBeReset(): void;
    modelReset(): void;
    rowsAboutToBeMoved(): void;
    rowsMoved(): void;
    columnsAboutToBeMoved(): void;
    columnsMoved(): void;
    submit(): void;
    revert(): void;
    resetInternalData(): void;
    hasIndex(): void;
    index(): void;
    parent(): void;
    sibling(): void;
    rowCount(): void;
    columnCount(): void;
    hasChildren(): void;
    data(): void;
    setData(): void;
    headerData(): void;
    fetchMore(): void;
    canFetchMore(): void;
    flags(): void;
    match(): void;
    sourceModelChanged(): void;
    mapToSource(): void;
    mapFromSource(): void;
    mapSelectionToSource(): void;
    mapSelectionFromSource(): void;
    dynamicSortFilterChanged(): void;
    filterCaseSensitivityChanged(): void;
    sortCaseSensitivityChanged(): void;
    sortLocaleAwareChanged(): void;
    sortRoleChanged(): void;
    filterRoleChanged(): void;
    recursiveFilteringEnabledChanged(): void;
    setFilterRegExp(): void;
    setFilterRegularExpression(): void;
    setFilterWildcard(): void;
    setFilterFixedString(): void;
    clear(): void;
    invalidate(): void;
    countChanged(): void;
    launcherCountChanged(): void;
    launcherListChanged(): void;
    anyTaskDemandsAttentionChanged(): void;
    virtualDesktopChanged(): void;
    screenGeometryChanged(): void;
    activityChanged(): void;
    filterByVirtualDesktopChanged(): void;
    filterByScreenChanged(): void;
    filterByActivityChanged(): void;
    filterNotMinimizedChanged(): void;
    sortModeChanged(): void;
    separateLaunchersChanged(): void;
    launchInPlaceChanged(): void;
    groupModeChanged(): void;
    groupInlineChanged(): void;
    groupingWindowTasksThresholdChanged(): void;
    groupingAppIdBlacklistChanged(): void;
    groupingLauncherUrlBlacklistChanged(): void;
    activeTaskChanged(): void;
    requestAddLauncher(): void;
    requestRemoveLauncher(): void;
    requestAddLauncherToActivity(): void;
    requestRemoveLauncherFromActivity(): void;
    launcherActivities(): void;
    launcherPosition(): void;
    requestActivate(index: ModelIndex): void;
    requestNewInstance(index: ModelIndex): void;
    requestOpenUrls(): void;
    requestClose(index: ModelIndex): void;
    requestMove(index: ModelIndex): void;
    requestResize(index: ModelIndex): void;
    requestToggleMinimized(index: ModelIndex): void;
    requestToggleMaximized(index: ModelIndex): void;
    requestToggleKeepAbove(index: ModelIndex): void;
    requestToggleKeepBelow(index: ModelIndex): void;
    requestToggleFullScreen(index: ModelIndex): void;
    requestToggleShaded(index: ModelIndex): void;
    requestVirtualDesktops(): void;
    requestNewVirtualDesktop(): void;
    requestActivities(): void;
    requestPublishDelegateGeometry(index: ModelIndex, rect: Qt.rect): void;
    requestToggleGrouping(): void;
    move(targetIndex: number, to: number): void;
    syncLaunchers(): void;
    makeModelIndex(index: number): ModelIndex;
    makePersistentModelIndex(): void;
  }

  export interface ModelIndex extends Qt.QtObject<any> {}

  export interface Backend extends Qt.QtObject {
    taskManagerItem: Qt.QtObject;
    toolTipItem: Qt.QtObject;
    groupDialog: null;
    highlightWindows: false;
    objectNameChanged(): void;
    taskManagerItemChanged(): void;
    toolTipItemChanged(): void;
    groupDialogChanged(): void;
    highlightWindowsChanged(): void;
    addLauncher(): void;
    showAllPlaces(): void;
    presentWindows(): void;
    windowsHovered(): void;
    jumpListActions(): void;
    placesActions(): void;
    recentDocumentActions(): void;
    setActionGroup(): void;
    globalRect(): void;
    ungrabMouse(): void;
    canPresentWindows(): void;
    isApplication(url: Qt.url): void;
    jsonArrayToUrlList(urls: string): void;
    cancelHighlightWindows(): void;
    parentPid(): void;
  }
  export interface TaskItemModel extends Qt.QtObject {
    index: number;
    row: number;
    column: number;
    rowChanged: Qt.Signal;
    columnChanged: Qt.Signal;
    hasModelChildren: boolean;
    modelIndexChanged: Qt.Signal;
    display: string;
    decoration: object;
    ChildCount: undefined;
    edit: undefined;
    toolTip: undefined;
    statusTip: undefined;
    whatsThis: undefined;

    AppPid: number;
    AppId: string;
    AppName: string;
    GenericName: string;
    WinIdList: number[];
    LauncherUrl: {};
    LauncherUrlWithoutIcon: {};
    MimeType: string;
    MimeData: {};
    HasLauncher: boolean;
    IsActive: boolean;
    IsStartup?: boolean;
    IsWindow: boolean;
    IsLauncher?: boolean;
    IsGroupable: boolean;
    IsGroupParent: boolean;
    IsClosable: boolean;
    IsMovable: boolean;
    IsResizable: boolean;
    IsMaximizable: boolean;
    IsMaximized: boolean;
    IsMinimizable: boolean;
    IsMinimized: boolean;
    IsKeepAbove: boolean;
    IsKeepBelow: boolean;
    IsFullScreenable: boolean;
    IsFullScreen: boolean;
    IsShadeable: boolean;
    IsShaded: boolean;
    IsVirtualDesktopsChangeable: boolean;
    IsOnAllVirtualDesktops: boolean;
    IsDemandingAttention: boolean;
    VirtualDesktops: number[];
    Geometry: Qt.rect;
    ScreenGeometry: Qt.rect;
    Activities: Record<string, string>;
    SkipTaskbar: boolean;
    SkipPager: boolean;
  }

  export interface TaskManagerApplet extends Qt.QtObject {
    launcherUrl: Qt.url;
    count: number;
    countVisible: boolean;
    progress: number;
    progressVisible: boolean;
    urgent: boolean;

    objectNameChanged: Qt.Signal;
    launcherUrlChanged: Qt.Signal;
    countChanged: Qt.Signal;
    countVisibleChanged: Qt.Signal;
    progressChanged: Qt.Signal;
    progressVisibleChanged: Qt.Signal;
    urgentChanged: Qt.Signal;
  }
}
