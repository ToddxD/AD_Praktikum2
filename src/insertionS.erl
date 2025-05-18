%%%-------------------------------------------------------------------
%%% @author Tim Meyerfeldt
%%% @doc Implementierung eines Insertionsorts anhand des Entwurfs.
%%%-------------------------------------------------------------------
-module(insertionS).
-author("Tim").

%% API
-export([insertionS/1]).

insert (E, [H|T])-> insert([], E, [H|T]).
insert(AL, E, []) -> ([E|AL]);
insert([], E, [H|T]) when (E >= H) -> [E|[H|T]];
insert([], E, [H|T]) -> insert([H|[]], E, T);
insert(AL, E, [H|T]) when (E >= H) -> listutils:reverse(AL)++[E|[H|T]];
insert(AL, E, [H|T]) -> insert(([H|AL]), E, T).


insertionS([H|T]) -> listutils:reverse(insertionS(T, [H|[]])).
insertionS([], Akku) -> Akku;
insertionS([H|T], [H2|T2]) when (H >= H2)-> insertionS(T, [H|[H2|T2]]);
insertionS([H|T], [H2|T2]) ->insertionS(T,insert(H, [H2|T2])).


