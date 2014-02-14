%%% a name server demo.

-module(kvs).
-export([start/0,store/2,lookup/1]).

start()->
    Pid = spawn(fun()->loop() end),
    register(kvs,Pid).

store(Key,Value)->rpc({store,Key,Value}).

lookup(Key)->rpc({lookup,Key}).

rpc(Q)->
    kvs!{self(),Q},
    receive
        {kvs,Reply}->
            Reply
    end.

 loop()->
    receive
        {From,{store,Key,Value}}->
            put(Key,{ok,Value}),
            From ! {kvs,true},
            loop();
        {From,{lookup,Key}}->
            From ! {kvs,get(Key)},
            loop()
    end.

