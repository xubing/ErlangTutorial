-module(socket_examples).
-export([start_nano_server/0,nano_client_eval/1,start_parallel_server/0]).

start_parallel_server()->
    {ok,Listen}=gen_tcp:listen(2345,[binary,{packet,4},
                                     {reuseaddr,true},
                                     {active,true}]),
    spawn(fun()-> par_connect(Listen) end).

%%parallel server
par_connect(Listen)->
    {ok,Socket}=gen_tcp:accept(Listen),
    spawn(fun()->par_connect(Listen) end),
    loop(Socket).

start_nano_server()->
    {ok,Listen}=gen_tcp:listen(2345,[binary,{packet,4},
                                     {reuseaddr,true},
                                     {active,true}]),
    {ok, Socket}=gen_tcp:accept(Listen),
    gen_tcp:close(Listen),
    loop(Socket).

loop(Socket)->
    receive
        {tcp,Socket,Bin}->
            io:format("socket recived binary=~p~n",[Bin]),
            Str = binary_to_term(Bin),
            io:format("Server unpacked ~p~n",[Str]),
            Reply = Str,%lib_misc:string2value(Str),
            io:format("Server Replying=~p~n",[Reply]),
            gen_tcp:send(Socket,term_to_binary(Reply)),
            loop(Reply);
        {tcp_closed,Socket}->
            io:format("Server Socket closed")
    end.

nano_client_eval(Str)->
    {ok,Socket} =
                  gen_tcp:connect("localhost",2345,
                                  [binary,{packet,4}]),
    ok = gen_tcp:send(Socket,term_to_binary(Str)),
    receive
        {tcp,Socket,Bin}->
            io:format("Client received binary = ~p~n",[Bin]),
            Val = binary_to_term(Bin),
            io:format("Client result =~p~n",[Val]),
            gen_tcp:close(Socket)
     end.

