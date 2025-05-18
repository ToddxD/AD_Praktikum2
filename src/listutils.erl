%%%-------------------------------------------------------------------
%%% @doc Hilfsfunktionen für Listen
%%%-------------------------------------------------------------------.
-module(listutils).
-author("Tim").


%% API
-export([reverse/1,len/1]).

reverse(L)-> reverse(L, []).
reverse([], Akku) -> Akku;
reverse([H|T], Akku) -> reverse(T, [H| Akku]).



%-author("Hendrik").
len(Liste) -> len(Liste, 0).
len([], I) -> I;
len([_H|T], I) -> len(T, I + 1).