String handleParticipantCount(int data) {
  if (data < 1000) {
    return data.toString();
  } else {
    int count = (data / 1000).floor();
    return count.toString() + "K";
  }
}
