% get positions from objects
position(X) :- hasShape(X,_).

% shapes
shape(square).
shape(cylinder).
shape(sphere).

% colors
color(gray).
color(blue).
color(brown).
color(yellow).
color(red).
color(green).
color(purple).
color(cyan).

% textures
texture(rubber).
texture(metal).

% sizes
size(small).
size(large).

% choose one of the objects in the sequence

1 {violation(X) : position(X)} 1.

% create object that break some of the constraints

1{violationHasShape(X,Y):shape(Y)}1 :- violation(X).
1{violationHasColor(X,Y):color(Y)}1 :- violation(X).
1{violationHasTexture(X,Y):texture(Y)}1 :- violation(X).
1{violationHasSize(X,Y):size(Y)}1 :- violation(X).

% define relation right of and left of
leftOf(X,Y) :- violation(X), position(Y), X < Y.
rightOf(Y,X) :- leftOf(X,Y).

% define touching relation
touch(X,Y) :- violation(X), position(Y), X = Y+1. 
touch(Y,X) :- touch(X,Y).

% 1: (not) square right of sphere
:- violationHasShape(X,sphere), hasShape(Y, square), rightOf(X,Y).

% 2: (not) cylinder left of sphere
:- violationHasShape(X,sphere), hasShape(Y, cylinder), leftOf(X,Y).

% 3: (not) rubber two away from metal
:- violationHasTexture(X,rubber), hasTexture(Y, metal), X > Y, X = Y + 2.
:- violationHasTexture(X,rubber), hasTexture(Y, metal), Y > X, Y = X + 2.

% 4: same color touching (right)
violationHasColor(X,C) :- touch(X,Y), violation(X), hasColor(Y,C). 

#show violationHasColor/2.
#show violationHasShape/2.
#show violationHasTexture/2.
#show violationHasSize/2.