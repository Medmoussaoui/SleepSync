enum SleepStages {
  asleep,
  checking,
  stillAwake,
  areYouThere,
  stop,
}

// Map to associate enum values with strings
final Map<SleepStages, String> sleepStageDescriptions = {
  SleepStages.stillAwake: "You're still awake",
  SleepStages.asleep: "You're asleep",
  SleepStages.checking: "Checking soon",
  SleepStages.areYouThere: "Are you there ?",
  SleepStages.stop: "Stop Trucking",
};
