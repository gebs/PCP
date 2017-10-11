%1.
fib_tr(N,F) :- fib_tr(N,0,1,F).
fib_tr(0,A,_,A).
fib_tr(N,A,B,F) :-
                N1 is N-1,
                N1 >= 0,
                Sum is A + B,
                fib_tr(N1,B,Sum,F).
io_fib() :- 
            write('Gib eine Zahl ein:'),
            nl,
            read(X),            
            fib_tr(X,Y),
            atom_concat('Die ', X, Z),
            atom_concat(Z,'. Fibonacci-Zahl ist: ',Z1),
            atom_concat(Z1, Y, Z2),
            write(Z2).

%2.
:- dynamic fak_as/2. 
fak(0,1).
fak(N,F) :- 
        fak_as(N,F),
        atom_concat('(Hinweis: Fakultät von ', N, A),
        atom_concat(A, ' war gespeichert)', B),
        write(B).
fak(N,F) :-
        N > 0,
        N1 is N-1,
        fak(N1,F1),
        F is N * F1,
        asserta(fak_as(N,F)).

%2. b).
fak_clear :-
    retractall(fak_as(_, _)),
    write('(Hinweis: Alle gespeicherten Werte wurden gelöscht)').

%3 a).
add_tail(X, [], [X]).
add_tail(X,[Head|Tail],[Head|L]) :- 
                        add_tail(X,Tail,L).

%3 b).



%4
p(X) :- a(X).
p(X) :- b(X),!, c(X).
p(X) :- d(X).
a(1).
b(2).
b(3).
c(2).
c(3).
d(4).


%5
warn(T) :- T < 80, write('Temparatur ok').
warn(T) :- T > 80, T < 100, write('Temparatur sehr warm').
warn(T) :- T > 100, write('Temparatur zu heiss').

% Ohne Cut Operator muss darauf geachtet werden dass sich die einzelnen Reglen ausschliessen. Ansonsten gibt es mehrere Lösungen.

mem(X, [X | _]) :- !.
mem(X, [_| Tail]) :- mem(X, Tail).
% Der CUT Operator im ersten Prädikat verhindert das Backtracking, und somit die Suche nach weiteren Lösungen.