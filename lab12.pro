size(nil, 0).
size(node(_, L, R), N) :-
    size(L, LeftTreeLength),
    size(R, RightTreeLength),
    N is LeftTreeLength + RightTreeLength + 1.

?- size(node(5, node(3, nil, nil), node(7, node(6, nil, nil), node(12, nil, nil))), N),
    format("Długość drzewa: ~w", [N]), nl.

search(node(X, _, _), X).
search(node(_, L, R), X) :-
    search(L, X);
    search(R, X).

?- search(node(5, node(3, nil, nil), node(7, node(6, nil, nil), node(12, nil, nil))), 6).

max(node(X, nil, nil), X).
max(node(Root, Left, nil), Max) :-
    max(Left, LeftMax),
    Max is max(Root, LeftMax).
max(node(Root, nil, Right), Max) :-
    max(Right, RightMax),
    Max is max(Root, RightMax).
max(node(Root, Left, Right), Max) :-
    max(Left, LeftMax),
    max(Right, RightMax),
    Max is max(Root, max(LeftMax, RightMax)).

?- max(node(5, node(3, node(15, nil, nil), nil), node(7, node(6, nil, nil), node(12, nil, nil))), M),
    format("Największy element w drzewie: ~w", [M]), nl.

times(_, nil, nil).
times(N, node(X, L, R), node(MultipliedX, MultipliedTreeLeft, MultipliedTreeRight)) :-
    MultipliedX is X * N,
    times(N, L, MultipliedTreeLeft),
    times(N, R, MultipliedTreeRight).

?- times(10, node(5, node(3, nil, nil), node(7, node(6, nil, nil), node(12, nil, nil))), T),
    format("Pomnożone przez 10 drzewo: ~w", [T]), nl.

preorder(nil, []).
preorder(node(X, L, R), [X | TreePreorder]) :-
    append(TreePreorderLeft, TreePreorderRight, TreePreorder),
    preorder(L, TreePreorderLeft),
    preorder(R, TreePreorderRight).

?- preorder(node(5, node(3, nil, nil), node(7, node(6, nil, nil), node(12, nil, nil))), P),
    format("Preorder drzewa: ~w", [P]), nl.

maximum(X,Y,X) :- X >= Y, !.
maximum(X,Y,Y) :- Y >= X.