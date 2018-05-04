:- use_package(trace).

alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').

nat(0).
nat(s(N)) :-
	nat(N).

equals(0,0).
equals(s(X),s(Y)) :-
	equals(X,Y).

ls_or_equal(0,X) :- nat(X).
ls_or_equal(s(X),s(Y)) :-
	ls_or_equal(X,Y).

gt_or_equal(X,0) :- nat(X).
gt_or_equal(s(X),s(Y)) :-
	gt_or_equal(X,Y).

first([H|_],H).

last([X],X).
last([_|Z],X) :-
	last(Z,X).

borraUltimoElem([X|Xs], Ys) :-
	borraUltElemAux(Xs, Ys, X).

borraUltElemAux([], [], _).
borraUltElemAux([X1|Xs], [X0|Ys], X0) :-
	borraUltElemAux(Xs, Ys, X1).

sum(0, X, X).
sum(s(X), s(0), s(Z)) :-
	sum(X, s(0), Z).

copia(A,B) :-
	cp(A,B).
cp([],[]).
cp([H|T1],[H|T2]) :-
	cp(T1,T2).

append([],X,X).
append([X|Y], Z, [X|W]) :-
	append(Y, Z, W).

reverse([],[]).
reverse([X|Xs],Ys) :-
	reverse(Xs,Zs),
	append(Zs,[X],Ys).

count([],0).
count([_|T], N) :-
	count(T, N1),
	sum(N1, s(0), N).

extComa([','|B],[],B).
extComa([A|As],[A|B],C) :-
	extComa(As,B,C).

%eval9D(X) :- last(X, S),
%	equals(S,s(s(s(s(s(s(s(s(s(0)))))))))),
%	borraUltimoElem(X,L),
%	eval9D(L).

%eval9E(X) :- reverse(X,Xs),
%	first(Xs,S),
%	equals(S,s(s(s(s(s(s(s(s(s(0)))))))))),
%	borraUltimoElem(S,Y),
%	append(Y,[0],Z)
%	eval9E(Z).

redondearDecimal(NI, redondeoUnidad, NF) :-
	redU(NI, NF).
redondearDecimal(NI, redondeoDecima, NF) :-
	redD(NI, NF).
redondearDecimal(NI, redondeoCentesima, NF) :-
	redC(NI, NF).

% Copia del 9
%compU(NI,NF) :-
%	extComa(NI,E,D),
%	last(D, S),
%	reverse(E,R),
%	first(R,X),
%	equals(S,s(s(s(s(s(s(s(s(s(0)))))))))),
%	borraUltimoElem(NI,L),
%	compU(L,NF).

compU(NI,NF) :-
	extComa(NI,NF,D),
	last(D, S),
	ls_or_equal(S, s(s(s(s(0))))).

compU(NI,NF) :-
	extComa(NI,E,D),
	last(D, S),
	gt_or_equal(S, s(s(s(s(s(0)))))),
	reverse(E,R),
	first(R,X),
	sum(X, s(0), F),
	reverse(R,R2),
	borraUltimoElem(R2,R3),
	append(R3,[F],NF).

compD(NI,NF) :-
	extComa(NI,_,D),
	last(D,S),
	ls_or_equal(S, s(s(s(s(0))))),
	borraUltimoElem(NI,NF).

compD(NI,NF) :-
	extComa(NI,_,D),
	last(D,S),
	gt_or_equal(S, s(s(s(s(s(0)))))),
	borraUltimoElem(NI,X),
	last(X,S0),
	sum(S0,s(0),C2),
	borraUltimoElem(X, X2),
	append(X2,[C2],NF).

compC(NI,NF) :-
	extComa(NI,_,D),
	last(D,S),
	ls_or_equal(S, s(s(s(s(0))))),
	borraUltimoElem(NI, NF).

compC(NI,NF) :-
	extComa(NI,_,D),
	last(D,S),
	gt_or_equal(S, s(s(s(s(s(0)))))),
	borraUltimoElem(NI, X),
	last(X,S0),
	sum(S0,s(0),C2),
	borraUltimoElem(X, X2),
	append(X2,[C2],NF).
	
%compD([H|T],NF) :-
%	last(T,S),
%	gt_or_equal(S, s(s(s(s(s(0)))))),
%	borraUltimoElem([H|T], X),
%	reverse(X,S0),
%	sum(S0,s(0),C2),
%	reverse(C2,NF).

redU(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C,s(0)),
	compU(NI,NF).

redU(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C, s(s(0))),
	compD(NI,A),
	redU(A,NF).

redU(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C, s(s(s(0)))),
	compC(NI,A),
	redU(A,NF).

redD(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C, s(s(0))),
	compD(NI,NF).

redD(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C, s(s(s(0)))),
	compC(NI,A),
	redD(A,NF).

redC(NI,NF) :-
	extComa(NI,_,D),
	count(D,C),
	equals(C, s(s(s(0)))),
	compC(NI,NF).