import 'package:hcmus_alumni_mobile/model/vote.dart';

class VoteResponse {
  final List<Vote> votes;
  String voteSelected;
  int totalVote;

  VoteResponse(
      {required this.votes,
      required this.voteSelected,
      required this.totalVote});

  factory VoteResponse.fromJson(Map<String, dynamic> json) {
    var votesList =
        (json['votes'] as List).map((i) => Vote.fromJson(i)).toList();
    var votedSelected = '';
    var totalVote = 0;
    for (var vote in votesList) {
      if (vote.isVoted) {
        votedSelected = vote.name;
      }
      totalVote = totalVote + vote.voteCount;
    }
    return VoteResponse(
        votes: votesList, voteSelected: votedSelected, totalVote: totalVote);
  }
}
