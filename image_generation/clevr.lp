% shapes
shape(cube).
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
position(1..5).

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
:- hasShape(X,square), hasShape(Y, sphere), leftOf(X,Y).

% 2: cylinder left of sphere
:- hasShape(X,cylinder), hasShape(Y, sphere), rightOf(X,Y).

% 3: no same color touching
:- hasColor(X,C), hasColor(Y,C), touch(X,Y). 

% preferences on sequences

% 4: large prefer next to small
% :~ hasSize(X,large), touch(X,Y), not hasSize(Y,small). [1,X,Y]

% % 5: green prefer next to rubber
% :~ hasColor(X,green), touch(X,Y), not hasTexture(Y,rubber). [1,X,Y]

% % 6: purple prefer next to spheres
% :~ hasColor(X,purple), touch(X,Y), not hasShape(Y,sphere). [1,X,Y]

% guess the missing slot
1{out(X):position(X)}1.

% generate an alternative answer for the empty slot 

% for compactness we exemplify the generation of alternative answers that violate constraint 3
outHasColor(X,C) :- out(X), leftOf(X,Y), hasColor(Y,C), X<5. 
outHasColor(X,C) :- out(X), touch(X,Y), hasColor(Y,C).

% the rest of the choices for  shapes, texture, size of the alternative answer are random
1{outHasShape(X,Y):shape(Y)}1 :- out(X).
1{outHasTexture(X,Y):texture(Y)}1 :- out(X).
1{outHasSize(X,Y):size(Y)}1 :- out(X).

#show hasColor/2.
#show hasShape/2.
#show hasTexture/2.
#show hasSize/2.

#show outHasColor/2.
#show outHasShape/2.
#show outHasTexture/2.
#show outHasSize/2.