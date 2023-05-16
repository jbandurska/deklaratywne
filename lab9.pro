mylength(0,[]).
mylength(N,[_|L]) :- mylength(M,L), N is M+1.

?- mylength(N, [1,2,3]), write(N).

mymember(X, [X | _]).
mymember(X, [_ | T]) :- mymember(X, T).

?- mymember(5, [1,2,3,4,5,6,7]).
?- mymember(1, [2,3,4,6,7]).

myfactorial(1, 0).
myfactorial(N, X) :- 
    X > 0,
    Y is X-1,
    myfactorial(M, Y),
    N is M*X.

myfibonacci(0, 0).
myfibonacci(1, 1).
myfibonacci(X, N) :- 
    X > 1,
    X1 is X-1,
    X2 is X-2,
    myfibonacci(X1, M1),
    myfibonacci(X2, M2),
    N is M1 + M2.

gcd(A, A, A).
gcd(A, B, X) :-
    A > B,
    AmB is A - B,
    gcd(AmB, B, X).
gcd(A, B, X) :-
    A < B,
    BmA is B - A,
    gcd(A, BmA, X).

parent(darek, julka).
parent(basia, julka).
parent(darek, sara).
parent(basia, sara).
parent(jan, darek).
parent(sara, jasiu).
male(jasiu).
male(darek).
male(jan).
female(julka).
female(sara).
female(basia).

child(Dziecko, Dorosly) :- parent(Dorosly, Dziecko).
mother(Matka, Dziecko) :- parent(Matka, Dziecko), female(Matka).
sister(Sister1, Sister2) :- parent(Matka, Sister1), parent(Matka, Sister2).
has_a_child(Dorosly) :- parent(Dorosly, Dziecko).
grandparent(Grandparent, Grandchild) :- parent(Grandparent, Child), parent(Child, Grandchild).
predecessor(Predecessor, Human) :- 
    has_a_child(Predecessor),
    parent(Predecessor, Human).
predecessor(Predecessor, Human) :- 
    has_a_child(Predecessor),
    parent(Predecessor, Child),
    predecessor(Child, Human).

latin([], 0).
latin([C1, C2 | L], N) :-
  value(C1, V1),
  value(C2, V2),
  V1 < V2,
  latin(L, M),
  N is M + V2 - V1.
latin([C | L], N) :-
  value(C, V),
  latin(L, M),
  N is M + V.
  
value(i, 1).
value(v, 5).
value(x, 10).
value(l, 50).
value(c, 100).
value(d, 500).
value(m, 1000).

myplus(A, 0, A).
myplus(A, B, X) :-
    B > 0,
    Ax is A + 1,
    Bx is B - 1,
    myplus(Ax, Bx, X).

mytimes(A, 1, A).
mytimes(A, B, X) :-
    B > 1,
    Bx is B - 1,
    mytimes(A, Bx, S),
    X is S + A.

sum_up(0, 0).
sum_up(N, X) :-
    N > 0,
    Nx is N - 1,
    sum_up(Nx, Xx),
    X is Xx + N.