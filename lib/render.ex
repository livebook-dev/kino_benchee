defimpl Kino.Render, for: Benchee.Suite do
  def to_livebook(suite_results) do
    # ---- Run time stats ----
    run_time_table = run_time_table(suite_results)
    run_time_chart = run_time_chart(suite_results)
    run_time_stats = Kino.Layout.grid([run_time_table, run_time_chart])

    # ---- Memory stats ----
    memory_table = memory_table(suite_results)
    memory_chart = memory_chart(suite_results)
    memory_stats = Kino.Layout.grid([memory_table, memory_chart])

    # ---- Reduction stats ----
    reductions_table = reductions_table(suite_results)
    reductions_chart = reductions_chart(suite_results)
    reductions_stats = Kino.Layout.grid([reductions_table, reductions_chart])

    tabs =
      Kino.Layout.tabs(
        "Run Time Statistics": run_time_stats,
        "Memory Statistics": memory_stats,
        "Reduction Statistics": reductions_stats
      )

    Kino.Render.to_livebook(tabs)
  end

  defp memory_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Memory Usage Comparison",
      keys: [
        "job_name",
        "memory_average",
        "memory_minimum",
        "memory_maximum",
        "memory_sample_size"
      ]
    )
  end

  defp memory_chart(suite_results) do
    VegaLite.new(
      width: 600,
      height: 400,
      title: "Average Memory Usage (lower is better)"
    )
    |> VegaLite.data_from_values(suite_results, only: ["job_name", "memory_average"])
    |> VegaLite.mark(:bar)
    |> VegaLite.encode_field(:y, "job_name", type: :nominal, title: "Job name")
    |> VegaLite.encode_field(:x, "memory_average",
      type: :quantitative,
      title: "Memory usage (bytes)"
    )
    |> VegaLite.encode_field(:color, "job_name", type: :nominal)
  end

  defp run_time_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Run Time Comparison",
      keys: [
        "job_name",
        "run_time_ips",
        "run_time_average",
        "run_time_minimum",
        "run_time_maximum",
        "run_time_sample_size"
      ]
    )
  end

  defp run_time_chart(suite_results) do
    VegaLite.new(
      width: 600,
      height: 400,
      title: "Average Iterations per Second (higher is better)"
    )
    |> VegaLite.data_from_values(suite_results, only: ["job_name", "run_time_ips"])
    |> VegaLite.mark(:bar)
    |> VegaLite.encode_field(:y, "job_name", type: :nominal, title: "Job name")
    |> VegaLite.encode_field(:x, "run_time_ips",
      type: :quantitative,
      title: "Iterations per second"
    )
    |> VegaLite.encode_field(:color, "job_name", type: :nominal)
  end

  defp reductions_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Reductions Comparison",
      keys: [
        "job_name",
        "reductions_average",
        "reductions_minimum",
        "reductions_maximum",
        "reductions_sample_size"
      ]
    )
  end

  defp reductions_chart(suite_results) do
    VegaLite.new(width: 600, height: 400, title: "Average Reductions (lower is better)")
    |> VegaLite.data_from_values(suite_results, only: ["job_name", "reductions_average"])
    |> VegaLite.mark(:bar)
    |> VegaLite.encode_field(:y, "job_name", type: :nominal, title: "Job name")
    |> VegaLite.encode_field(:x, "reductions_average",
      type: :quantitative,
      title: "Reductions count"
    )
    |> VegaLite.encode_field(:color, "job_name", type: :nominal)
  end
end
