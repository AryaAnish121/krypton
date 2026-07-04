//@ pragma UseQApplication

import Quickshell

Scope {
    id: root

    property string dockMode: "dock"

    Dock {
        mode: dockMode
        onSwitchMode: (switchTo) => {
            root.dockMode = switchTo;
        }
        onCloseDockMain: () => {
            console.log("hi");
            root.dockMode = "dock";
        }
    }

    Bar {
    }

    ReserveWindow {
        mode: dockMode
    }

}
