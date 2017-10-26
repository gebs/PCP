:- use_module(library(http/json)).
:- use_module(library(http/http_client)).
:- use_module(library(http/json_convert)).
:- use_module(library(http/http_json)).
:- use_module(library(clpfd)).
:- use_module(library(clpr)).

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Aufgabe 1 -------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

fib_clp(N, F) :- { N = 0, F = 0 }.
fib_clp(N, F) :- { N = 1, F = 1 }.
fib_clp(N, F) :-
            { N >= 2,
              F = F1+F2,
              N1 = N-1,
              N2 = N-2,
              F1 >= N1 -1,
              F2 >= N2 -1},
            fib_clp(N1, F1),
            fib_clp(N2, F2).

% Prolog versucht mit allen reellen Zahlen zu eine Resultat zu kommen,
% l�uft ewig....
% Zus�tzliche Abbruchbedingung damit F nicht unendlich wachsen kann.
% F muss immer gr�sser (oder gleich) sein wie N -1

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Aufgabe 2 -------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

set_difference([H|Set1], Set2,[H|SetDifference]) :-
                                        \+ member(H,Set2),
                                        set_difference(Set1,Set2,SetDifference).
set_difference([H|Set1],Set2,SetDifference) :-
                                        member(H,Set2),
                                        set_difference(Set1,Set2,SetDifference).
set_difference([],_,[]).

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Aufgabe 3 a). ---------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------
%   {T=15,M=3*T,(M=2*T+J)}.
%
%   Nach 15 Jahre ist die Mutter nur noch doppelt so alt
%
%----------------------------------------------------------------------------------------------------------------------------------------------------

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Aufgabe 3 b). ---------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

zr([D,O,N,A,L,D] + [G,E,R,A,L,D] = [R,O,B,E,R,T]) :-
                            Vars = [D,O,N,A,L,G,E,R,B,T],
                            Vars ins 0..9,
                            all_distinct(Vars),
                             D*100000 + O*10000 + N*1000 + A*100 + L*10 + D +
                             G*100000 + E*10000 + R*1000 + A*100 + L*10 + D #=
                             R*100000 + O*10000 + B*1000 + E*100 + R*10 + T,
                            D #\= 0, G #\=0, R #\= 0,
                            label(Vars).

%  526485
% +197485
% =723970
%----------------------------------------------------------------------------------------------------------------------------------------------------
% zr(As + Bs = Cs).
%----------------------------------------------------------------------------------------------------------------------------------------------------


%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Relation --------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).     % all females
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).                % all males
parent(mary, mia). parent(mary, fred). parent(mary, tina).                          % all childern of mary
parent(mike, mia). parent(mike, fred). parent(mike, tina).                          % all children of mike
parent(liz, tom). parent(liz, joe).                                                 % all childern of liz
parent(jack, tom). parent(jack, joe).                                               % all childern of jack
parent(mia, ann).                                                                   % all childern of mia
parent(tina, sue). parent(tina, jim).                                               % all childern of tina
parent(tom, sue). parent(tom, jim).                                                 % all childern of tom

mother(X,Y) :- female(X), parent(X,Y).
father(X,Y) :- male(X), parent(X,Y).

sibling(X,Y) :- parent(Z,X), parent(Z,Y).

grandmother(X,Y) :-
                parent(Z,Y),
                mother(X,Z).

offspring(X,Y) :- parent(Y,X).
offspring(X,Y) :-
                parent(Z,X),
                offspring(Z,Y).

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Sudoku ----------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------
sudoku(Rows) :-
            append(Rows, Vs), Vs ins 1..9,
            maplist(all_distinct, Rows),
            transpose(Rows, Columns),
            maplist(all_distinct, Columns),
            Rows = [A, B, C, D, E, F, G, H, I],
            blocks(A, B, C), blocks(D, E, F), blocks(G, H, I),
            maplist(label, Rows).
blocks([], [], []).
blocks([A, B, C|Bs1], [D, E, F|Bs2], [G, H, I|Bs3]) :-
            all_distinct([A, B, C, D, E, F, G, H, I]),
            blocks(Bs1, Bs2, Bs3).

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Solve -----------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

solve(Problem,ID) :-
            solve(Problem,ID,16316).

solve(Problem,ID,Port) :-
            atom_concat('http://127.0.0.1:',Port,URL1),
            atom_concat(URL1,'/problem/',URL2),
            atom_concat(URL2,Problem,URL3),
            atom_concat(URL3,'/',URL4),
            atom_concat(URL4,ID,URL5),
            http_get(URL5,Json,[]),
            json_to_prolog(Json,Object),
            atom_concat('solve_',Problem,FCall),
            call(FCall,Object,Result),
            PostObject = json([problemKey=ID,solution=Result]),
            http_post(URL3,json(PostObject),_,[]).

solve_sudoku(Object,Sudoku) :-
            Object = json([problemKey=_,sudoku= Sud0]),
            maplist(replace_0,Sud0,Sudoku),
            Sudoku = [A,B,C,D,E,F,G,H,I],
            sudoku([A,B,C,D,E,F,G,H,I]).

solve_relationship(Object,Result) :-
            Object = json([firstpersonname= FName,problemKey=_,relationship= Relationship,secondPerson=SName ]),
            call(Relationship,FName,SName),
            Result = true, !.
solve_relationship(_,Result) :-
            Result = false.

%----------------------------------------------------------------------------------------------------------------------------------------------------
%---------------------------------------------------------------------- Utilities -------------------------------------------------------------------
%----------------------------------------------------------------------------------------------------------------------------------------------------

replace_0([],[]).
replace_0([0|L1],[_|L2]) :- replace_0(L1,L2).
replace_0([X|L1],[X|L2]) :- X\= 0,
                        replace_0(L1,L2).
