-module(server).
-export([server/0]).

server() ->
    {ok, LSock} = gen_tcp:listen(7000, [binary, {packet, 0}, 
                                        {active, false}]),
    {ok, Sock} = gen_tcp:accept(LSock),
    {ok, Bin} = do_recv(Sock, []),
    ok = gen_tcp:close(Sock),
    Bin.

do_recv(Sock, Bs) ->
    case gen_tcp:recv(Sock, 0) of
        {ok, B} ->
            %%_N=list_to_binary(Bs),
            %%io:format("~p",[_N]),
            do_recv(Sock, [Bs, B]);
        {error, closed} ->
            {ok,list_to_binary(Bs)}
    end.

