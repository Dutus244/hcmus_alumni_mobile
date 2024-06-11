import 'package:hcmus_alumni_mobile/model/vote.dart';

class VoteResponse {
  final List<Vote> votes;
  String voteSelectedOne;
  List<String> voteSelectedMultiple;
  int totalVote;

  VoteResponse(
      {required this.votes,
      required this.voteSelectedOne,
      required this.voteSelectedMultiple,
      required this.totalVote});

  factory VoteResponse.fromJson(Map<String, dynamic> json) {
    var votesList =
        (json['votes'] as List).map((i) => Vote.fromJson(i)).toList();
    var votedSelectedOne = '';
    List<String> voteSelectedMultiple = [];
    var totalVote = 0;
    for (var vote in votesList) {
      if (vote.isVoted) {
        votedSelectedOne = vote.name;
        voteSelectedMultiple.add(vote.name);
      }
      totalVote = totalVote + vote.voteCount;
    }
    return VoteResponse(
        votes: votesList,
        voteSelectedOne: votedSelectedOne,
        voteSelectedMultiple: voteSelectedMultiple,
        totalVote: totalVote);
  }
}
