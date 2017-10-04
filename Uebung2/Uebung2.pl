%swipl
%

female(mary). female(liz). female(mia). female(tina). female(ann). female(sue).     % all females
male(mike). male(jack). male(fred). male(tom). male(joe). male(jim).                % all males
parent(mary, mia). parent(mary, fred). parent(mary, tina).                          % all childern of mary
parent(mike, mia). parent(mike, fred). parent(mike, tina).                          % all children of mike
parent(liz, tom). parent(liz, joe).                                                 % all childern of liz
parent(jack, tom). parent(jack, joe).                                               % all childern of jack
parent(mia, ann).                                                                   % all childern of mia
parent(tina, sue). parent(tina, jim).                                               % all childern of tina
parent(tom, sue). parent(tom, jim).                                                 % all childern of tom
% a).
mother(X,Y) :- female(X), parent(X,Y).
father(X,Y) :- male(X), parent(X,Y).

%father(X,jim). 
%mother(X,jim). 
%parent(mary,X).

% b).
sibling(X,Y) :- parent(Z,X), parent(Z,Y).

% c).
grandmother(X,Y) :- 
                parent(Z,Y),
                mother(X,Z).
%grandmother(X,jim).

%d).
offspring(X,Y) :- parent(Y,X).
offspring(X,Y) :-
                parent(Z,X),
                offspring(Z,Y).


%3
word(n,e,u). word(t,o,p). word(t,o,t). word(b,r,o,t). word(g,r,a,u). word(h,a,l,t). word(a,l,l,e). word(j,e,t,z,t). word(s,a,g,e,n).
word(u,n,t,e,n). word(z,e,c,k,e).

solution(L1,L2,L3,L4,L5,L6,L7,L8,L9,L10,L11,L12) :-
                                            word(L2,L3,L4,L5),
                                            word(L8,L9,L10,L11,L12),
                                            word(L1,L3,L6,L8),
                                            word(L5,L7,L10).
%grau / brot / tot / unten

%4
n(yellow,red). n(yellow,green). n(red,green).

colors(LU,NW,OW,SZ,UR,ZG) :-
                            UR = yellow,
                            SZ = red,
                            n(LU,ZG),n(LU,SZ),n(LU,NW),n(LU,OW),
                            n(ZG,SZ),
                            n(SZ,NW),n(SZ,UR),
                            n(NW,OW),n(NW,UR).
%5
%op(1150,xfx,mother). 
%op(1150,xfx,offspring).

%6
%a).
%Alle operatoren haben die gleiche Präzedenz daher werden diese einfach von links nach rechts abgearbeitet
%b).
%Y=3, X = 3-1
%c).
%Y=3, X=2
%Bei der Aufgabe b). wird X der Wert 3-1 zugewiesen, in aufgabe c). wird durch das "is" eine Ausrechnung erzwungen

%7
mult(0,0,0).
mult(X,0,Z) :-
            Z is 0.
mutl(0,Y,Z) :-
            Z is 0.
mult(X,Y,Z) :-
            X > 1,
            X1 is X -1,
            X2 is X -2,
            mult(X1,Y,Z1),
            mult(X2,Y,Z2),
            Z is Z2 + Z1.
