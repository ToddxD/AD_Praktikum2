%%%-------------------------------------------------------------------
%%% @author Hendrik Pilz
%%% @doc Testfälle
%%%-------------------------------------------------------------------
-module(tests).
-author("Hendrik").

%% API
-export([testInsertHeap/0,testAlle/0,testHeap/0,testRadix/0,testIntro/0,testInsert/0]).

testInsertHeap()->
    io:format("heap und insert vergleich"),
    zeitheapS:messung(10,100,100,10,rand),
    zeitinsertionS:messung(10,100,100,10,rand).

testAlle() ->
    Switch = 0,
    io:format("alle im vergleich"),
    zeitheapS:messung(100,100000,20,3,rand),
    zeitradixS:messung(100,100000,20,3,rand),
    zeitintroS:messung(100,100000,20,3,rand,left,Switch),
    zeitinsertionS:messung(100,5000,10,3,rand).


testHeap() ->
    io:format("heap"),
    zeitheapS:messung(100,100000,15,3,rand),
    zeitheapS:messung(100,100000,15,3,auf),
    zeitheapS:messung(100,100000,15,3,ab).

testRadix() ->
    io:format("radix"),
    zeitradixS:messung(100,100000,15,3,rand),
    zeitradixS:messung(100,100000,15,3,auf),
    zeitradixS:messung(100,100000,15,3,ab).

testIntro() ->
    Switch = 0,
    io:format("intro, random"),
    zeitintroS:messung(100,100000,21,3,rand,left,Switch),
    zeitintroS:messung(100,100000,21,3,rand,right,Switch),
    zeitintroS:messung(100,100000,21,3,rand,middle,Switch),
    zeitintroS:messung(100,100000,21,3,rand,median,Switch),
    zeitintroS:messung(100,100000,21,3,rand,random,Switch),
    io:format("intro, auf"),
    zeitintroS:messung(100,100000,21,3,auf,left,Switch),
    zeitintroS:messung(100,100000,21,3,auf,right,Switch),
    zeitintroS:messung(100,100000,21,3,auf,middle,Switch),
    zeitintroS:messung(100,100000,21,3,auf,median,Switch),
    zeitintroS:messung(100,100000,21,3,auf,random,Switch),
    io:format("intro, ab"),
    zeitintroS:messung(100,100000,21,3,ab,left,Switch),
    zeitintroS:messung(100,100000,21,3,ab,right,Switch),
    zeitintroS:messung(100,100000,21,3,ab,middle,Switch),
    zeitintroS:messung(100,100000,21,3,ab,median,Switch),
    zeitintroS:messung(100,100000,21,3,ab,random,Switch).

testInsert() ->
    io:format("insert"),
    zeitinsertionS:messung(100,1000,15,3,rand),
    zeitinsertionS:messung(100,1000,15,3,auf),
    zeitinsertionS:messung(100,1000,15,3,ab).

