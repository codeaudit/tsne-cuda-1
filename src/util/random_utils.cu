/**
 * @brief Utilities for generating random numbers/elements/vectors
 * 
 * @file random_utils.cu
 * @author David Chan
 * @date 2018-04-04
 * Copyright (c) 2018, Regents of the University of California
 */

#include "include/util/random_utils.h"

thrust::device_vector<float> tsnecuda::util::RandomDeviceUniformZeroOneVector(
        std::default_random_engine &generator, const int vector_size) {
    return tsnecuda::util::RandomDeviceVectorInRange(generator, vector_size, 0.0, 1.0);
}

thrust::device_vector<float> tsnecuda::util::RandomDeviceVectorInRange(
    std::default_random_engine &generator,
    const int vector_size, float lower_bound, float upper_bound) {

    // Construct a uniform real vector distribution
    std::uniform_real_distribution<float> distribution(lower_bound,
                                                       upper_bound);
    float* host_points = new float[vector_size];
    for (size_t i = 0; i < vector_size; i++)
        host_points[i] = distribution(generator);

    // Copy the matrix to the GPU
    thrust::device_vector<float> gpu_vector(vector_size);
    thrust::copy(host_points, host_points+vector_size,
                 gpu_vector.begin());
    delete[] host_points;
    return gpu_vector;
}