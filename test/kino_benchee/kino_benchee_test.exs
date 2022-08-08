defmodule KinoBencheeTest do
  use ExUnit.Case, async: true

  test "KinoBenchee should render benchee suite statistics" do
    render_result = Kino.Render.to_livebook(sample_benchee_suite())

    # Ensure that we got the run time, memory and reduction tabs
    assert {
             :tabs,
             [
               {:grid, _, %{columns: 1}},
               {:grid, _, %{columns: 1}},
               {:grid, _, %{columns: 1}}
             ],
             %{labels: ["Run Time Statistics", "Memory Statistics", "Reduction Statistics"]}
           } = render_result
  end

  defp sample_benchee_suite do
    %Benchee.Suite{
      configuration: %Benchee.Configuration{
        after_each: nil,
        after_scenario: nil,
        assigns: %{},
        before_each: nil,
        before_scenario: nil,
        formatters: [Benchee.Formatters.Console],
        inputs: nil,
        load: false,
        measure_function_call_overhead: false,
        memory_time: 2.0e9,
        parallel: 1,
        percentiles: '2c',
        pre_check: false,
        print: %{benchmarking: true, configuration: true, fast_warning: true},
        profile_after: false,
        reduction_time: 0.0,
        save: false,
        time: 2.0e9,
        title: nil,
        unit_scaling: :best,
        warmup: 2.0e9
      },
      scenarios: [
        %Benchee.Scenario{
          after_each: nil,
          after_scenario: nil,
          before_each: nil,
          before_scenario: nil,
          input: :__no_input,
          input_name: :__no_input,
          job_name: "Erlang",
          memory_usage_data: %Benchee.CollectionData{
            samples: Enum.to_list(1..100),
            statistics: %Benchee.Statistics{
              absolute_difference: nil,
              average: 1792.0,
              ips: nil,
              maximum: 1792,
              median: 1792.0,
              minimum: 1792,
              mode: 1792,
              percentiles: %{50 => 1792.0, 99 => 1792.0},
              relative_less: nil,
              relative_more: nil,
              sample_size: 77379,
              std_dev: 0.0,
              std_dev_ips: nil,
              std_dev_ratio: 0.0
            }
          },
          name: "Erlang",
          reductions_data: %Benchee.CollectionData{
            samples: [],
            statistics: %Benchee.Statistics{
              absolute_difference: nil,
              average: nil,
              ips: nil,
              maximum: nil,
              median: nil,
              minimum: nil,
              mode: nil,
              percentiles: nil,
              relative_less: nil,
              relative_more: nil,
              sample_size: 0,
              std_dev: nil,
              std_dev_ips: nil,
              std_dev_ratio: nil
            }
          },
          run_time_data: %Benchee.CollectionData{
            samples: Enum.to_list(1..100),
            statistics: %Benchee.Statistics{
              absolute_difference: nil,
              average: 2854.02659820102,
              ips: 350_382.1585371105,
              maximum: 3_741_076,
              median: 2164.0,
              minimum: 2063,
              mode: 2124,
              percentiles: %{50 => 2164.0, 99 => 5881.0},
              relative_less: nil,
              relative_more: nil,
              sample_size: 597_672,
              std_dev: 13106.875011228927,
              std_dev_ips: 1_609_100.3359973046,
              std_dev_ratio: 4.592415158110506
            }
          },
          tag: nil
        },
        %Benchee.Scenario{
          after_each: nil,
          after_scenario: nil,
          before_each: nil,
          before_scenario: nil,
          input: :__no_input,
          input_name: :__no_input,
          job_name: "Jason",
          memory_usage_data: %Benchee.CollectionData{
            samples: Enum.to_list(1..100),
            statistics: %Benchee.Statistics{
              absolute_difference: 3912.0,
              average: 5704.0,
              ips: nil,
              maximum: 5704,
              median: 5704.0,
              minimum: 5704,
              mode: 5704,
              percentiles: %{50 => 5704.0, 99 => 5704.0},
              relative_less: 0.3141654978962132,
              relative_more: 3.1830357142857144,
              sample_size: 48567,
              std_dev: 0.0,
              std_dev_ips: nil,
              std_dev_ratio: 0.0
            }
          },
          name: "Jason",
          reductions_data: %Benchee.CollectionData{
            samples: [],
            statistics: %Benchee.Statistics{
              absolute_difference: nil,
              average: nil,
              ips: nil,
              maximum: nil,
              median: nil,
              minimum: nil,
              mode: nil,
              percentiles: nil,
              relative_less: nil,
              relative_more: nil,
              sample_size: 0,
              std_dev: nil,
              std_dev_ips: nil,
              std_dev_ratio: nil
            }
          },
          run_time_data: %Benchee.CollectionData{
            samples: Enum.to_list(1..100),
            statistics: %Benchee.Statistics{
              absolute_difference: 2618.4219660917665,
              average: 5472.448564292787,
              ips: 182_733.5585253201,
              maximum: 2_901_705,
              median: 4518.0,
              minimum: 4288,
              mode: 4418,
              percentiles: %{50 => 4518.0, 99 => 8977.0},
              relative_less: 0.5215264364151864,
              relative_more: 1.9174483404402178,
              sample_size: 338_335,
              std_dev: 10372.27093825749,
              std_dev_ips: 346_346.23903157556,
              std_dev_ratio: 1.895361978536552
            }
          },
          tag: nil
        }
      ]
    }
  end
end
