-module(ws_handler).

-export([init/2]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

init(Req, Opts) ->
	erlang:start_timer(1000, self(), <<"Hello!">>),
	{cowboy_websocket, Req, Opts}.

websocket_init(_, Req, _Opts) ->
	Req2 = cowboy_req:compact(Req),
	{ok, Req2, []}.

% get_listメッセージの場合はメッセージのリストを返します
websocket_handle({text, <<"now">>}, Req, State) ->
	{{Year,Mon,Day},{Hour,Min,Sec}} = erlang:localtime(),
	TimeStr = io_lib:format("~p/~p/~p ~p:~p:~p", [Year,Mon,Day,Hour,Min,Sec]),
	BinTimeStr = list_to_binary(TimeStr),
	{reply, {text, BinTimeStr}, Req, State};

websocket_handle({text, Data}, Req, State) ->
	{reply, {text, Data}, Req, State};

websocket_handle({binary, Data}, Req, State) ->
	{reply, {binary, Data}, Req, State};

websocket_handle(_Frame, Req, State) ->
	{ok, Req, State}.

websocket_info(<<"Hello!">>, Req, State) ->
	io:format("info: hello received~p~n",[State]),
	erlang:start_timer(5000, self(), <<"Hello!">>),
	{reply, {text, <<"me too!">>}, Req, State};

websocket_info(_Info, Req, State) ->
	{ok, Req, State}.

websocket_terminate(_Reason, _Req, _State) ->
	ok.






