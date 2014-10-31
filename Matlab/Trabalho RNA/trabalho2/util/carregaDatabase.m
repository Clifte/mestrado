function [x y] = carregaDatabase(name)

switch name
    case 'iris'
        [ x , y ] = carregaDados( 4 , '../database/iris/bezdekIris.data',3);
    case 'vertebra'
        [ x , y ] = carregaDados( 4 , '../database/verte/column_3C.dat',3);
    case 'derme'
        [ x , y ] = carregaDados( 7 , '../database/dermat/dermatology.data',6);
    otherwise
end

end