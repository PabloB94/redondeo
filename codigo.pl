%:- use_package(trace).

%cero.

nat(0).
nat(s(N)) :-
	nat(N).

less_or_equal(0,X) :- nat(X).
less_or_equal(s(X),s(Y)) :-
	less_or_equal(X,Y).

last([X]) :- X.
last([_|Y]) :- last(Y).

%redondeo() :-.

%numeroOriginal(PE, Coma, PD) :-.

redondearDecimal(NI, redondeoUnidad, NF) :-
	redondearUnidades(NI, NF).
redondearDecimal(NI, redondeoDecima, NF) :-
	redondearDecimas(NI, NF).
redondearDecimal(NI, redondeoCentesima, NF) :-
	redondearCentesimas(NI, NF).

redondearDecimas(NI, NF) :-
	redondearDecimas([_|T], NF),
	PD is last(NI),
	Dec is [Dec|PD],
	write(Dec).
	
more_than_five(X) :- less_or_equal(s(s(s(s(0)))), X).


