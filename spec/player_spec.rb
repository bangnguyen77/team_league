require("spec_helper")

describe(Player) do
  describe("#team") do
    it("tells which team it belongs to") do
      test_team = Team.create({:name => "Portland"})
      test_player = Player.create({:name => "Mike", :team_id => test_team.id()})
      expect(test_player.team()).to(eq(test_team))
    end
  end
end
