internal class EnchiladaRaceFactory {
    internal EnchiladaRace Create(int tournamentId, List<EnchiladaRaceEntry> entries, int id, int raceNum) {
        return new EnchiladaRace() {
            TournamentId = tournamentId,
            RaceEntries = entries,
            Id = id,
            RaceNumber = raceNum
        };
    }
}