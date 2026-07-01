pragma Singleton

import Quickshell
import Quickshell.Wayland
import qs.modules


Singleton {
    readonly property list<DesktopEntry> pinnedApps: [
        DesktopEntries.byId("firefox"), 
        DesktopEntries.byId("code"),
        DesktopEntries.byId("kitty"),
    ]
    
    readonly property list<Toplevel> runningApps: ToplevelManager.toplevels.values

    readonly property var combinedApps: [
        ...runningApps.map(item => {
            const idApp = DesktopEntries.byId(item.appId)
            if (idApp) return {entry: idApp, window: item, running: true};
            return {entry: DesktopEntries.heuristicLookup(item.appId), window: item, running: true};
        }),
        ...pinnedApps.map(item => {
            return {entry: item, window: null, running: false}
        }),
    ];

    readonly property var apps: {
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

    
}