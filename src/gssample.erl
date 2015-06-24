-module(gssample).
-behaviour(gen_server).

-export([add/2, sub/2]).

-export([start_link/1]).
-export([terminate/2]).
-export([init/1]).
-export([handle_call/3]).


add(A,B) ->
	Reply = gen_server:call(?MODULE, {add, A, B}),
	{ok, V} = Reply,
	V.

sub(A,B) ->
	Reply = gen_server:call(?MODULE, {sub, A, B}),
	{ok, V} = Reply,
	V.


start_link(_Opts) ->
	Args = [],
	gen_server:start_link({local, ?MODULE}, ?MODULE, Args, []).

init(_Args) ->
	NewState = [],
	{ok, NewState}.

terminate(_Reason, State) ->
	ok.

handle_call({add, A, B}, From, State) ->
	{reply, {ok, A+B}, State};

handle_call({sub, A, B}, From, State) ->
	{reply, {ok, A-B}, State}.


