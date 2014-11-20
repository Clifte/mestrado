
%%
function  [y] = mlpAvalia(x, Ws)

            y = Ws * x';
            y = y > 0.5;
            
end    
 %%
