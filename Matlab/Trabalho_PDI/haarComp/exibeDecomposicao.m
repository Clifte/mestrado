function exibeDecomposicao( dH, dV, dD, dA )
    subaxis(2,2,1, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
    imshow(mat2gray(dA))
    xlabel('a', 'FontSize', 15)

    subaxis(2,2,2, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
    imshow(mat2gray(dV))
    xlabel('b', 'FontSize', 15)

    subaxis(2,2,3, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
    imshow(mat2gray(dH))
    xlabel('c', 'FontSize', 15)
    
    subaxis(2,2,4, 'Spacing', 0.08, 'Padding', 0, 'MB', 0.1, 'MT', 0.01);
    imshow(mat2gray(dD))
    xlabel('d', 'FontSize', 15)
end