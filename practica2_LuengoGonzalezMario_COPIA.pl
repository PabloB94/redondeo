:- use_package(trace).
:- use_module(library(lists)).

alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').

% EJERCICIO 1

tiposCierre(eslabon(X,Y),X,Y).

first([H|_],H). % El primer elemento de una lista es la cabeza de la lista

% Usar findall al final de cierre
%extCierre([],_).
%extCierre(E,C) :-
%	extCierreAux(E,_,C).

%extCierreAux([],A,A).
%extCierreAux([H|T],Aux,C) :-
%	tiposCierre(H,C1,Cs1),
%	append([C1],[Cs1],A),
%	append(Aux,A,A2),
%	extCierreAux(T,A2,C).

%cierreAux([],A,A).
%cierreAux(X,Rc,R) :-
%	extCierre(X,C),
%	(C1=C2;C1=Cs2;Cs1=C2;Cs1=Cs2),
%	append([X],Rc,A),
%	cierreAux(Y,A,R).

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

cierreAux([_|Y],Rc,R) :-
	first(Y,F),
	cierreAux(F,Rc,R).

cierreAux([X|Y],Rc,R) :-
	arg(1,X,C1),
	arg(2,X,Cs1),
	first(Y,F),
	
	
% Hacer caso contrario con C1!=C2, etc y hacer una copia de la lista para continuar pero con el sigueinte eslabon


