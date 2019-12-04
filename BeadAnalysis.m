clear
clc

%-------- Insert Data -------

% Average value of bead, bead2, and bead3
beadI = {
169.39
142.47
105.57
71.43
41.54
43.10
29.29};

%---- Calculating R, I, & F --
bead_num = length(beadI');
Inte = [];
Refl = [];

k = -1;
a = 0;

% Solve for Io and R with all combinations
for i = 1:(bead_num - 1)
    for j = i:(bead_num - 1);
        k = k + 1;
        a = a + 1;
        
        syms r I
        eqn = [beadI(k + 1) == I*r^(2*k)*(1-r)^2, ...
            beadI(k + 2) == I*r^(2*(k+1))*(1-r)^2];
        
        [I,R] = vpasolve(eqn);
        
        if R(1) > 0
            Inte(a) = I(1);
            Refl(a) = R(1);
        else
            Inte(a) = I(2);
            Refl(a) = R(2);
        end
        
    end
    k = -1;
end

R = mean(Refl);

fprintf('Intensity = %.3f +/- %.3f (gray-scale)\n', mean(Inte), std(Inte));
fprintf('Reflectance = %.3f +/- %.3f\n', R, std(Refl));
fprintf('Coefficient of Finesse = %.3f\n', 4*R/(1-R)^2);

    