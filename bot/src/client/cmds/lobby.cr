require "../game/core"

struct LobbyCmd < Bot::CmdBase
  self.name = "lobby"
  self.desc = "Creates a lobby for a new match."

  def self.execute(args : Array(String)?, payload : Discord::Message)
    if args == [""] || args.nil?
      thread = CLIENT.start_thread(
        channel_id: payload.channel_id,
        message_id: payload.id,
        name: "Lobby of #{payload.author.username}#{payload.author.discriminator}",
        auto_archive_duration: Discord::AutoArchiveDuration::Day,
        reason: nil
      )

      Game::Core.match_new(thread.id)
    end
  end
end