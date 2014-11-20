
function mostraArea(W)
figure;
hold;
[x,y] = meshgrid(-3:0.1:3);

n = size(x);
n = n(1)*n(2);


x1 = reshape(x,1,n);
x = [ ones( 1,length(x1) )  ;  x1 ];
y = W * x;


scatter(    x1, y ,'r'   );
 
end
