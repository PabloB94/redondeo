:- use_package(trace).

alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').

eslabon(_,_).

tiposCierre(eslabon(X,Y),X,Y).
cierresIguales(X,X).

first([H|_],H).         								% El primer elemento de una lista es la cabeza de la lista

lastInList([X],X).           					 % Functor que devuelve el ultimo elemento de una lista
lastInList([_|Z],X) :-
	lastInList(Z,X).

borraUltimoElem([X|Xs], Ys) :-         % Functor que borra el ultimo elem de una lista
	borraUltElemAux(Xs, Ys, X).

borraUltElemAux([], [], _).
borraUltElemAux([X1|Xs], [X0|Ys], X0) :-
	borraUltElemAux(Xs, Ys, X1).

concat([],X,X).            						 % Concatenacion de listas
concat([X|Y], Z, [X|W]) :-
	concat(Y, Z, W).

flipList([],[]).            						 % Invierte una lista
flipList([X|Xs],Ys) :-
	flipList(Xs,Zs),
	concat(Zs,[X],Ys).
  
behead([_|A],A). 												% Elimina la cabeza de una lista

cierre(X,Y) :-