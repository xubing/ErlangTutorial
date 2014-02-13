-module(test1).
-export([start/1]).

start(Name)->
    Pid = spawn(fun()->loop() end),
    register(Name,Pid).

 loop()->
    receive
        Any->
            Any
    end. 
%%start(Name)->register(Name,spawn(fun()->loop([] end))).
%%loop([])->[].

