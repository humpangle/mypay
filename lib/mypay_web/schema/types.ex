defmodule MyPayWeb.Schema.Types do
  @moduledoc """
  Custom types (scalars, objects and input types) shared among schema types
  """
  use Absinthe.Schema.Notation
  use Timex

  @iso_datetime_format "{ISO:Extended:Z}"
  @twenty_four_hr_min_time_format "{h24}:{m}"

  scalar :iso_datetime, name: "ISODatime" do
    parse(fn value -> parse_iso_datetime(value, @iso_datetime_format) end)
    serialize(&Timex.format!(&1, @iso_datetime_format))
  end

  scalar :twenty_four_hr_min_time, name: "TwentyFourHrMinTime" do
    parse(&parse_twenty_four_hr_min_time/1)
    serialize(&Timex.format!(&1, @twenty_four_hr_min_time_format))
  end

  @desc "Sorting directive"
  enum :sorting_directive do
    value(:asc, description: "Sort from smallest to largest")
    value(:desc, description: "Sort from largest to smallest")
  end

  @desc "Inequality enums"
  enum :inequality do
    value(:lt, description: "Less than")
    value(:lte, description: "Less than or equal to")
    value(:eq, description: "Equal to")
    value(:gt, description: "Greater than")
    value(:gte, description: "Greater than or equal to")
  end

  input_object :string_inequality do
    field(:key, non_null(:inequality))
    field(:value, non_null(:string))
  end

  @spec parse_iso_datetime(Absinthe.Blueprint.Input.String.t(), String.t()) ::
          {:ok, DateTime.t() | NaiveDateTime.t()} | :error
  defp parse_iso_datetime(
         %Absinthe.Blueprint.Input.String{value: value},
         format
       ) do
    case Timex.parse(value, format) do
      {:ok, val} -> {:ok, val}
      {:error, _} -> :error
    end
  end

  @spec parse_iso_datetime(Absinthe.Blueprint.Input.Null.t(), any) :: {:ok, nil}
  defp parse_iso_datetime(%Absinthe.Blueprint.Input.Null{}, _) do
    {:ok, nil}
  end

  defp parse_iso_datetime(_, _) do
    :error
  end

  @spec parse_twenty_four_hr_min_time(Absinthe.Blueprint.Input.String.t()) ::
          {:ok, Time.t()} | :error
  defp parse_twenty_four_hr_min_time(%Absinthe.Blueprint.Input.String{
         value: value
       }) do
    case Timex.parse(value, @twenty_four_hr_min_time_format) do
      {:ok, time} ->
        {
          :ok,
          time
          |> Timex.to_datetime()
          |> DateTime.to_time()
        }

      {:error, _} ->
        :error
    end
  end

  @spec parse_twenty_four_hr_min_time(Absinthe.Blueprint.Input.Null.t()) :: {
          :ok,
          nil
        }
  defp parse_twenty_four_hr_min_time(%Absinthe.Blueprint.Input.Null{}) do
    {:ok, nil}
  end

  defp parse_twenty_four_hr_min_time(_) do
    :error
  end
end
