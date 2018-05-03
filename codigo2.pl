:- use_package(trace).

%cero.

nat(0).
nat(s(N)) :-
	nat(N).

less_or_equal(0,X) :- nat(X).
less_or_equal(s(X),s(Y)) :-
	less_or_equal(X,Y).

first([H|_],H).

last([X],X).
last([_|Z],X) :-
	last(Z,X).

sum(zero, A, A).
sum(s(A), B, s(C)) :-
	sum(A, B, C).

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
	less_or_equal(S, s(s(s(s(s(0)))))),
	first([H|_], NF).

%redondearUnidades(PD, NF) :-
%	less_or_equal(PD, s(s(s(s(s(0)))))).