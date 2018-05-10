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
%eval9D(X,L) :- last(X,S),
%	equals(S,s(s(s(s(s(s(s(s(s(0)))))))))),
%	borraUltimoElem(X,L).

%eval9E(X) :- reverse(X,Xs),
%	first(Xs,S),
%	equals(S,s(s(s(s(s(s(s(s(s(0))))))))),
%	borraUltimoElem(S,Y),
%	append(Y,[0],Z),
%	eval9E(Z).

behead([_|A],A).

adjust(A1,B) :-
	behead(A1,A0),
	behead(A0,A),
	first(A,F),
	sum(F,s(0),F1),
	append([F1],A,B).

overflow(A,A) :-
	first(A,F),
	ls_or_equal(F,s(s(s(s(s(s(s(s(s(0)))))))))).

overflow(A,D) :-
	first(A,F),
	gt_or_equal(F,s(s(s(s(s(s(s(s(s(s(0))))))))))),
	adjust(A,B),
	overflow(B,C),
	append([0],C,D).

formatNumber(PEntR,_,0,PE1,_) :-
	reverse(PEntR,B),
	overflow(B,C),
	reverse(C,PE1).

formatNumber(PEntR,PDecR,s(0),PE1,[PD1]) :-
	append(PEntR,PDecR,A),
	reverse(A,B),
	overflow(B,C),
	reformatDec(C,PD1,D),
	reverse(D,PE1).

formatNumber(PEntR,PDecR,s(s(0)),PE1,PD1) :-
	append(PEntR,PDecR,A),
	reverse(A,B),
	overflow(B,C),
	reformatCent(C,D,E),
	reverse(E,PE1),
	reverse(D,PD1).

reformatDec([H|T],H,T).

reformatCent([H|T],D,E) :-
	reformatDec(T,A,E),
	append([H],[A],D).

% Functores ppales del programa
redondearDecimal(NI, redondeoUnidad, redondeo(redondeoUnidad,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntR,PDecR))) :-
	extComa(NI,PEntO,PDecO),
	redU(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,0,PEntR,PDecR).
redondearDecimal(NI, redondeoDecima, redondeo(redondeoDecima,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntR,PDecR))) :-
	extComa(NI,PEntO,PDecO),
	redD(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,s(0),PEntR,PDecR).
redondearDecimal(NI, redondeoCentesima, redondeo(redondeoCentesima,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntR,PDecR))) :-
	extComa(NI,PEntO,PDecO),
	redC(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,s(s(0)),PEntR,PDecR).

% Elegir tipo de redondeo en funcion del numero de digitos en la parte decimal
redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C,s(0)),
	compU(PEnt,PDec,PEntR,PDecR).

redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C, s(s(0))),
	compD(PEnt,PDec,PEntR0,PDecR0),
	append([','],PDecR0,A),
	append(PEntR0,A,A0),
	redU(A0,PEntR,PDecR).

redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C, s(s(s(0)))),
	compC(PEnt,PDec,PEntR0,PDecR0),
	append([','],PDecR0,A),
	append(PEntR0,A,A0),
	redU(A0,PEntR,PDecR).

redD(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C, s(s(0))),
	compD(PEnt,PDec,PEntR,PDecR).

redD(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C, s(s(s(0)))),
	compC(PEnt,PDec,PEntR0,PDecR0),
	append([','],PDecR0,A),
	append(PEntR0,A,A0),
	redD(A0,PEntR,PDecR).

redC(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equals(C, s(s(s(0)))),
	compC(PEnt,PDec,PEntR,PDecR).

% Functores que realizan el redondeo a la unidad
compU(PEnt,PDec,PEnt,[]) :-
	last(PDec, L),
	ls_or_equal(L, s(s(s(s(0))))).

compU(PEnt,PDec,PEntR,[]) :-
	last(PDec, L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	reverse(PEnt,R),
	first(R,F),
	sum(F, s(0), S),
	reverse(R,R2),
	borraUltimoElem(R2,R3),
	append(R3,[S],PEntR).

% Functores que realizan el redondeo a la decima
compD(PEnt,PDec,PEnt,PDecR) :-
	last(PDec,L),
	ls_or_equal(L, s(s(s(s(0))))),
	borraUltimoElem(PDec,PDecR).

compD(PEnt,PDec,PEnt,PDecR) :-
	last(PDec,L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	borraUltimoElem(PDec,B),
	last(B,L0),
	sum(L0,s(0),S),
	borraUltimoElem(B, B0),
	append(B0,[S],PDecR).

% Functores que realizan el redondeo a la centesima
compC(PEnt,PDec,PEnt,PDecR) :-
	last(PDec,L),
	ls_or_equal(L, s(s(s(s(0))))),
	borraUltimoElem(PDec,PDecR).

% Caso en el que hay uno o mas 9
%compC(PEnt,PDec,PEnt,PDecR) :-
%	last(PDec,L),
%	gt_or_equal(L, s(s(s(s(s(0)))))),
%	borraUltimoElem(PDec, B),
%	last(B,L0),
%	eval9D(L0,L1),
%	sum(L0,s(0),S),
%	borraUltimoElem(B, B0),
%	append(B0,[S],PDecR).

compC(PEnt,PDec,PEnt,PDecR) :-
	last(PDec,L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	borraUltimoElem(PDec, B),
	last(B,L0),
	sum(L0,s(0),S),
	borraUltimoElem(B, B0),
	append(B0,[S],PDecR).

%%%% Antes de sum hay que evaluar si el num L0 es 9

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% EJERCICIO 2 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que se hace verdadero cuando los elementos de las esquinas de la 
% matriz que se le pasa como parametro cumplen la propiedad del numero secreto

esCuadradoFantasticoSecreto(Matriz, N):-
	first(Matriz, F1),			%Se extrae la primera fila de la matriz
	first(F1, A),				%Se extrae el primer elemento de la primera fila		
	last(F1, B),				%Se extrae el ultimo elemento de la primera fila
	last(Matriz, F2),			%Se extrae la ultima fila de la matriz
	first(F2, C),				%Se extrae el primer elemento de la ultima fila
	last(F2, D),				%Se extrae el ultimo elemento de la ultima fila
	checkSecret(A,B,C,D,N).		%Se comprueba que los elementos extraidos cumplen las condiciones

%Predicado que se hace verdadero si dos numeros en notacion de Peano son iguales.
equal(0,0).
equal(s(X),s(Y)) :- equal(X,Y).

%Predicado que suma dos numeros en notacion de Peano
add(0, X, X).
add(s(X), Y, s(Z)) :- add(X, Y, Z).

%Estos 6 predicados comprueban si de los 5 elementos, 2 son iguales entre ellos
%e iguales a la suma de los otros dos, y este resultado es igual al quinto elemento.
%Todos funcionan igual, solo cambia el orden de los elementos probados.

checkSecret(A,B,C,D,N) :-
	equal(A,B),  	%Dos de los elementos de las esquinas son iguales
	add(C,D,R),		%Se suman los elementos de las otras dos esquinas
	equal(A,R),		%Se comprueba que la suma sea igual a los dos primeros elementos
	equal(A,N).		%Se comprueba que sean iguales al quinto elemento

checkSecret(A,B,C,D,N) :-
	equal(A,C),
	add(B,D,R),
	equal(A,R),
	equal(A,N).        

checkSecret(A,B,C,D,N) :-
	equal(A,D),
	add(B,C,R),
	equal(A,R),
	equal(A,N).

checkSecret(A,B,C,D,N) :-
	equal(B,C),
	add(A,D,R),
	equal(B,R),
	equal(B,N).

checkSecret(A,B,C,D,N) :-
	equal(B,D),
	add(A,C,R),
	equal(B,R),
	equal(B,N).

checkSecret(A,B,C,D,N) :-
	equal(C,D),
	add(A,B,R),
	equal(C,R),
	equal(C,N).
