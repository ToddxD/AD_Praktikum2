%%%-------------------------------------------------------------------
%%% @author Hendrik
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Mai 2025 10:01
%%%-------------------------------------------------------------------
-module(heapS).
-author("Hendrik").

%% API
-export([heapS/1]).

%%-----------------------------------------------------------------
% Heapsort
heapS([]) -> [];
heapS(Liste) -> heapS([], getLaenge(Liste, 0), buildTree(Liste)).
heapS(ResultListe, 1, {EL, _PL, _PR})->[EL|ResultListe];
heapS(ResultListe, P, {EL, PL, PR}) ->
  %{Tree, NEWROOT} = {4, 6},
  heapS([EL|ResultListe], (P-1), seepDown(removeLast(calcPath(P), {EL, PL, PR}))).

getLaenge([], L) -> L;
getLaenge([_H|T], L) -> getLaenge(T, (L+1)).

%%getValue({N, _PL, _PR}) -> N.

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

%Hilfsfunktion zum Erstellen, des Baumes, durchlaufen des Baumes, entsprechend des Errechneten Pfades und Anhängen eines Knotens
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

buildTree([H|T])-> buildTree(T, 2, goDownPath(calcPath(1), {{}, {}, {}}, H)).
buildTree([H|[]], P, TREE)-> goDownPath(calcPath(P), TREE, H);
buildTree([H|T], P, TREE)-> buildTree(T, (P+1), goDownPath(calcPath(P), TREE, H)).

%Hilsfunktion zum Tauschen des Wertes des Ersten Knotens
swap({_E, PL, PR}, N) -> {N, PL, PR}.

removeLast([],{_N, _PL, _PR}) -> {};
removeLast([H|T],{N, {M, _PELL, _PELR}, PR})when H == l ->{M, removeLast(T, {N, _PELL, _PELR}), PR};
removeLast([_H|T],{N, PL, {M, _PERL, _PERR}})->{M, PL, removeLast(T, {N, _PERL, _PERR})}.

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
