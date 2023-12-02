defmodule Day2 do
  @part_one_restrictions %{
    "red" => 12,
    "green" => 13,
    "blue" => 14
  }

  def part_one do
    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(fn l -> Regex.run(~r/Game (\d+): (.*)/, l, capture: :all_but_first) end)
    |> Enum.reduce(0, fn [game_id, sets] , sum ->
      cases =
        Regex.scan(~r/(\d+ (?:red|green|blue))/, sets, capture: :all_but_first)
        |> Enum.map(fn s -> is_possible?(s, @part_one_restrictions) end)

      case Enum.all?(cases) do
        true -> (game_id |> String.to_integer) + sum
        false -> sum
      end
    end)
  end

  def is_possible?([s], limits) do
    [amount, color] = String.split(s)
    amount |> String.to_integer <= limits[color]
  end

  def part_two do
    # %{red: 0, green: 0, blue: 0},

    File.read!("input.txt")
    |> String.split("\n")
    |> Enum.map(fn l -> Regex.run(~r/Game (\d+): (.*)/, l, capture: :all_but_first) end)
    |> Enum.map(fn [_game_id, sets] ->
      Regex.scan(~r/(\d+ (?:red|green|blue))/, sets, capture: :all_but_first)
      |> Enum.reduce(%{"red" => 0, "green" => 0, "blue" => 0}, fn [s], min ->
        [sAmount, color] = String.split(s)
        amount = sAmount |> String.to_integer

        case amount > min[color] do
          true -> min |> Map.put(color, amount)
          false -> min
        end
      end)
      |> Enum.reduce(1, fn {_color, amount}, power -> power * amount end)
    end)
    |> Enum.sum
  end
end
