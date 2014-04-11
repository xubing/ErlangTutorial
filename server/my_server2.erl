    % my_server2.erl %  
    -module(my_server2).  
    -export([start/0]).  
      
    start() -> spawn(fun() -> loop() end).  
      
    loop() ->   
        receive  
            {callback,From,Request} ->   
                io:format("server 2,~p~n",[Request]),  
                From ! Request,  
                loop()  
        end.  
