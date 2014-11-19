function [ l ] = labelNeuron( xd, yd, w, nn )
[m n] = size(w);

    for i=1:m
        % Obter o primeiro padrão.
        wii = w(i, :);

        % distancias para o padrao.
        diffs = bsxfun(@minus, wii, xd);
        dist = sqrt(sum(diffs.^2, 2));

        [v, indices] = sort(dist);

        vencedores = indices(1:nn);

        l(i) = mode(yd(vencedores));

    end
end

