position(1..5).

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

% generate a sequence of size 5

% for every position guess its color, shape, texture and size
1{hasShape(X,Y):shape(Y)}1 :- position(X).
1{hasColor(X,Y):color(Y)}1 :- position(X).
1{hasTexture(X,Y):texture(Y)}1 :- position(X).
1{hasSize(X,Y):size(Y)}1 :- position(X).

% define relation right of and left of
leftOf(X,Y) :- position(X), position(Y), X < Y.
rightOf(Y,X) :- leftOf(X,Y).

% define touching relation
touch(X,Y) :- position(X), position(Y), X = Y+1. 
touch(Y,X) :- touch(X,Y).

% exclude sequences that violate constraints

% 1: square right of sphere
:- hasShape(X,square), hasShape(Y, sphere), not rightOf(X,Y).

% 2: cylinder left of sphere
:- hasShape(X,cylinder), hasShape(Y, sphere), not leftOf(X,Y).

% 3: rubber two away from metal
ok_3 :- hasTexture(X,rubber), hasTexture(Y, metal), X > Y, X = Y + 2.
ok_3 :- hasTexture(X,rubber), hasTexture(Y, metal), Y > X, Y = X + 2.
not ok_3.

% 4: no same color touching
:- hasColor(X,C), hasColor(Y,C), touch(X,Y). 

% preferences on sequences (optional)

% 5: large prefer next to small
% 6: green prefer next to rubber

violationHasColor(2,blue). 
violationHasShape(2,square). 
violationHasSize(2,large). 
violationHasTexture(2,metal).



#show hasColor/2.
#show hasShape/2.
#show hasTexture/2.
#show hasSize/2.

