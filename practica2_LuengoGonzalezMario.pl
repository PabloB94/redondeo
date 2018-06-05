:- use_package(trace).
:- use_module(library(lists)).

alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').

% EJERCICIO 1

tiposCierre(eslabon(X,Y),X,Y).
%cierresIguales(X,X).

%first([H|_],H). % El primer elemento de una lista es la cabeza de la lista

lastInList([X],X). % Functor que devuelve el ultimo elemento de una lista
lastInList([_|Z],X) :-
	lastInList(Z,X).

borraUltimoElem([X|Xs], Ys) :-  % Functor que borra el ultimo elem de una lista
	borraUltElemAux(Xs, Ys, X).

borraUltElemAux([], [], _).
borraUltElemAux([X1|Xs], [X0|Ys], X0) :-
	borraUltElemAux(Xs, Ys, X1).
  
behead([_|A],A). % Elimina la cabeza de una lista

%cierreAux([],A,A).
%cierre([X|Y],_) :-
%	cierre(Y,[X]).

%cierre([H|[]],R) :-
%	tiposCierre(H,C1,Cs1),
%	first(R,F),
%	tiposCierre(F,C2,Cs2),
%	last(R,L),
%	tiposCierre(L,C3,Cs3),
%	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
%	(C1=C3;C1=Cs3;Cs1=C3;Cs1=Cs3),
%	append(R,[H],A),
%	cierre([],A).

%cierre(X,R) :-
%	tiposCierre(X,C1,Cs1),
%	last(R,L),
%	tiposCierre(L,C2,Cs2),
%	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
%	append([X],R,A),
%	cierre(Y,A).

cierre([X|Y],R) :-
	cierreAux(Y,[X],R).

%cierreAux([H|[]],R) :-
%	tiposCierre(H,C1,Cs1),
%	first(R,F),
%	tiposCierre(F,C2,Cs2),
%	last(R,L),
%	tiposCierre(L,C3,Cs3),
%	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
%	(C1=C3;C1=Cs3;Cs1=C3;Cs1=Cs3),
%	append(R,[H],A),
%	cierre([],A).

cierreAux([],A,A).
cierreAux([X|Y],Rc,R) :-
	tiposCierre(X,C1,Cs1),
	last(Rc,L),
	tiposCierre(L,C2,Cs2),
	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
	append([X],Rc,A),
	cierreAux(Y,A,R).

cierre([X|Y],R) :-
	cierrePrueba(Y,[X],R).

cierrePrueba([X|Y],Rc,R):-
	tiposCierre(X,C1,Cs1),
	last(Rc,L),
	tiposCierre(L,C2,Cs2),
	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
%findAll(X,cierre(),F).