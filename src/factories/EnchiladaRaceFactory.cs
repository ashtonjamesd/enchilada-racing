internal class EnchiladaRaceFactory {
    internal EnchiladaRace Create(int tournamentId, List<EnchiladaRaceEntry> entries, int id, int raceNum, int trackId) {
        return new EnchiladaRace() {
            TournamentId = tournamentId,
            RaceEntries = entries,
            Id = id,
            RaceNumber = raceNum,
            TrackId = trackId
        };
    }
}