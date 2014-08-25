%%% _匿名变量，进行占位
%%% 用++完成字符串的前缀匹配，—++左边参数必须是一个编译期字符常量
%%%

-module(stringTutorial).
-export([parseUser/0,parseurl/0,printstring/1,addstring/2]).

parseUser()->
    Users = [{person,[name,"Marry","Logan"],{shoe_size,12}}],
    [{_,Marry,_}] = Users,
    printstring(Marry).

%% ++ string
parseurl()->
    "http://" ++ Url = "http://chinabing.com",
    printstring(Url).

printstring(PrintStr)->
    io:format("~p~n",[PrintStr]).
        
addstring(Str1,Str2)->
    printstring(Str1++Str2).
