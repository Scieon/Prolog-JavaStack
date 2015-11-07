
class('Stack').
class('BoundedStack').
class('ResettableBoundedStack').
class('Stack2').
class('Stack3').

interface('Lockable').

extends('BoundedStack', 'Stack').
extends('ResettableBoundedStack', 'BoundedStack').
extends('Stack2', 'ResettableBoundedStack').
extends('Stack3', 'Stack2').

implements('BoundedStack', 'Lockable').

declares('Stack', [private, 'ArrayList<String>', elements]).
declares('Stack', [protected, int, top, [void]]).
declares('Stack3', [public, double, entropy]).
declares('Stack3', [public, 'String', label]).
declares('Stack3', [public, bool, ignoreFlag]).

defines('Stack', [public, void, push, ['String']]).
defines('Stack', [public, 'String', pop, [void]]).
defines('BoundedStack', [public, 'void', push, ['String']]).
defines('ResettableBoundedStack', [public, 'void', reset, [void]]).
defines('Stack2', [public, 'String', gget, [void]]).

defines('Stack3', [public, void, entropicPush, ['String']]).
defines('Stack3', [public, 'String', entropicPop, [void]]).
defines('Stack3', [public, 'String', entropicTop, [void]]).
defines('Stack3', [public, int, entropicCount, [void]]).
defines('Stack3', [public, 'String', toString, [void]]).


root(Class,Y) :-  getChain(Class,Z), last(Z,Y).  %Returns root class
%root(Class,Y) :- last(Z,Y), getChain(Class,Z).  %Stack OverFlow
numFeatures(Class,Size1) :- findall(R, defines(Class,R);declares(Class,R),Lst),list_to_set(Lst,Chain),length(Chain,Size1).
numRootFeatures(Class,Size2) :- root(Class,Super),findall(R, defines(Super,R);declares(Super,R),Lst),list_to_set(Lst,Chain),length(Chain,Size2).

is_bloated(Class) :- numFeatures(Class,Size1),numRootFeatures(Class,Size2), Size1>Size2.

%Find the methods in given class and all the methods in the superclasses.
meth(X,Chain) :- findall(R, defines(X,R);(ancestor(X,Z),defines(Z,R)),Lst), list_to_set(Lst,Chain).


inherit(Class,Chain) :- findall(Class, extends(Class,'Stack'),Lst), list_to_set(Lst,Chain).
%getChild(Children,Set) :- findall(Children, parent(_,Children),Lst), list_to_set(Lst,Set).

ancestor(X, Y) :- extends(X, Y). %Base Case: X is a subclass of Y.
ancestor(X, Y) :- extends(X, Z), ancestor(Z, Y). %Recursive call to find all superclasses of given class X.
getChain(Class,Chain) :- findall(R, ancestor(Class,R), Chain). %Find all 'R' such that the given class is a  subclass of R.


descend(X,Y) :- extends(X,Y). %Input is Y.
descend(X, Y) :- extends(X,Z), descend(Z,Y).

interClass(Class,Interface) :- implements(Class,Interface).

provides(Class, Interface, List) :- findall(R, (descend(R,Class), interClass(Class,Interface)), List).

provides2(Class, Interface, List) :- findall(R, (interClass(R,Interface);(descend(R,Class), interClass(Class,Interface))), List).%Find the first class that implements the interface than find all its children.




