% importing league_data
:- consult(league_data).

% Helper functions

not_found(_, []) :- !.
not_found(X, [X|_]) :- !,fail.
not_found(X, [_|T]) :- not_found(X, T).

myReverse([],Acc,Acc).
myReverse([H|T],Acc,Rev):- myReverse(T,[H|Acc],Rev).
myReverse(List,Rev):- myReverse(List,[],Rev).

% TASK 1

players_in_team(Team, List) :-
    collect_players(Team, [], RevList),
    myReverse(RevList,[],List),
    % stopping emidiatly to prevent backtracking  
    !.  

collect_players(Team, Acc, List) :-
    player(Player, Team, _),
    % prevent dublicates
    not_found(Player, Acc),
    collect_players(Team, [Player|Acc], List).

% Base case no new player added
collect_players(_, Acc, List) :-
    Acc = List.

% Task 2

team_count_by_country(Country, N):-
    teams_by_country(Country, 0, N, []).

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %





teams_by_country(Country, N, Count, Teams) :-
    team(Name, Country, _), 
    not_found(Name, Teams),
    N1 is N+1,
    teams_by_country(Country, N1, Count, [Name|Teams]),
    !.

teams_by_country(_, N, N, _) :- !.
