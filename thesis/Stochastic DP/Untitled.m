disturbance_models_aux = cell(1, 365);
for day = 1:1
    disturbance_model_day = cell(1, 96);
    for t = 1:96
        disturbance_model_t = reshape(disturbance_models(day, t, :, :), [21, 41]);
        disturbance_model_day{t} = disturbance_model_t;
    end
    disturbance_models_aux{day} = disturbance_model_day;
end
disturbance_models = disturbance_models_aux;