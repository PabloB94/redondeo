% Autores:
alumno_prode('Luengo','Gonzalez','Mario','W140280').
alumno_prode('Santos','Gonzalez','Sergio','W140180').
alumno_prode('Beltran','de Casso','Pablo','Y160454').

cierre(LinkList,Result):-
	noRepeatedElements(LinkList),
	findChain(LinkList,LinkList,Result).

noRepeatedElements([]).
noRepeatedElements([X|Xs]):-
	checkEqual(X,Xs),
    	noRepeatedElements(Xs).


checkEqual(_,[]).
checkEqual(X,[Y|Xs]):- 
	noRepeatedLinks(X,Y),
	checkEqual(X,Xs).


noRepeatedLinks(A,B):-
	arg(1,A,A1),
	arg(2,A,A2),
	arg(1,B,B1),
	arg(2,B,B2),
	((\+(A1==B1),\+(A2==B2));
	(\+(A1==B2),\+(A2==B1))).


findChain([X|_],LinkList,Result):-
	delete(LinkList,X,ShortList),
    	makeChain(X,ShortList,Chain),
    	agregarInicio(X,Chain,Result).  
    
findChain([_|Xs],LinkList,Result):- 
	findChain(Xs,LinkList,Result).


agregarInicio(X,Lista,[X|Lista]).


makeChain(X,ShortList,[NewLink|Result]):-
	arg(1,X,A),
	arg(2,X,B),
	updateList(ShortList,A,B,[NewLink|Result]).
	        
makeChain(X,ShortList,[NewLink|Result]):-
	arg(1,X,A),
	arg(2,X,B),
	updateList(ShortList,B,A,[NewLink|Result]).


linkMatch([NewLink|_],A,NewLink,NewEnd):-
	(arg(1,NewLink,B),
	A==B,
	arg(2,NewLink,NewEnd));
	(arg(2,NewLink,B),
	A==B,
	arg(1,NewLink,NewEnd)).
	
linkMatch([_|T],A,Y,NewEnd):-
	linkMatch(T,A,Y,NewEnd).


updateList(_,X,X,[]).

updateList(A,B,C,[X|D]):-
	linkMatch(A,B,X,Y),
	delete(A,X,Z),
	updateList(Z,Y,C,D).

cierreUnico(LinkList,Result):-
	setof(ChainSet,(cierre(LinkList,ChainSet)),Duplicates),
	deleteDuplicates(Duplicates,NoDuplicates),
	member(Result,NoDuplicates).


deleteDuplicates([],[]).

deleteDuplicates([X|Xs], NoDuplicates):-
	permutation(X,Y),
	findDuplicates(Y,Xs),
	deleteDuplicates(Xs,NoDuplicates),
	!.
	
deleteDuplicates([X|Xs], [X|NoDuplicates]):-
	permutation(X,Y),
	\+(findDuplicates(Y,Xs)),
	deleteDuplicates(Xs,NoDuplicates).


findDuplicates(Lista, [Resultado|_]):- 
	permutation(Resultado,Lista).
	
findDuplicates(Lista,[_|Resultado]):- 
	findDuplicates(Lista,Resultado).


cierreMinimo(LinkList,Length):-
	setof(ChainSet,(cierreUnico(LinkList,ChainSet)),ResultSet),
	minLength(ResultSet,Length).

minLength([H|T],Minimo):-
	length(H,A),
	minLength(T,A,Minimo).


minLength([],Min,Min).

minLength([H|T],MinSoFar,Minimum):-
	length(H,L),
	Min is min(L,MinSoFar),
	minLength(T,Min,Minimum).
















