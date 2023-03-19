final_model_t_aux = final_model[t]
for i, d in enumerate(POINTS_LOAD):
    if np.sum(final_model[t][i, :]) == 0:
        dist = np.abs(np.array(range(SIZE_LOAD)) - i)
        weights = []
        for item in dist:
            if item != 0:
                weights.append(1 / item)
            else:
                weights.append(0)
        weights = np.array(weights) / np.sum(weights)
        for j in range(len(POINTS_LOAD)):
            final_model_t_aux[i, :] = final_model_t_aux[i, :] + weights[j] * final_model[t][j, :]