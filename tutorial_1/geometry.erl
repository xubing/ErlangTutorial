-module(geometry).
-export([area/1]).

%%%tip:
%%%1  变量需要大写开头。 capitical Header.
%%%  分割用;
%%%  调用 erl test ， 
%%%  c(geometry). 
%%%  geometry:area({rectangle,10,5}).
area({rectangle,Width,Height})->Width*Height;
area({circle,R})->3.14159*R*R.
