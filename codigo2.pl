:- use_package(trace).

%cero.

nat(0).
nat(s(N)) :-
	nat(N).

ls_or_equal(0,X) :- nat(X).
ls_or_equal(s(X),s(Y)) :-
	ls_or_equal(X,Y).

gt_or_equal(X,0) :- nat(X).
gt_or_equal(s(X),s(Y)) :-
	more_or_equal(X,Y).

first([H|_],H).

last([X],X).
last([_|Z],X) :-
	last(Z,X).

sum(0, X, X).
sum(s(X), s(0), s(Z)) :-
	sum(X, s(0), Z).

%redondeo() :-.

%numeroOriginal(PE, Coma, PD) :-.

redondearDecimal(NI, redondeoUnidad, NF) :-
	redondearUnidades(NI, NF).
redondearDecimal(NI, redondeoDecima, NF) :-
	redondearDecimas(NI, NF).
redondearDecimal(NI, redondeoCentesima, NF) :-
	redondearCentesimas(NI, NF).

compU([H|T],NF) :-
	last(T, S),
	ls_or_equal(S, s(s(s(s(0))))),
	first([H|_], NF).

compU([H|T],NF) :-
	last(T, S),
	gt_or_equal(S, s(s(s(s(s(0)))))),
	first([H|_], X),
	sum(X, s(0), NF).

%redondearUnidades(PD, NF) :-
%	less_or_equal(PD, s(s(s(s(s(0)))))).