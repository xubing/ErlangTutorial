-module(math).
-export([odds_and_evens/1,quicksort/1]).

odds_and_evens(L)->
    odds_and_evens_acc(L,[],[]).
odds_and_evens_acc([H|T],Odds,Evens)->
    case (H rem 2) of
        1->odds_and_evens_acc(T,[H|Odds],Evens);
        0->odds_and_evens_acc(T,Odds,[H|Evens])
    end;
odds_and_evens_acc([],Odds,Evens)->
    {Odds,Evens}.

quicksort([])->[];
quicksort([H|T])->
    quicksort([X|| X <- T, X < H]) ++
    [H] ++
    quicksort([Y||Y <- T,Y >= H]).
