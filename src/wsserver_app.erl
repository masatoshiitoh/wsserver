-module(wsserver_app).

-behaviour(application).

%% Application callbacks
-export([start/2, stop/1]).

%% ===================================================================
%% Application callbacks
%% ===================================================================

start(_StartType, _StartArgs) ->


%% Cowboy初期化

% ルート宣言
Dispatch = cowboy_router:compile([ {'_', [
% cowboy_staticはパスマッチに対して、静的ファイルを読み込む
% index.htmlを読み込む
%{"/", cowboy_static, {priv_file, message_wall, "index.html"}},
% /websocketのリクエストをws_handlerに渡す
{"/websocket", ws_handler, []} ]} ]),
% Cowboyを起動
{ok, _} = cowboy:start_http(http, 100, [{port, 8001}], [ {env, [{dispatch, Dispatch}]} ]),





    wsserver_sup:start_link().

stop(_State) ->
    ok.
