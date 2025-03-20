% importing league_data
:- consult(league_data).

% TASK 1

players_in_team(Team, List) :-
    collect_players(Team, [], RevList),
    myReverse(RevList,[],List),
    % stopping emidiatly to prevent backtracking  
    !.  

collect_players(Team, Acc, List) :-
    player(Player, Team, _),
    % prevent dublicates
    \+ visited(Player, Acc),
    collect_players(Team, [Player|Acc], List).

% Base case no new player added
collect_players(_, Acc, List) :-
    Acc = List.

% predicate to search it the player is found in the accumalative list.
visited(Player,[Player|_]).

visited(Player,[_|Tail]):-
    visited(Player,Tail).

myReverse([],Acc,Acc).

myReverse([H|T],Acc,Rev):-
    myReverse(T,[H|Acc],Rev).

myReverse(List,Rev):-
    myReverse(List,[],Rev).

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %






