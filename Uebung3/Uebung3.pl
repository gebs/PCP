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
        N > 0,
        N1 is N-1,
        ( 
            fak_as(N,F) -> 
                write('Hinweis: Fakultät von '),
                write(N),
                write(' war gespeichert')
        ;   fak(N1,F1),
            F is N * F1,
            asserta(fak_as(N,F))
        ).