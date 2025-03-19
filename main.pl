# importing league_data
:- consult(league_data).


# TASK 1
# if there is no player in the given team
players_in_team(_, []).

players_in_team(Team, [Player | Rest]) :-
    player(Player, Team, _),
    players_in_team(Team, Rest).

