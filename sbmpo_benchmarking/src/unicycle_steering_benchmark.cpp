#include <sbmpo/models/UnicycleSteering.hpp>
#include <sbmpo/tools/benchmarks/Obstacles2D.hpp>

using namespace sbmpo;
using namespace sbmpo_models;
using namespace sbmpo_benchmarking;

int main (int argc, char ** argv) {

    // Path to csv workspace
    std::string csv_folder;

    // Check arguments
    if (argc > 1) {
        csv_folder = argv[1];
    } else {
        printf("\nMissing CSV folder path.\n");
        return 0;
    }

    // Create new UnicycleSteering benchmark
    Obstacles2DBenchmark<UnicycleSteeringModel> benchmarker(csv_folder);

    // Change benchmark parameters
    benchmarker.model()->set_body_radius(0.125f);
    benchmarker.model()->set_goal_threshold(0.5f);
    benchmarker.set_runs_per_param(50);

    // Run benchmark (saves to csv folder)
    benchmarker.benchmark();

    return 0;

}