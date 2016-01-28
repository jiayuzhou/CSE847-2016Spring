%% A script showing how the effects of truncated SVD 

close all;
p= 100; % truncated Rank

%
I = imread('cameraman.tif'); 
% this file should be available from your Matlab installation.
% otherwise, you should easily find one by Googling the file name. 

X = im2double(I);

% display original image
figure
imshow(X)
title( sprintf('rank=%d, storage size=%d, recons. err=%g', rank(X), numel(X), 0) )

% truncated SVD
[U, S, V] = svd(X);
Up = U(:,1:p);
Vp = V(:,1:p);
Sp = S(1:p,1:p);

% reconstruction
XHat = Up * Sp * Vp';                
err = mean( abs(X(:)-XHat(:)) );           % mean absolute error
sz = (numel(Up) + numel(Vp) + numel(Sp));  % new size

% display compressed image
figure
imshow(XHat)
title( sprintf('rank=%d, storage size=%d, recons. err=%g', p, sz, err) )
