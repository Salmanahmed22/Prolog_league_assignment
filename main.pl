:- consult(league_data).
players_in_team(Team, Players) :-
    findall(Player, player(Player, Team, _), Players).

