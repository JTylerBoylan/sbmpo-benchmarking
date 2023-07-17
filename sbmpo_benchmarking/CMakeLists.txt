cmake_minimum_required(VERSION 3.15)

# Define project
project(sbmpo_benchmarking)

# Simple Steering Model Executable
add_executable(unicycle_steering_benchmark
  src/unicycle_steering_benchmark.cpp
)
target_link_libraries(unicycle_steering_benchmark PUBLIC sbmpo stdc++ stdc++fs m)

# Double Integrator Model Executable
add_executable(double_integrator_benchmark
  src/double_integrator_benchmark.cpp
)
target_link_libraries(double_integrator_benchmark PUBLIC sbmpo stdc++ stdc++fs m)

# Ackermann Steering Model Executable
add_executable(ackermann_steering_benchmark
  src/ackermann_steering_benchmark.cpp
)
target_link_libraries(ackermann_steering_benchmark PUBLIC sbmpo stdc++ stdc++fs m)