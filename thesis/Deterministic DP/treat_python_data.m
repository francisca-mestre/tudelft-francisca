function transitions_out = treat_python_data(transitions)

sizes = size(transitions);
transitions_out = cell(sizes(1),1);

for i = 1:sizes(1)
    for j = 1:sizes(2)
        for k = 1:sizes(3)
            transitions_out{i}(j, k) = transitions(i,j,k);
        end
    end
end
