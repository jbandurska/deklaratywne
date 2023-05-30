animate(fred).
animate(alice).
male(fred).
canine(alice).
feline(fred).

checkprops(_, []).
checkprops(Person, [Prop | Tail]) :-
    call(Prop, Person),
    checkprops(Person, Tail).

?- checkprops(fred, [animate, male]).
?- checkprops(alice, [animate, feline]).


filter(_, [], []).
filter(Pred, [H | T], [H | L]) :-
    call(Pred, H),
    filter(Pred, T, L).
filter(Pred, [_ | T], L) :-
    filter(Pred, T, L).

pos(X) :- X > 0.
neg(X) :- X < 0.

?- filter(pos,[1,2,0,5,-5,-6,8],L), write(L), nl.
?- filter(neg,[1,2,0,5,-5,-6,8],L), write(L), nl.