defmodule Day1 do
  def part_one do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(fn c ->
      Regex.scan(~r/\d/, c, capture: :all)
    end)
    |> Enum.map(fn r ->
     first = List.first(r) |> List.first
     last = List.last(r) |> List.first
     first <> last |> String.to_integer
    end)
    |> Enum.sum
  end

  def part_two do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(fn c ->
      Regex.run(~r/(\d|one|two|three|four|five|six|seven|eight|nine).*(\d|one|two|three|four|five|six|seven|eight|nine)|(\d)/, c, capture: :all_but_first)
    end)
    |> Enum.map(fn r -> handle_match(r) end)
    |> Enum.sum
  end

  def handle_match(r) do
    case length(r) do
      2 ->
        first = List.first(r) |> number_to_int
        last = List.last(r) |> number_to_int
        first <> last |> String.to_integer
      3 ->
        num = Enum.at(r, 2) |> number_to_int
        num <> num |> String.to_integer
    end

  end

  def number_to_int(number) do
    numbers = %{
      "one" => 1,
      "two" => 2,
      "three" => 3,
      "four" => 4,
      "five" => 5,
      "six" => 6,
      "seven" => 7,
      "eight" => 8,
      "nine" => 9,
    }

    case Integer.parse(number) do
      {int, _} -> int |> to_string
      :error -> Map.fetch!(numbers, number) |> to_string
    end
  end
end
