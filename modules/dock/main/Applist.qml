pragma Singleton

import Quickshell
import Quickshell.Wayland

// just checked - this is shit performance wise; to be rewritten


Singleton {
    readonly property list<DesktopEntry> pinnedApps: {
        const _cacheTrigger = DesktopEntries.applications.values;
        return [
            DesktopEntries.byId("firefox"), 
            DesktopEntries.byId("code"),
            DesktopEntries.byId("kitty")
        ]
    }
    
    readonly property list<Toplevel> runningApps: ToplevelManager.toplevels.values

    readonly property var combinedApps: [
        ...runningApps.map(item => {
            const idApp = DesktopEntries.byId(item.appId)
            if (idApp) return {entry: idApp, window: item, running: true, pinned: pinnedApps.includes(idApp)};
            const nameApp = DesktopEntries.heuristicLookup(item.appId)
            return {
                entry: nameApp, window: item, running: true, pinned: pinnedApps.includes(nameApp)
            };
        }),
        ...pinnedApps.map(item => {
            return {entry: item, window: null, running: false, pinned: true}
        }),
    ];

    readonly property var filteredApps: {
        // idk performance dawg; first idea that came to mind
        var added = []
        const unqiueApps = combinedApps.filter(value => {
            if (!added.includes(value.entry)) {
                added.push(value.entry)
                return true;
            }
            return false;
        })
        return unqiueApps
    }

    readonly property var pinnedAppsFiltered: filteredApps.filter(value => value.pinned)
    readonly property var unPinnedAppsFiltered: filteredApps.filter(value => !value.pinned)
}