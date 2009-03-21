% I came up with this on my own, at least initially.

-module(reverse).
-export([reverse/1]).

reverse(OriginalList) ->
    reverse(OriginalList, []).


reverse([], ReversedList) ->
    ReversedList;
reverse([H|T], ReversedList) ->
    reverse(T, [H|ReversedList]).

