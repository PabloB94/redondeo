:- use_package(trace).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% EJERCICIO 1 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

nat(0).           % Cero es un numero natural
nat(s(N)) :-      % El sucesor de un numero natural es un numero natural
	nat(N).

equal(0,0).      % Functor para evaluar si dos elementos son iguales
equal(s(X),s(Y)) :-
	equal(X,Y).

ls_or_equal(0,X) :- nat(X).      % Functor que evalua si un numero es menor o igual que el otro
ls_or_equal(s(X),s(Y)) :-
	ls_or_equal(X,Y).

gt_or_equal(X,0) :- nat(X).      % Functor que evalua si un numero es mayor o igual que el otro
gt_or_equal(s(X),s(Y)) :-
	gt_or_equal(X,Y).

first([H|_],H).         % El primer elemento de una lista es la cabeza de la lista

lastInList([X],X).            % Functor que devuelve el ultimo elemento de una lista
lastInList([_|Z],X) :-
	lastInList(Z,X).

borraUltimoElem([X|Xs], Ys) :-         % Functor que borra el ultimo elem de una lista
	borraUltElemAux(Xs, Ys, X).

borraUltElemAux([], [], _).
borraUltElemAux([X1|Xs], [X0|Ys], X0) :-
	borraUltElemAux(Xs, Ys, X1).

add(0, X, X).
add(s(X), Y, s(Z)) :- add(X, Y, Z).

concat([],X,X).             % Concatenacion de listas
concat([X|Y], Z, [X|W]) :-
	concat(Y, Z, W).

flipList([],[]).             % Invierte una lista
flipList([X|Xs],Ys) :-
	flipList(Xs,Zs),
	concat(Zs,[X],Ys).

count([],0).                % Contador del numero de digitos a cada uno de los lados de la coma
count([_|T], N) :-
	count(T, N1),
	add(N1, s(0), N).

extComa([','|B],[],B).      % Functor que divide el numero dado en parte entera y parte decimal
extComa([A|As],[A|B],C) :-
	extComa(As,B,C).

behead([_|A],A). % Elimina la cabeza de una lista

% Añade el acarreo al numero
adjust(A1,B) :-
	behead(A1,A),
	first(A,F),
	add(F,s(0),F1),
	behead(A,A2),
	concat([F1],A2,B).

% Functor que evalua el caso para el acarreo
overflow(A,A) :-
	first(A,F),
	ls_or_equal(F,s(s(s(s(s(s(s(s(s(0)))))))))).

overflow(A,D) :-
	first(A,F),
	gt_or_equal(F,s(s(s(s(s(s(s(s(s(s(0))))))))))),
	adjust(A,B),
	overflow(B,C),
	concat([0],C,D).

% Functor que realiza el acarreo y elimina ceros sobrantes de la parte decimal
formatNumber(PEntR,_,0,PE1,_) :-
	concat([0],PEntR,B0),
	flipList(B0,B),
	overflow(B,C),
	removeZero(C,D),
	flipList(D,PE1).

formatNumber(PEntR,PDecR,s(0),PE1,[PD1]) :-
	concat(PEntR,PDecR,A),
	flipList(A,B),
	concat(B,[0],B0),
	overflow(B0,C),
	reformatDec(C,PD0,D),
	removeZero(PD0,PD1),
	flipList(D,PE0),
	removeZero(PE0,PE1).

formatNumber(PEntR,PDecR,s(s(0)),PE1,PD1) :-
	concat(PEntR,PDecR,A),
	flipList(A,B),
	concat(B,[0],B0),
	overflow(B0,C),
	reformatCent(C,D,E),
	flipList(E,PE0),
	removeZero(PE0,PE1),	
	removeZero(D,PD0),
	flipList(PD0,PD1).

% Functor que elimina ceros
removeZero(B,B).
removeZero([H|T],B) :-
	equal(H,0),
	removeZero(T,B).

reformatDec([H|T],H,T).

reformatCent([H|T],D,E) :-
	reformatDec(T,A,E),
	concat([H],[A],D).

% Functor que quita ceros de la parte decimal una vez el numero este redondeado
esCero([],[]).
esCero(PDecR,PDecF) :-
	lastInList(PDecR,L),
	equal(L,0),
	borraUltimoElem(PDecR,B),
	esCero(B,PDecF).

esCero(PDecR,PDecR) :-
	lastInList(PDecR,L),
	gt_or_equal(L,0).

% Functor que elimina ceros a la izquierda de la parte entera
evalua0(PEntR,PEntR) :-
	first(PEntR,F),
	gt_or_equal(F,s(0)).

evalua0(PEntR,PEntF) :-
	first(PEntR,F),
	equal(F,0),
	behead(PEntR,PEntF).

% Functores ppales del programa
redondearDecimal(NI, redondeoUnidad, redondeo(redondeoUnidad,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntF,PDecF))) :-
	extComa(NI,PEntO,PDecO),
	redU(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,0,PEntR,PDecR),
	esCero(PDecR,PDecF),
	evalua0(PEntR,PEntF).

redondearDecimal(NI, redondeoDecima, redondeo(redondeoDecima,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntF,PDecF))) :-
	extComa(NI,PEntO,PDecO),
	redD(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,s(0),PEntR,PDecR),
	esCero(PDecR,PDecF),
	evalua0(PEntR,PEntF).

redondearDecimal(NI, redondeoCentesima, redondeo(redondeoCentesima,numeroOriginal(',',PEntO,PDecO),numeroRedondeado(',',PEntF,PDecF))) :-
	extComa(NI,PEntO,PDecO),
	redC(NI,PEntR0,PDecR0),
	formatNumber(PEntR0,PDecR0,s(s(0)),PEntR,PDecR),
	esCero(PDecR,PDecF),
	evalua0(PEntR,PEntF).

% Elegir tipo de redondeo en funcion del numero de digitos en la parte decimal
redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(0)),
	compU(PEnt,PDec,PEntR,PDecR).

redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(s(0))),
	borraUltimoElem(PDec,B),
	compU(PEnt,B,PEntR,PDecR).

redU(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(s(s(0)))),
	borraUltimoElem(PDec,B),
	borraUltimoElem(B,B0),
	compU(PEnt,B0,PEntR,PDecR).

redD(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(s(0))),
	compD(PEnt,PDec,PEntR,PDecR).

redD(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(s(s(0)))),
	borraUltimoElem(PDec,B),
	compD(PEnt,B,PEntR,PDecR).

redC(NI,PEntR,PDecR) :-
	extComa(NI,PEnt,PDec),
	count(PDec,C),
	equal(C,s(s(s(0)))),
	compC(PEnt,PDec,PEntR,PDecR).

% Functores que realizan el redondeo a la unidad
compU(PEnt,PDec,PEnt,[]) :-
	lastInList(PDec, L),
	ls_or_equal(L, s(s(s(s(0))))).

compU(PEnt,PDec,PEntR,[]) :-
	lastInList(PDec, L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	flipList(PEnt,R),
	first(R,F),
	add(F, s(0), S),
	flipList(R,R2),
	borraUltimoElem(R2,R3),
	concat(R3,[S],PEntR).

% Functores que realizan el redondeo a la decima
compD(PEnt,PDec,PEnt,PDecR) :-
	lastInList(PDec,L),
	ls_or_equal(L, s(s(s(s(0))))),
	borraUltimoElem(PDec,PDecR).

compD(PEnt,PDec,PEnt,PDecR) :-
	lastInList(PDec,L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	borraUltimoElem(PDec,B),
	lastInList(B,L0),
	add(L0,s(0),S),
	borraUltimoElem(B, B0),
	concat(B0,[S],PDecR).

% Functores que realizan el redondeo a la centesima
compC(PEnt,PDec,PEnt,PDecR) :-
	lastInList(PDec,L),
	ls_or_equal(L, s(s(s(s(0))))),
	borraUltimoElem(PDec,PDecR).


compC(PEnt,PDec,PEnt,PDecR) :-
	lastInList(PDec,L),
	gt_or_equal(L, s(s(s(s(s(0)))))),
	borraUltimoElem(PDec, B),
	lastInList(B,L0),
	add(L0,s(0),S),
	borraUltimoElem(B, B0),
	concat(B0,[S],PDecR).

%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%% EJERCICIO 2 %%%%%%%%%%%%%%%%%%%
%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%%

% Predicado que se hace verdadero cuando los elementos de las esquinas de la 
% matriz que se le pasa como parametro cumplen la propiedad del numero secreto

esCuadradoFantasticoSecreto(Matriz, N):-
	first(Matriz, F1),			%Se extrae la primera fila de la matriz
	first(F1, A),				%Se extrae el primer elemento de la primera fila		
	lastInList(F1, B),				%Se extrae el ultimo elemento de la primera fila
	lastInList(Matriz, F2),			%Se extrae la ultima fila de la matriz
	first(F2, C),				%Se extrae el primer elemento de la ultima fila
	lastInList(F2, D),				%Se extrae el ultimo elemento de la ultima fila
	checkSecret(A,B,C,D,N).		%Se comprueba que los elementos extraidos cumplen las condiciones



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
