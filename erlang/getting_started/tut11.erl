-module(tut11).
-export([month_length/2]).

mods_to_zero(Num, Divisor) ->
  if
    trunc(Num / Divisor) * Divisor == Num ->
      true;
    true ->
      false
  end.


month_length(Year, Month) ->
    %% All years divisible by 400 are leap
    %% Years divisible by 100 are not leap (except the 400 rule above)
    %% Years divisible by 4 are leap (except the 100 rule above)
    Leap = if
        mods_to_zero(Year, 400) == true ->
            leap;
        mods_to_zero(Year, 100) == true ->
            not_leap;
        mods_to_zero(Year, 4) == true ->
            leap;
        true ->
            not_leap
    end,  
    case Month of
        sep -> 30;
        apr -> 30;
        jun -> 30;
        nov -> 30;
        feb when Leap == leap -> 29;
        feb -> 28;
        jan -> 31;
        mar -> 31;
        may -> 31;
        jul -> 31;
        aug -> 31;
        oct -> 31;
        dec -> 31
    end.