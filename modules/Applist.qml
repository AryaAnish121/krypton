pragma Singleton

import Quickshell
import Quickshell.Wayland

Singleton {
    // fuck yeahh works finally; basically do a id lookup first; if not foun do a heuristicLookup
    readonly property list<DesktopEntry> apps: ToplevelManager.toplevels.values.map(value => {
            const idApp = DesktopEntries.byId(value.appId)
            if (idApp) return idApp;
            return DesktopEntries.heuristicLookup(value.appId);
        })
}