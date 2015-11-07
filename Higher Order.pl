%%Bonus Assignment %%

plus(X,Y,Z) :- Z is X + Y. %% Rule 1
minus(X,Y,Z):- Z is X - Y. %% Rule 2
times(X,Y,Z):- Z is X * Y. %% Rule 3
do(OP,X,Y,Z):- Exec =.. [OP,X,Y,Z], call(Exec). %% Rule 4
eval_ops(X,Y,Z) :- do(minus,X,Y,A), do(plus,X,A,B), do(times,X,B,Z).

addOne(X,Y) :- plus(X,1,Y).

mutate(_,[], []).
mutate(OP,[H|T],[H1|T1]) :- Exec =..[OP,H,H1], call(Exec), mutate(OP,T,T1).


isEven(X) :- 0 is mod(X,2). %Returns True if is X is even.
isOdd(X) :- 1 is mod(X,2).  %Returns False if X is odd.

mutateIf(_,_,[], []). %Base case when there remains only the empty list.
mutateIf(P,OP,[H|T],[H1|T1]) :- ExecP =..[P,H], call(ExecP) ->  Exec =..[OP,H,H1], call(Exec), mutateIf(P,OP,T,T1);H1 is H, mutateIf(P,OP,T,T1).
%sample run: mutate_if(isOdd,addOne,[1,2,3,4,5],L2) would return L2 = [2,2,4,4,6].