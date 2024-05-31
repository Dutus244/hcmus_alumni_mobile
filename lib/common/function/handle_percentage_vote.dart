int calculatePercentages(int voteCount, int totalVotes) {
  if (totalVotes == 0) return 0;

  return ((voteCount / totalVotes) * 100).toInt();
}