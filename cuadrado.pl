:- use_package(trace).

esCuadradoFantasticoSecreto(Matriz, N):- equal(extraerN(Matriz), N).

equal(0,0).
equal(s(X),s(Y)) :- equal(X,Y).

first([H|_],H).
last([X],X).
last(_|Z],X) :- last(Z,X).

sum(0, X, X).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).

extraerN(Matriz) :-
	first(Matriz, F1),
	first(F1, A),
	last(F1, B),
	last(Matriz, F2),
	first(F2, C),
	last(F2, D),
	checkSecret(A,B,C,D).
checkSecret(A,B,C,D) :-
	equal(A,B),
	sum(C,D,R)
	equal(A,R).

checkSecret(A,B,C,D) :-
	equal(A,C),
	sum(B,D,R),
	equal(A,R).

checkSecret(A,B,C,D) :-
	equal(A,D),
	sum(B,C,R),
	equal(A,R).

checkSecret(A,B,C,D) :-
	equal(B,C),
	sum(A,D,R),
	equal(B,R).

checkSecret(A,B,C,D) :-
	equal(B,D),
	sum(A,C,R),
	equal(B,R).

checkSecret(A,B,C,D) :-
	equal(C,D),
	sum(A,B,R),
	equal(C,R).
:- use_package(trace).

esCuadradoFantasticoSecreto(Matriz, N):-
	first(Matriz, F1),
	first(F1, A),
	last(F1, B),
	last(Matriz, F2),
	first(F2, C),
	last(F2, D),
	checkSecret(A,B,C,D,N).


equal(0,0).
equal(s(X),s(Y)) :- equal(X,Y).

first([H|_],H).
last([X],X).
last(_|Z],X) :- last(Z,X).

sum(0, X, X).
sum(s(X), Y, s(Z)) :- sum(X, Y, Z).

extraerN(Matriz) :-
	

checkSecret(A,B,C,D,N) :-
	equal(A,B),
	sum(C,D,R),
	equal(A,R),
	equal(A,N).

checkSecret(A,B,C,D,N) :-
	equal(A,C),
	sum(B,D,R),
	equal(A,R),
	equal(A,N).        

checkSecret(A,B,C,D,N) :-
	equal(A,D),
	sum(B,C,R),
	equal(A,R),
	equal(A,N).

checkSecret(A,B,C,D,N) :-
	equal(B,C),
	sum(A,D,R),
	equal(B,R),
	equal(B,N).

checkSecret(A,B,C,D,N) :-
	equal(B,D),
	sum(A,C,R),
	equal(B,R),
	equal(B,N).

checkSecret(A,B,C,D,N) :-
	equal(C,D),
	sum(A,B,R),
	equal(C,R),
	equal(C,N).
