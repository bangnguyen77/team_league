require("spec_helper")

describe(Team) do
  describe("#players") do
    it("tells which players are in the team") do
      test_team = Team.create({:name => "Portland"})
      test_player = Player.create({:name => "Mike", :team_id => test_team.id()})
      expect(test_team.players()).to(eq([test_player]))
    end
  end
end
