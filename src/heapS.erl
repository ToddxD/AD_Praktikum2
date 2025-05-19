%%%-------------------------------------------------------------------
%%% @author Tim Meyerfeldt
%%% @doc Implementierung eines Heapsorts anhand des Entwurfs.
%%%-------------------------------------------------------------------
-module(heapS).
-author("Tim").

%% API
-export([removeLast/2, heapS/3, heapS/1,calcPath/1, reverse/1, getLaenge/2, compare/2, getLastPos/1,  goDownPath/3, buildTree/1, buildTree/3, getFromPath/2, seepDown/1]).

%%-----------------------------------------------------------------
% Heapsort
heapS(Liste) -> heapS([], getLaenge(Liste, 0), buildTree(Liste)).
heapS(ResultListe, 1, {E,_PL,_PR})->[E|ResultListe];
heapS(ResultListe, P, {E,PL,PR})->
  Path = calcPath(P),
  heapS([E|ResultListe], (P-1), seepDown(removeLast(Path, {getFromPath(Path,{E,PL,PR}),PL,PR}))).

reverse(L)-> reverse(L, []).
reverse([], Akku) -> Akku;
reverse([H|T], Akku) -> reverse(T, [H| Akku]).

getLaenge([], L) -> L;
getLaenge([_H|T], L) -> getLaenge(T, (L+1)).

compare(E, [H|_T]) -> (E >= H).

getLastPos([])-> [];
getLastPos([H|_T])-> H == l.

getFromPath([],{N, _PL, _PR}) -> N;
getFromPath([H|T],{_N, PL, _PR})when H == l ->getFromPath(T, PL);
getFromPath([_H|T],{_N, _PL, PR})->getFromPath(T, PR).

seepDown({E, {}, {}}) -> {E, {}, {}};
seepDown({E, {EL, PELL, PELR}, {ER, {}, {}}}) when (EL < ER) ->
  case ER > E of
    true ->{ER, {EL, PELL, PELR}, {E, {}, {}}};
    false->{E, {EL, PELL, PELR}, {ER, {}, {}}}
  end;
seepDown({E, {EL, {}, {}}, {}}) ->
  case EL > E of
    true -> {EL, {E, {}, {}}, {}};
    false -> {E, {EL, {}, {}}, {}}
  end;
seepDown({E, {EL, PELL, PELR}, {ER, PERL, PERR}}) when (EL > ER)  ->
  case EL > E of
    true -> {EL, seepDown({E, PELL, PELR}),{ER, PERL, PERR}};
    false -> {E, {EL, PELL, PELR}, {ER, PERL, PERR}}
  end;
seepDown({E, PL, {ER, PERL, PERR}})->
  case ER > E of
    true ->{ER, PL, seepDown({E, PERL, PERR})};
    false->{E, PL, {ER, PERL, PERR}}
  end.

goDownPath([],{{},PL,PR},E) -> {E, PL, PR};
goDownPath([H|[]],{N,PL,PR},E) when E > N -> goDownPath([H|[]], {E, PL, PR}, N);
goDownPath([H|[]],{N,PL,_PR},E) ->
  case H == l of
    true -> {N, {E, {}, {}}, {}};
    false -> {N, PL, {E, {}, {}}}
  end;
goDownPath([H|T],{N,PL,PR},E) when E > N -> goDownPath([H|T], {E, PL, PR}, N);
goDownPath([H|T],{N,PL,PR},E) ->
  case H == l of
    true -> {N, goDownPath(T, PL, E), PR};
    false -> {N, PL, goDownPath(T, PR, E)}
  end.


buildTree([H|T])-> buildTree(T, 2, {H, {}, {}}).
buildTree([], _P, Tree)-> Tree;
buildTree([H|[]], P, TREE)-> goDownPath(calcPath(P), TREE, H);
buildTree([H|T], P, TREE)-> buildTree(T, (P+1), goDownPath(calcPath(P), TREE, H)).

removeLast([],{_N, _PL, _PR}) -> {};
removeLast([H|T],{N, PL, PR})when H == l ->{N, removeLast(T, PL), PR};
removeLast([_H|T],{N, PL, PR})->{N, PL, removeLast(T, PR)}.

% Kodierung des Feldes: Nachfolger von Position i ist 2*i links und 2*i+1 rechts
% berechnet den Pfad zur ersten leeren Position
% l steht fuer links, r fuer rechts
% Beispiel: sort:calcPath(1). --> []
% 		sort:calcPath(2). --> [l]
% 		sort:calcPath(3). --> [r]
% 		sort:calcPath(4). --> [l,l]
% 		sort:calcPath(5). --> [l,r]
% 		sort:calcPath(6). --> [r,l]
% 		sort:calcPath(7). --> [r,r]
calcPath(Number) -> calcPath(Number,[]).
% aktuelle Position ist Wurzel
calcPath(1,Accu) -> Accu;
% aktuelle Position ist gerade
calcPath(Number,Accu) when Number rem 2 =:= 0 -> calcPath(Number div 2,[l|Accu]);
% aktuelle Position ist ungerade
calcPath(Number,Accu) when Number rem 2 =/= 0 -> calcPath((Number-1) div 2,[r|Accu]).