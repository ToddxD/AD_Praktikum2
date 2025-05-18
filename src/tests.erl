%%%-------------------------------------------------------------------
%%% @author Hendrik Pilz
%%% @doc Testfälle
%%%-------------------------------------------------------------------
-module(tests).
-author("Hendrik").

%% API
-export([testInsertHeap/0, testAll/0]).

testInsertHeap()->
    io:format("heap und insert vergleich"),
    zeitheapS:messung(100,1000,10,10,rand),
    zeitinsertionS:messung(100,1000,10,10,rand).

testAll() ->
    Switch = 100,
    io:format("alle im vergleich"),
    zeitheapS:messung(100,10000,20,3,rand),
    zeitradixS:messung(100,10000,20,3,rand),
    zeitinsertionS:messung(100,10000,6,3,rand),
    zeitintroS:messung(100,10000,20,3,rand,left,Switch),

    io:format("insert"),
    zeitinsertionS:messung(100,10000,20,3,rand),
    zeitinsertionS:messung(100,10000,20,3,auf),
    zeitinsertionS:messung(100,10000,20,3,ab),

    io:format("heap"),
    zeitheapS:messung(100,100000,20,3,rand),
    zeitheapS:messung(100,100000,20,3,auf),
    zeitheapS:messung(100,100000,20,3,ab),

    io:format("radix"),
    zeitradixS:messung(100,100000,20,3,rand),
    zeitradixS:messung(100,100000,20,3,auf),
    zeitradixS:messung(100,100000,20,3,ab),

    io:format("intro, random"),
    zeitintroS:messung(100,100000,20,3,rand,left,Switch),
    zeitintroS:messung(100,100000,20,3,rand,right,Switch),
    zeitintroS:messung(100,100000,20,3,rand,middle,Switch),
    zeitintroS:messung(100,100000,20,3,rand,median,Switch),
    zeitintroS:messung(100,100000,20,3,rand,random,Switch),
    io:format("intro, auf"),
    zeitintroS:messung(100,100000,20,3,auf,left,Switch),
    zeitintroS:messung(100,100000,20,3,auf,right,Switch),
    zeitintroS:messung(100,100000,20,3,auf,middle,Switch),
    zeitintroS:messung(100,100000,20,3,auf,median,Switch),
    zeitintroS:messung(100,100000,20,3,auf,random,Switch),
    io:format("intro, ab"),
    zeitintroS:messung(100,100000,20,3,ab,left,Switch),
    zeitintroS:messung(100,100000,20,3,ab,right,Switch),
    zeitintroS:messung(100,100000,20,3,ab,middle,Switch),
    zeitintroS:messung(100,100000,20,3,ab,median,Switch),
    zeitintroS:messung(100,100000,20,3,ab,random,Switch).

