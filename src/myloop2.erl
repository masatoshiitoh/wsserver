-module(myloop2).

-export([start_loop/0]).
-export([do_add/3]).
-export([do_sub/3]).

do_add(Pid, X, Y) ->
	Pid ! {self(), add, X, Y},
	receive
		Result -> Result
	end.

do_sub(Pid, X, Y) ->
	Pid ! {self(), sub, X, Y},
	receive
		Result -> Result
	end.

start_loop()->
	spawn(fun() -> loop() end).

loop() ->
	receive
		{CPid, add, X, Y} -> CPid ! X+Y;
		{CPid, sub, X, Y} -> CPid ! X-Y
	end,
	loop().

