last(X, [X]).
last(X, [_ | T]) :- last(X, T).

delete(_, [], []).
delete(X, [X|Tail], Result) :-
    delete(X, Tail, Result).
delete(X, [Head|Tail], [Head|Result]) :-
    dif(X, Head),
    delete(X, Tail, Result).

delete(L1, L2) :-
    append(L2, [_, _, _], L1).

reverse([], []).
reverse([H1 | T1], LR) :-
    reverse(T1, L2),
    append(L2, [H1], LR).

evenlength([]).
evenlength([_ | T]) :- oddlength(T).
oddlength([_]).
oddlength([_ | T]) :- evenlength(T).

shift([], []).
shift([H | T], L2) :-
    append(T, [H], L2).

quadrat([], []).
quadrat([X | T], Acc) :-
    Xx is X * X,
    quadrat(T, L),
    append([Xx], L, Acc).

combine([], [], []).
combine([H1 | T1], [H2 | T2], Acc) :-
    combine(T1, T2, L),
    append([[H1, H2]], L, Acc).

palindrome(L) :- reverse(L, L).

p(X, [Y, X, Z | _], Y, Z).
p(X, [_ | T], Y, Z) :- p(X, T, Y, Z).

q(X, L1, L2) :-
    append(_, [X, X], L2),
    append(L2, _, L1).

my_append([X|L1], L2, [X|L3]) :- my_append(L1, L2, L3).
my_append([], L, L).
?- my_append(X, [3,4], [2,3,4]), print(X).

nth(N, [X | _], X) :- N = 0.
nth(N, [_ | T], X) :-
    Nm1 is N - 1,
    nth(Nm1, T, X).

ordered([]).
ordered([_]).
ordered([X, Y | T]) :-
    X < Y,
    ordered([Y | T]).

permutation([], []).
permutation(L1, [X|L2]) :-
    select(X, L1, Rest),
    permutation(Rest, L2).
