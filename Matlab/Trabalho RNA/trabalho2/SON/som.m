function net = som(X,N)
[m n] = size(X);

net = rand(N,n);
T = m*n;
c = 0;

%Percorrendo todos os dados
for i=1:m
    xii = X(i,:);
    
    distance = repmat(xii,[N 1]);
    distance = (distance - net) .* (distance - net);
    distance = exp(-sum(distance') );
    
    %Percorrendo todos os neurônios
     for j=1:n
         c = c + 1;
         alpha = exp(-c/T);
         d = net(j,:) - xii;
         dNet = d * alpha * distance(j);
         net(j,:) = net(j,:) + dNet;
     end
end

end