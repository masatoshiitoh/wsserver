-module(myloop).

-export([start_loop/0]).

start_loop()->
	spawn(fun() -> loop() end).

loop() ->
	receive
		{add, X, Y} -> io:format("~p + ~p = ~p ~n", [X, Y, X+Y]);
		{sub, X, Y} -> io:format("~p - ~p = ~p ~n", [X, Y, X-Y])
	end,
	loop().

