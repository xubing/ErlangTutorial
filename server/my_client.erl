    % my_client %  
    -module(my_client).  
    -export([start/0]).  
      
    start() -> spawn(fun() -> loop() end).  
      
    loop() ->  
        receive  
            Msg -> io:format("client - ~p~n",[Msg])  
        end.  
