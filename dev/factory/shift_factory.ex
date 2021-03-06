defmodule MyPay.Factory.Shift do
  alias MyPay.Meta
  alias MyPay.Meta.Api, as: MetaApi
  alias MyPay.Shift.Api
  alias MyPay.Factory, as: FactoryUtils
  alias MyPay.Factory.Meta, as: MetaFactory

  @start_date ~D[1900-01-01]
  @null_time ~T[00:00:00.000000]
  @one_hr_milli_secs 3_600_000_000
  @date_offset 0..30_000
  @iso_time "{ISOtime}"
  @iso_date "{ISOdate}"

  def insert(params \\ %{}) do
    {:ok, meta} =
      MetaFactory.params()
      |> MetaApi.create_()

    insert(params, meta)
  end

  def insert(params, %Meta{} = meta) do
    attrs = params(params)

    {:ok, shift} =
      attrs
      |> Map.put(:meta_id, meta.id)
      |> Api.create_(meta)

    shift
  end

  def params(attrs \\ %{})

  def params(attrs) when is_list(attrs),
    do:
      attrs
      |> Map.new()
      |> params()

  def params(attrs) do
    start_time =
      attrs
      |> Map.get(:start_time)
      |> start_time()

    %{
      date: date(attrs[:date]),
      start_time: start_time,
      end_time:
        attrs
        |> Map.get(:end_time)
        |> end_time(start_time)
    }
  end

  def random_date, do: Date.add(@start_date, Enum.random(@date_offset))

  @spec unique_random_day_of_month(
          days_range :: %Range{},
          selected_days :: [Integer.t()]
        ) :: {Integer.t(), [Integer.t()]}
  def unique_random_day_of_month(%Range{} = days_range, [] = _selected_days) do
    day = Enum.random(days_range)
    {day, [day]}
  end

  def unique_random_day_of_month(%Range{} = days_range, selected_days)
      when is_list(selected_days) do
    day = Enum.random(days_range)

    case Enum.member?(selected_days, day) do
      true -> unique_random_day_of_month(days_range, selected_days)
      _ -> {day, [day | selected_days]}
    end
  end

  def stringify(%{} = params) do
    params
    |> Enum.map(fn
      {:date, d} -> {"date", format_date(d)}
      {:end_time, t} -> {"endTime", format_time(t)}
      {:start_time, t} -> {"startTime", format_time(t)}
      x -> x
    end)
    |> Enum.into(%{})
  end

  defp date(nil), do: random_date()

  defp date(val), do: val

  defp start_time(nil) do
    time_offset =
      0.0
      |> FactoryUtils.random_float_between(23.99, 6)
      |> Kernel.*(@one_hr_milli_secs)
      |> trunc()

    Time.add(@null_time, time_offset, :millisecond)
  end

  defp start_time(val), do: val

  defp end_time(nil, %Time{} = start_time) do
    time_offset =
      0.4
      |> FactoryUtils.random_float_between(15.99, 6)
      |> Kernel.*(@one_hr_milli_secs)
      |> trunc()

    Time.add(start_time, time_offset, :millisecond)
  end

  defp end_time(val, _), do: val

  defp format_time(%Time{} = time), do: Timex.format!(time, @iso_time)
  defp format_date(%Date{} = date), do: Timex.format!(date, @iso_date)
end
