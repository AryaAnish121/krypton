import Quickshell.Services.SystemTray
import Quickshell
pragma Singleton

Singleton {
    readonly property list<SystemTrayItem> items: SystemTray.items.values;
}
