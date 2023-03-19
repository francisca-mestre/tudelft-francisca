function [J, U] = computeValueFunctionAndPolicy(J1,systemDynamics,transitionMatrix)

global N_SoC N_peak

J = zeros(N_SoC, N_peak, N_peak);
U = zeros(N_SoC, N_peak, N_peak);
for C = 1:N_SoC
    for P = 1:N_peak
        for L = 1:N_peak
            [c, p, l] = mapping(C, P, L); x = [c p l];
            transitionVectorL = transitionMatrix(L,:);
            [v_hat, u] = retrieveJAndU(x,J1,systemDynamics,transitionVectorL);
            J(C,P,L) = v_hat;
            U(C,P,L) = u;
        end
    end
end

end