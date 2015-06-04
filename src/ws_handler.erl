-module(ws_handler).
-export([init/3]).
-export([websocket_init/3]).
-export([websocket_handle/3]).
-export([websocket_info/3]).
-export([websocket_terminate/3]).
-record(state, { }).

init(_, _, _) ->
{upgrade, protocol, cowboy_websocket}.

websocket_init(_, Req, _Opts) ->
Req2 = cowboy_req:compact(Req), {ok, Req2, #state{}}.

% get_listメッセージの場合はメッセージのリストを返します
websocket_handle({text, <<"get_list">>}, Req, State) ->
% 最新のメッセージを取得する
% RawMessages = get_recent_messages(10),
% メッセージをJiffyが変換できる形式に変更
%Messages = format_messages(RawMessages),
% JiffyでJsonレスポンスを生成
%JsonResponse = jiffy:encode(#{ <<"type">> => <<"message_list">>, <<"messages">> => Messages }),
% JSONを返す
{reply, {text, <<"goba">>}, Req, State};


websocket_handle({text, Data}, Req, State) ->
{reply, {text, Data}, Req, State};
websocket_handle({binary, Data}, Req, State) ->
{reply, {binary, Data}, Req, State};
websocket_handle(_Frame, Req, State) ->
{ok, Req, State}.
websocket_info(_Info, Req, State) ->
{ok, Req, State}.
websocket_terminate(_Reason, _Req, _State) ->
ok.






