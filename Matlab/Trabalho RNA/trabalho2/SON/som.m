function net = som(X,N)
[m n] = size(X);

net = rand(N,n) ;
mxep = 3;
T = m*n*mxep;
c = 0;
th = 0.5;


for ep=1:mxep
%Percorrendo todos os dados
for i=1:m
    xii = X(i,:);
    
    distance = repmat(xii,[N 1]);
    distance = (distance - net) .* (distance - net);
    distance = exp(-sum(distance') );
    
    [v l] = max(distance');
    l
    %Percorrendo todos os neurônios
     for j=1:N
         d =  xii - net(j,:);
         

         alpha = exp(-20 * c/T);
         
         dNet = alpha * d;
         net(j,:) = net(j,:) + dNet;
         c = c + 1;
         
         
        scatter(X(:,1),X(:,2),'r');
        hold on;
        scatter(net(:,1),net(:,2),'b');
        hold off;
        drawnow;

     end
     

end
end
end