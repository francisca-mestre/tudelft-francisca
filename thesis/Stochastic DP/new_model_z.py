import numpy as np
import pandas as pd
import scipy.io
import pickle
#########################################################
# CONSTANTS
#########################################################
# Control horizon
T = 96
timeAxis = np.linspace(0000, 2400, 97)

# Model parameters
E = 1.2
ETA = 0.95
RATE_DISCHARGE = 1/(4*E*ETA)
RATE_CHARGE = ETA / (4 * E)

# State resolution
NUM_STATES = 3
SIZE_ACTION = 11
MIN_ACTION = -1.2
MAX_ACTION = 1.2
SIZE_DISTURBANCE = 5
MIN_DISTURBANCE, MAX_DISTURBANCE = -0.8, 1.2
SIZE_SOC = 5
MAX_SOC = 1
SIZE_LOAD = 5
MAX_LOAD = 4.4
MIN_LOAD = 0

POINTS_SOC = np.linspace(0, MAX_SOC, SIZE_SOC)
POINTS_LOAD = np.linspace(MIN_LOAD, MAX_LOAD, SIZE_LOAD)
POINTS_ACTION = np.linspace(MIN_ACTION, MAX_ACTION, SIZE_ACTION)
POINTS_DISTURBANCE = np.linspace(MIN_DISTURBANCE, MAX_DISTURBANCE, SIZE_DISTURBANCE)


demand_per_day = pd.read_pickle('load_per_day_2018.pkl')
days_in_month = [31, 28, 31, 30, 31, 30, 31, 31, 30, 31, 30, 31]
days_in_year = len(demand_per_day)
year = 2018


def get_disturbance_model(cluster):
    n = len(cluster)
    disturbance_model = [np.zeros((SIZE_LOAD, SIZE_DISTURBANCE))] * T
    for t in range(T):
        disturbance_model_t = np.zeros((SIZE_LOAD, SIZE_DISTURBANCE))
        demand_t = [day[t] for day in cluster]
        disturbance_t = [day[t+1]-day[t] for day in cluster]
        demand_agg_t = np.zeros(n)
        disturbance_agg_t = np.zeros(n)
        for i in range(n):
            demand_agg_t[i] = POINTS_LOAD[np.argmin(abs(demand_t[i] - POINTS_LOAD))]
            disturbance_agg_t[i] = POINTS_DISTURBANCE[np.argmin(abs(disturbance_t[i] - POINTS_DISTURBANCE))]
        for l in range(SIZE_LOAD):
            l_agg = POINTS_LOAD[l]
            # Get indices of all days in cluster that pass by l_agg at time t
            idx_l_agg_t = [i for i in range(n) if demand_agg_t[i] == l_agg]
            for z in range(SIZE_DISTURBANCE):
                z_agg = POINTS_DISTURBANCE[z]
                # Get subset of indices that change by z_agg at time t
                idx_z_agg_t = [i for i in idx_l_agg_t if disturbance_agg_t[i] == z_agg]
                if n == 1:
                    disturbance_model_t[l, z] = len(idx_z_agg_t)
                else:
                    disturbance_model_t[l, z] = len(idx_z_agg_t) + 1e-4*n
        for l in range(SIZE_LOAD):
            row_sum = sum(disturbance_model_t[l,:])
            for z in range(SIZE_DISTURBANCE):
                if row_sum != 0:
                    disturbance_model_t[l, z] = disturbance_model_t[l, z] / row_sum
        disturbance_model[t] = disturbance_model_t
    return disturbance_model


def get_cluster(target_day_idx, n):
    cluster = []
    if target_day_idx+1 > n:
        cluster_days_idx = list(range(target_day_idx-n, target_day_idx))
    else:
        aux = n-target_day_idx
        cluster_days_idx = [list(range(days_in_year-aux, days_in_year)), list(range(0, target_day_idx))]
        cluster_days_idx = [item for sublist in cluster_days_idx for item in sublist]
    for d in cluster_days_idx:
        cluster.append(demand_per_day[d])
    return cluster, cluster_days_idx


# Get deterministic models
models = []
k = 60
target_days_idx = [15]
for target_day_idx in target_days_idx:  # range(365):
    model_z = []
    cluster, cluster_days_idx = get_cluster(target_day_idx, k)
    for cluster_day in cluster:
        model_z.append(get_disturbance_model([cluster_day]))

    # Arrange each model
    for model in model_z:
        for t in range(T):
            model_t = model[t]
            for i, d in enumerate(POINTS_LOAD):
                if np.sum(model_t[i, :]) != 0:
                    for j, z in enumerate(POINTS_DISTURBANCE):
                        model_t[i, j] = model_t[i, j] + 1e-4

    # Combine models
    final_model = [np.zeros((SIZE_LOAD, SIZE_DISTURBANCE))]*T
    for t in range(T):
        for i, d in enumerate(POINTS_LOAD):
            for model in model_z:
                model_t = model[t]
                final_model[t] = final_model[t] + (1/k)*model_t

        final_model_t_aux = final_model[t]
        for i, d in enumerate(POINTS_LOAD):
            if np.sum(final_model[t][i, :]) == 0:
                dist = np.abs(np.array(range(SIZE_LOAD))-i)
                weights = []
                for item in dist:
                    if item != 0:
                        weights.append(1/item)
                    else:
                        weights.append(0)
                weights = np.array(weights)/np.sum(weights)
                for j in range(len(POINTS_LOAD)):
                    final_model_t_aux[i, :] = final_model_t_aux[i, :] + weights[j]*final_model[t][j, :]

        for i, d in enumerate(POINTS_LOAD):
            # When the row is ready, accumulate impossible probabilities
            if d + POINTS_DISTURBANCE[0] < 0:
                condition, j = True, 0
                while condition:
                    j += 1
                    if d + POINTS_DISTURBANCE[j] >= 0 or j >= SIZE_DISTURBANCE - 1:
                        accumulating_idx = j
                        condition = False
            elif d + POINTS_DISTURBANCE[SIZE_DISTURBANCE - 1] > MAX_LOAD:
                condition, j = True, SIZE_DISTURBANCE
                while condition:
                    j -= 1
                    if d + POINTS_DISTURBANCE[j] <= MAX_LOAD or j <= 0:
                        accumulating_idx = j
                        condition = False

            accumulate = 0
            for j, z in enumerate(POINTS_DISTURBANCE):
                if d + z <= 0 or d + z >= MAX_LOAD:
                    accumulate += final_model_t_aux[i, j]
                    final_model_t_aux[i, j] = 0
            final_model_t_aux[i, accumulating_idx] = final_model_t_aux[i, accumulating_idx] + accumulate
            final_model[t][i, :] = np.array(final_model_t_aux[i, :]) / np.sum(final_model_t_aux[i, :])
    models.append(final_model)
# scipy.io.savemat('disturbance_model_academic_test.mat', {'disturbance_models': models})


