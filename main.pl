% importing league_data
:- consult(league_data).

% Helper functions

not_found(_, []) :- !.
not_found(X, [X|_]) :- !,fail.
not_found(X, [_|T]) :- not_found(X, T).

myReverse([],Acc,Acc).
myReverse([H|T],Acc,Rev):- myReverse(T,[H|Acc],Rev).
myReverse(List,Rev):- myReverse(List,[],Rev).

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

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

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

% Task 2

team_count_by_country(Country, N):-
    teams_by_country(Country, 0, N, []).


teams_by_country(Country, N, Count, Teams):-
    team(Name, Country, _), 
    not_found(Name, Teams),
    N1 is N+1,
    teams_by_country(Country, N1, Count, [Name|Teams]),
    !.

teams_by_country(_, N, N, _):- !.

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

% TASK 3
most_successful_team(Team) :-
    best_team([], '', 0, Team).

best_team(Visited, CurrentBest, MaxWins, BestTeam) :-
    team(TeamName, _, NumWins),
    not_found(TeamName, Visited), 
    ( NumWins > MaxWins ->
        best_team([TeamName | Visited], TeamName, NumWins, BestTeam)  
    ;
        best_team([TeamName | Visited], CurrentBest, MaxWins, BestTeam)  
    ),
    !.

best_team(_, BestTeam, _, BestTeam). 

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

% Task 4
matches_of_team(Team, L):-
    team_matches(Team, [], RevL),
    myReverse(RevL,[],L).

team_matches(Team, Matches, Matches2):-
    (match(Team, Team2, Team1Goals, Team2Goals), 
            Match = (Team, Team2, Team1Goals, Team2Goals);
        match(Team2, Team, Team1Goals, Team2Goals), 
            Match = (Team2, Team, Team1Goals, Team2Goals)),
    not_found(Match, Matches), 
    team_matches(Team, [Match | Matches], Matches2),
    !.

team_matches(_, Matches, Matches):- !.

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %


% Task 5

num_matches_of_team(Team, N):-
    team_matches(Team, 0, N, []).

team_matches(Team, N, Count, Matches):-
    ( match(Team, Team2, _, _), Match = (Team, Team2);
        match(Team2, Team, _, _), Match = (Team2, Team)),
    not_found(Match, Matches),  
    N1 is N+1,
    team_matches(Team, N1, Count, [Match | Matches]),
    !.

team_matches(_, N, N, _):- !.

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

% Task 6

top_scorer(P):-
    helper_top_scorer([], 0, '', P).

helper_top_scorer(Players, N, CurrentBest, BestPlayer):-
    goals(Player, Num_of_goals),
    not_found(Player, Players), 
    ( Num_of_goals > N ->
        helper_top_scorer([Player | Players], Num_of_goals, Player, BestPlayer)  
    ;
    helper_top_scorer([Player | Players], N, CurrentBest, BestPlayer)  
    ),
    !.

helper_top_scorer(_, _,BestPlayer, BestPlayer).  

% ---------------------------------------------------------------------------------------------------------------------------------------------------------------------------- %

% Task 7
