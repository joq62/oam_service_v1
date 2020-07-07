%%% -------------------------------------------------------------------
%%% @author  : Joq Erlang
%%% @doc Centralized log service   
%%%
%%% -------------------------------------------------------------------
-module(oam). 
  


%% --------------------------------------------------------------------
%% Include files
%% --------------------------------------------------------------------


%% --------------------------------------------------------------------

%% External exports


-export([log_get/1
	]).


%% ====================================================================
%% External functions
%% ====================================================================
log_get(Type)->
    LogServices=dns_service:get("log_service"),
    LogInfo=[{Node,rpc:call(Node,log_service,get,[Type])}||{"log_service",Node}<-LogServices],
    R=[{calendar:datetime_to_gregorian_seconds({{Y,M,D},{H,Min,S}}),{Type1,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}}||{Type1,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}<-LogInfo],
    qsort(R).
    

qsort([])->[];
qsort([{Pivot,Info}|T])->
    qsort([{Type,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}||{DateSeconds,{Type,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}}<-T,
								     DateSeconds<Pivot]) ++ [Info] ++
    qsort([{Type,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}||{DateSeconds,{Type,[Node,Module,File,Line,{Y,M,D},{H,Min,S},Msg]}}<-T,
									 DateSeconds>=Pivot]).
    
