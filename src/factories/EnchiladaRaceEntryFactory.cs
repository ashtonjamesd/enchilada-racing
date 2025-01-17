internal class EnchiladaRaceEntryFactory {
    internal EnchiladaRaceEntry Create(int racerId, string raceTime, bool isKnockout) {
        return new EnchiladaRaceEntry() {
            RacerId = racerId,
            RaceTime = raceTime,
            IsKnockout = isKnockout
        };
    }
}