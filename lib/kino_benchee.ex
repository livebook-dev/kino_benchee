defimpl Kino.Render, for: Benchee.Suite do
  def to_livebook(suite_results) do
    # Run time visuals
    run_time_table = run_time_table(suite_results)
    run_time_chart = run_time_chart(suite_results)
    run_time_stats = Kino.Layout.grid([run_time_table, run_time_chart])

    # Memory visuals
    memory_table = memory_table(suite_results)
    memory_chart = memory_chart(suite_results)
    memory_stats = Kino.Layout.grid([memory_table, memory_chart])

    # Reduction visuals
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

  defp chart(
         %{configuration: %{input_names: input_names}} = suite_results,
         title,
         field,
         field_title
       )
       when input_names != [] do
    VegaLite.new(title: title)
    |> VegaLite.data_from_values(suite_results,
      only: ["job_name", "input_name", field]
    )
    |> VegaLite.facet(
      [
        row: [
          field: "input_name",
          title: nil,
          sort: suite_results.configuration.input_names,
          header: [
            label_orient: "top",
            label_font_style: "italic",
            label_font_size: 16
          ]
        ]
      ],
      VegaLite.new(width: 600, height: 400)
      |> VegaLite.mark(:bar)
      |> VegaLite.encode_field(:y, "job_name", type: :nominal, title: "Job name")
      |> VegaLite.encode_field(:x, field,
        type: :quantitative,
        title: field_title
      )
      |> VegaLite.encode_field(:color, "job_name", type: :nominal, title: "Job name")
    )
  end

  defp chart(suite_results, title, field, field_title) do
    VegaLite.new(width: 600, height: 400, title: title)
    |> VegaLite.data_from_values(suite_results, only: ["job_name", field])
    |> VegaLite.mark(:bar)
    |> VegaLite.encode_field(:y, "job_name", type: :nominal, title: "Job name")
    |> VegaLite.encode_field(:x, field, type: :quantitative, title: field_title)
    |> VegaLite.encode_field(:color, "job_name", type: :nominal, title: "Job name")
  end

  defp memory_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Memory Usage Comparison",
      keys: [
        "job_name",
        "input_name",
        "memory_average",
        "memory_minimum",
        "memory_maximum",
        "memory_sample_size"
      ]
    )
  end

  defp memory_chart(suite_results) do
    chart(
      suite_results,
      "Average Memory Usage (lower is better)",
      "memory_average",
      "Memory usage (bytes)"
    )
  end

  defp run_time_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Run Time Comparison",
      keys: [
        "job_name",
        "input_name",
        "run_time_ips",
        "run_time_average",
        "run_time_minimum",
        "run_time_maximum",
        "run_time_sample_size"
      ]
    )
  end

  defp run_time_chart(suite_results) do
    chart(
      suite_results,
      "Average Iterations per Second (higher is better)",
      "run_time_ips",
      "Iterations per second"
    )
  end

  defp reductions_table(suite_results) do
    Kino.DataTable.new(
      suite_results,
      name: "Reductions Comparison",
      keys: [
        "job_name",
        "input_name",
        "reductions_average",
        "reductions_minimum",
        "reductions_maximum",
        "reductions_sample_size"
      ]
    )
  end

  defp reductions_chart(suite_results) do
    chart(
      suite_results,
      "Average Reductions (lower is better)",
      "reductions_average",
      "Reductions count"
    )
  end
end
