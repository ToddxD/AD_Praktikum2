%%%-------------------------------------------------------------------
%%% @author Hendrik Pilz
%%% @doc Implementierung eines Introsorts anhand des Entwurfs.
%%%-------------------------------------------------------------------
-module(introS).
-author("Hendrik").

%% API
-export([introS/3]).

%% Pivot_methode: left, middle, right, median, random
introS(PivotMethode, Liste, SwitchNum) -> introS(PivotMethode, Liste, SwitchNum, 2 * math:log2(listutils:len(Liste))).

introS(_PivotMethode, [], _SwitchNum, _MaxDepth) -> [];
introS(PivotMethode, Liste, SwitchNum, MaxDepth) ->
    %              (1)
    case listutils:len(Liste) < SwitchNum of
        true -> [];%insertionS:insertionS(Liste); % (2) Da der Insertionsort nicht besser als der Heapsort ist, wird dieser nicht ausgeführt
        false -> case MaxDepth =< 0 of % Anders als im Entwurf muss hier auf =< geprüft werden, da die MaxDepth durch die Berechnung keine Ganzzahl ist.
                     true -> heapS:heapS(Liste); % (3)/(4) Heapsort
                     false -> Pivot = pivot(Liste, PivotMethode), % Quicksort
                         %                       (6)
                         {ListeL,ListeM,ListeR} = quickSplit(Pivot, Liste, [], [], []),
                         % (7)                                                             (8)
                         introS(PivotMethode, ListeL, SwitchNum, MaxDepth - 1) ++ ListeM ++ introS(PivotMethode, ListeR, SwitchNum, MaxDepth - 1) % (9)
                 end
    end.

%% In Linke und Rechte Liste aufteilen
quickSplit(Pivot, [H|T], ListeL, ListeM, ListeR) when H < Pivot ->
    quickSplit(Pivot, T, [H|ListeL], ListeM, ListeR); % links einfügen
quickSplit(Pivot, [H|T], ListeL, ListeM, ListeR) when H == Pivot ->
    quickSplit(Pivot, T, ListeL,[H|ListeM], ListeR); % in der Mitte einfügen
quickSplit(Pivot, [H|T], ListeL, ListeM, ListeR) ->
    quickSplit(Pivot, T, ListeL, ListeM, [H|ListeR]); % rechts einfügen
quickSplit(_Pivot, [], ListeL, ListeM, ListeR) -> {ListeL,ListeM,ListeR}. % Listen zurückgegeben

%% (5) Ermittlung des Pivot Elementes nach gegebener Methode
pivot([H|_T], left) -> H;

pivot([H|[]], right) -> H;
pivot([_H|T], right) -> pivot(T, right);

pivot(Liste, median) ->
    (pivot(Liste, left) + pivot(Liste, middle) + pivot(Liste, right)) / 3;

pivot(Liste, random) -> pivot(Liste, random, rand:uniform(listutils:len(Liste)) - 1);

pivot(Liste, middle) -> pivot(Liste, middle, (listutils:len(Liste) / 2)).

pivot([H|_T], _Pivot_Methode, I) when I =< 0 -> H;
pivot([_H|T], Pivot_Methode, I) -> pivot(T, Pivot_Methode, I - 1).
