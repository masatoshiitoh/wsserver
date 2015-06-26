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
	%%
	%% gssample 
	%%
	GssampleSpec = {gssample, {gssample, start_link, [[]]}, permanent, brutal_kill, worker, [gssample]},
	{ok, { {one_for_one, 5, 10}, [GssampleSpec] }}.

%% init([]) ->
	%%
	%% このアプリケーション自身のスーパバイザツリーは空（[]）です
	%%
%%	{ok, { {one_for_one, 5, 10}, [] }}.
