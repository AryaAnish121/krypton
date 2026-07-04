//@ pragma UseQApplication

import Quickshell

Scope {
    id: root

    property string dockMode: "dock"

    Dock {
        mode: dockMode
        onSwitchMode: (switchTo) => {
            root.dockMode = root.dockMode == switchTo ? "dock" : switchTo;
        }
        onCloseDockMain: () => {
            root.dockMode = "dock";
        }
    }

    Bar {
    }

    ReserveWindow {
        mode: dockMode
    }

}
