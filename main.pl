% importing league_data
:- consult(league_data).

% TASK 1

players_in_team(Team, List) :-
    collect_players(Team, [], RevList),
    % Reverse to maintain order of finding the players
    reverse(RevList, List),
    % stopping emidiatly to prevent backtracking  
    !.  

collect_players(Team, Acc, List) :-
    player(Player, Team, _),
    % prevent dublicates
    \+ member(Player, Acc),  
    collect_players(Team, [Player|Acc], List).

% Base case
collect_players(_, Acc, List) :-
    Acc = List.



