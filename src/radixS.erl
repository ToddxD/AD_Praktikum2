%%%-------------------------------------------------------------------
%%% @author Hendrik Pilz
%%% @doc Implementierung eines Radixsorts anhand des Entwurfs.
%%%-------------------------------------------------------------------
-module(radixS).
-author("Hendrik").

%% API
-export([radixS/2]).

radixS(Liste, MaxStellen) ->
    %                    (1)
    radixS(Liste, MaxStellen, 1, []). % initial mit leeren Buckets

%                                                  (2)
radixS(Liste, MaxStellen, Stelle, _Buckets) when Stelle > MaxStellen -> % wenn alle Stellen behandelt -> fertig
    Liste;

radixS([], MaxStellen, Stelle, Buckets)->
    %                   (5)
    Con = listutils:reverse(concatBuckets(Buckets)), % Da die Elemente beim befüllen der Buckets, vorne angehängt werden und die Buckets in absteigender Reihenfolge vorliegen (also alles einmal vertauscht wird), muss die Reihenfolge einmal reversed werden.

    %                       (6)
    radixS(Con, MaxStellen, Stelle+1, []); % Nächste Runde Radix mit der nächsten Stelle

% (3)
radixS([H|T], MaxStellen, Stelle, Buckets) ->

    % (4)
    Digit = trunc(H / math:pow(10,Stelle-1)) rem 10, % Berechnung der Ziffer an der Stelle Index
    BucketsNeu = fillBucket(H, Digit, Buckets), % Element H in Bucket einsortieren

    radixS(T, MaxStellen, Stelle, BucketsNeu).


%% Datenstruktur Buckets
concatBuckets([]) -> [];
concatBuckets([B|[]]) -> B;
concatBuckets([B|Buckets]) -> % Fügt die Bucketinhalte aneinander
    B ++ concatBuckets(Buckets).


fillBucket(El, Digit, Buckets) ->
    fillBucket(El, Digit, 9, Buckets). % Befüllen der Buckets, Start mit Bucket Nr.9


fillBucket(El, Digit, Index, []) ->
    fillBucket(El, Digit, Index, [[]]); % Falls noch keine Buckets vorhanden, mit leeren initialisieren

fillBucket(El, Digit, Index, [B|Buckets]) when Index == Digit ->
    [[El|B]|Buckets]; % Element in Bucket einfügen
fillBucket(El, Digit, Index, [B|Buckets]) ->
    [B|fillBucket(El, Digit, Index-1, Buckets)]. % Durch Buckets iterieren

