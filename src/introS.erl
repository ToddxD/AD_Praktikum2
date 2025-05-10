%%%-------------------------------------------------------------------
%%% @author Hendrik
%%% @copyright (C) 2025, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 10. Mai 2025 10:00
%%%-------------------------------------------------------------------
-module(introS).
-author("Hendrik").

%% API
-export([introS/3]).

introS(PivotMethode, Liste, SwitchNum) -> radixS:radixS(Liste, 2).
