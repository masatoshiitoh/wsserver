-module(wsserver_sup).

-behaviour(supervisor).

%% API
-export([start_link/0]).

%% Supervisor callbacks
-export([init/1]).

%% Helper macro for declaring children of supervisor
-define(CHILD(I, Type), {I, {I, start_link, []}, permanent, 5000, Type, [I]}).

%% ===================================================================
%% API functions
%% ===================================================================

start_link() ->
    supervisor:start_link({local, ?MODULE}, ?MODULE, []).

%% ===================================================================
%% Supervisor callbacks
%% ===================================================================

init([]) ->
    %% ChildSpec = [ws_server()],
    ChildSpec = [],
    {ok, { {one_for_one, 5, 10}, ChildSpec }}.

ws_server() ->
    ID = wsserver,
    StartFunc = {ID, start_link, []},
    Restart = permanent,
    Shutdown = brutal_kill,
    Type = worker,
    Modules = [ID],
    _ChildSpec = {ID, StartFunc, Restart, Shutdown, Type, Modules}.

