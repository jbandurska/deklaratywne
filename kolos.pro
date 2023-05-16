member2(X, [X | T]) :- member(X, T).
member2(X, [_ | T]) :- member2(X, T).

member(X, [X | _]).
member(X, [_ | T]) :- member(X, T).

down(_, []).
down(N, [X | T]) :-
    X < N,
    X > 0,
    down(N, T).