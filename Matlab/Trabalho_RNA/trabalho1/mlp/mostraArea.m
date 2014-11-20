
function mostraArea(Ws)
figure;
hold;

nCh = length(Ws(1,:));
rnCh = ceil(sqrt( (1+nCh)*nCh/2));

plIndex=1;

for ch1=1:nCh
      for ch2 = ch1 +1 : nCh
        subplot(rnCh,rnCh,plIndex)
        

        
        plIndex = plIndex + 1;  
      end
end



W = Ws(1,:);

[x,y] = meshgrid(0:0.2:10);

n = size(x);
n = n(1)*n(2);

x1 = reshape(x,1,n);
x2 = reshape(y,1,n);

x = [ones(1,length(x1));x1;x2];

y = W * x;


for ii = 1:length(y)
      scatter3(x1(ii),x2(ii),y(ii),'y')
end
 
end
