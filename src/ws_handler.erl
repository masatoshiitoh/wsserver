-module(ws_handler).

-export([init/2]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).

%%-record(state, {count,stat}).

init(Req, Opts) ->
	State = [0],
	{cowboy_websocket, Req, State}.

websocket_init(_, Req, State) ->
	Req2 = cowboy_req:compact(Req),
	{ok, Req2, State}.

% get_listメッセージの場合はメッセージのリストを返します
websocket_handle({text, <<"now">>}, Req, State) ->

	[C] = State,
	{{Year,Mon,Day},{Hour,Min,Sec}} = erlang:localtime(),
	TimeStr = io_lib:format("~p/~p/~p ~p:~p:~p (stat= ~p)", [Year,Mon,Day,Hour,Min,Sec, C]),

	BinTimeStr = list_to_binary(TimeStr),

	{reply, {text, BinTimeStr}, Req, [C+1]};

websocket_handle({text, Data}, Req, State) ->

	[C] = State,
	T = io_lib:format("~p (count= ~p)", [ binary_to_list(Data), C]),
	B = list_to_binary(T),

	{reply, {text, B}, Req, [C+1]};

websocket_handle({binary, Data}, Req, State) ->

	[C] = State,
	T = io_lib:format("~p (count= ~p)", [ binary_to_list(Data), C]),
	B = list_to_binary(T),
	{reply, {binary, B}, Req, [C+1]};

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






