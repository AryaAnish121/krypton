// credit: https://github.com/Afillated/quickshell-carbonflake/blob/main/services%2FMprisPlayers.qml

pragma Singleton

import Quickshell
import Quickshell.Services.Mpris

Singleton {
    readonly property list<MprisPlayer> rawPlayerList: Mpris.players.values
    readonly property list<MprisPlayer> playerList: rawPlayerList.filter(player => player.identity != "Google Chrome")
    property MprisPlayer selectedPlayer: playerList.length > 0 ? playerList[activeIndex] : null
    readonly property MprisPlayer activePlayer: selectedPlayer
    property int activeIndex: 0
    property string playerName: selectedPlayer?.identity ?? ""
}