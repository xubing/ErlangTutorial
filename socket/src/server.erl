%%%-------------------------------------------------------------------
%%% @author zhangxubing
%%% @copyright (C) 2014, <COMPANY>
%%% @doc
%%%
%%% @end
%%% Created : 12. 四月 2014 下午6:17
%%%-------------------------------------------------------------------
-module(server).
-author("zhangxubing").

%% API
-export([start/0]).




-define( UINT, 32/unsigned-little-integer).
-define( INT, 32/signed-little-integer).
-define( USHORT, 16/unsigned-little-integer).
-define( SHORT, 16/signed-little-integer).
-define( UBYTE, 8/unsigned-little-integer).
-define( BYTE, 8/signed-little-integer).

-define( PORT, 5677).


start() ->
  {ok, LSock} = gen_tcp:listen(?PORT, [binary, {packet, 0},{active, false}]),
  io:format("socket listen: ~p on ~p ~n",[LSock, ?PORT]),
  accept(LSock).

accept(LSock) ->
  {ok, ASock} = gen_tcp:accept(LSock),
  spawn(fun() -> server_loop(ASock) end),
  accept(LSock).

server_loop(ASock) ->
  case gen_tcp:recv(ASock, 0) of
    {ok, <<Len:?INT,Content:Len,_Rest/binary>> = A} ->
      %% _Rest 匹配C++字符串后面的结束符/0
      io:format("recv data: ~p ~p ~n", [Len, Content]),
      gen_tcp:send(ASock, A),
      server_loop(ASock);
    {ok, Data} ->
      io:format("recv unformated data: ~p~n", [Data]),
      server_loop(ASock);
    {error, _} ->
      {ok, recv_error}
  end.


%%   case gen_tcp:recv(ASock, 0) of
%%     {ok, <<Len:?USHORT,Cmd:?USHORT,Contain:4/binary-unit:8,_Rest/binary>> = A} ->
%%       %% _Rest 匹配C++字符串后面的结束符/0
%%       io:format("recv data: ~p ~p ~p~n", [Len, Cmd, Contain]),
%%       gen_tcp:send(ASock, A),
%%       server_loop(ASock);
%%     {ok, Data} ->
%%       io:format("recv unformated data: ~p~n", [Data]),
%%       server_loop(ASock);
%%     {error, _} ->
%%       {ok, recv_error}
%%   end.
