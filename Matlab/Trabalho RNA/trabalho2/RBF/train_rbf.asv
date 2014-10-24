function [W phi]=train_rbf(X,Y,Xc,k_i,basisfunction)

if nargin<4
    k_i=1;
end

if nargin<5
    basisfunction='gaussian';
end

N_r=size(Xc,1);%number of centres

W=zeros(N_r,1);%weight matrix

[z phi]=sim_rbf(Xc,X,W,k_i,basisfunction);%simulate rbf



%A=pinv(phi'*phi)*phi';%do inverse
%W=A*Y;
W=phi\Y;%find weights