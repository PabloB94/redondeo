:- use_package(trace).

alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').


%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% EJERCICIO 1 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nat(0).           % Cero es un numero natural
nat(s(N)) :-      % El sucesor de un numero natural es un numero natural
	nat(N).

equals(0,0).      % Functor para evaluar si dos elementos son iguales
equals(s(X),s(Y)) :-
	equals(X,Y).

ls_or_equal(0,X) :- nat(X).      % Functor que evalua si un numero es menor o igual que el otro
ls_or_equal(s(X),s(Y)) :-
	ls_or_equal(X,Y).

gt_or_equal(X,0) :- nat(X).      % Functor que evalua si un numero es mayor o igual que el otro
gt_or_equal(s(X),s(Y)) :-
	gt_or_equal(X,Y).

first([H|_],H).         % El primer elemento de una lista es la cabeza de la lista

last([X],X).            % Functor que devuelve el ultimo elemento de una lista
last([_|Z],X) :-
	last(Z,X).

borraUltimoElem([X|Xs], Ys) :-         % Functor que borra el ultimo elem de una lista
	borraUltElemAux(Xs, Ys, X).

borraUltElemAux([], [], _).
borraUltElemAux([X1|Xs], [X0|Ys], X0) :-
	borraUltElemAux(Xs, Ys, X1).

sum(0, X, X).               % Suma 1 en representacion peano al numero a redondear
sum(s(X), s(0), s(Z)) :-
	sum(X, s(0), Z).

append([],X,X).             % Concatenacion de listas
append([X|Y], Z, [X|W]) :-
	append(Y, Z, W).

reverse([],[]).             % Invierte una lista
reverse([X|Xs],Ys) :-
	reverse(Xs,Zs),
	append(Zs,[X],Ys).

count([],0).                % Contador del numero de digitos a cada uno de los lados de la coma
count([_|T], N) :-
	count(T, N1),
	sum(N1, s(0), N).

extComa([','|B],[],B).      % Functor que divide el numero dado en parte entera y parte decimal
extComa([A|As],[A|B],C) :-
	extComa(As,B,C).

% Intento de resolver el problema del acarreo
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

% Functores ppales del programa
redondearDecimal(NI, redondeoUnidad, NF) :-
	redU(NI, NF).
redondearDecimal(NI, redondeoDecima, NF) :-
	redD(NI, NF).
redondearDecimal(NI, redondeoCentesima, NF) :-
	redC(NI, NF).

% Elegir tipo de redondeo en funcion del numero de digitos en la parte decimal
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

% Functores que realizan el redondeo a la unidad
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

% Functores que realizan el redondeo a la decima
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

% Functores que realizan el redondeo a la centesima
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

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% EJERCICIO 2 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

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