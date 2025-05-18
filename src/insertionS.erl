%%%-------------------------------------------------------------------
%%% @author Tim Meyerfeldt
%%% @doc Implementierung eines Insertionsorts anhand des Entwurfs.
%%%-------------------------------------------------------------------
-module(insertionS).
-author("Tim").

%% API
-export([insertionS/1]).


%Ein weiterer Akkumulator wird erstellt, um die im sortierten Teil bereits angeschauten Elemente zu speichern
insert (E, [H|T])-> insert([], E, [H|T]).
%Ist das Ende der sortierten Liste erreicht, wird diese umgedreht und zurückgegeben
insert(AL, E, []) -> listutils:reverse([E|AL]);
insert([], E, [H|T]) when (E >= H) -> [E|[H|T]];
insert([], E, [H|T]) -> insert([H|[]], E, T);
%Ist das Element an seiner richtigen Position, wird es eingefügt und die Liste zurückgegeben
insert(AL, E, [H|T]) when (E >= H) -> listutils:reverse(AL)++[E|[H|T]];
%Falls nicht, wird mit dem nächsten Element der Liste forgestzt
insert(AL, E, [H|T]) -> insert(([H|AL]), E, T).

%Filter für Introsort Aufruf
insertionS([])->[];
%InsertionSort Aufruf mit Akkumulator, in dem das Erste Element bereits enthalten ist (1)
insertionS([H|T]) -> listutils:reverse(insertionS(T, [H|[]])).
%Abbruchbedingung, Die sortierte Liste wird noch einmal umgedreht und zurückgegeben (7)
insertionS([], Akku) -> Akku;
%Prüfung ob das Element kleiner ist, als sein Vorgänger, wenn false, anhängen und Prozess forsetzen, bis Ende der Liste erreicht ist (5),(4)
insertionS([H|T], [H2|T2]) when (H >= H2)-> insertionS(T, [H|[H2|T2]]);
%In sortierte Liste einfügen (3), danach mit nächstem Element fortsetzen (4)
insertionS([H|T], [H2|T2]) ->insertionS(T,insert(H, [H2|T2])).


