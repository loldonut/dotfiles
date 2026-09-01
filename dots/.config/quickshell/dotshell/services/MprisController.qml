pragma Singleton
import Quickshell
import Quickshell.Services.Mpris

Singleton {
  id: root

  property list<MprisPlayer> players: Mpris.players.values.filter(root.isValidPlayer)
  property MprisPlayer activePlayer: players[0] ?? null

  function isValidPlayer(player) {
    return (player?.trackTitle && player?.trackArtist);
  }
}
