-module(math).
-export([odds_and_evens/1,
         quickSort/1,
         testcase/1,
         testif/1,
         testtry/2,
         testParseBinary/1]).
%% acc
odds_and_evens(L)->
    odds_and_evens_acc(L,[],[]).
odds_and_evens_acc([H|T],Odds,Evens)->
    case (H rem 2) of
        1->odds_and_evens_acc(T,[H|Odds],Evens);
        0->odds_and_evens_acc(T,Odds,[H|Evens])
    end;
odds_and_evens_acc([],Odds,Evens)->
    {Odds,Evens}.

%%quick sort
quickSort([])->[];
quickSort([H|T])->
    quickSort([X||X<-T,X < H])++[H]++quickSort([Y||Y<-T,Y>H]).

%% test case/if
testcase(N)->
        case (N rem 3) of
            1->"1111";
            2->"2222";
            0->"0000"
        end.

%% test if
testif(N)->
    if N>2 -> "more than 2";
        N=:=2->2;
        N=< 2->"less than 2"
    end.

%%try catch
testtry(N,M)->
        try (N rem M) of
            Val->{N,normal,Val}
        catch
            throw:X->{N,caught,thrown,X};
            error:X->{N,caught,error,X};
            exit:X->{N,caught,exit,X}
        end.

%% test binary. 长度需要完全匹配，否则会出现解析的错误
testParseBinary(Bin)->
    Alen = 7,
    Blen = 1,
    LeftLen = size(Bin)*8-Alen-Blen,
    <<A:Alen,B:Blen,_:LeftLen>> = Bin,
    {A,B,"中国.Beijing"}.

