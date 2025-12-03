defmodule Battery do
  def process(body) do
    IO.puts(Enum.map(String.split(body), &(find_joltage(&1))) |> Enum.sum())
  end

  def find_joltage(line) do
    values = String.split(line, "", trim: true)

    {digits, _final_remainder} =
      11..0//-1
      |> Enum.reduce({[], values}, fn position, {acc_digits, remainder} ->
        result = find_max_with_remainder(remainder, [max: 0, remainder: remainder], position)
        {[result[:max] | acc_digits], result[:remainder]}
      end)

    digits
    |> Enum.reverse()
    |> Enum.join()
    |> String.to_integer()
  end

  def find_max_with_remainder(list, max, need) do
    case length(tl(list)) do
      ^need ->
        cond do
          hd(list) > max[:max] -> [max: hd(list), remainder: tl(list)]
          true -> max
        end
      _ ->
        cond do
          hd(list) > max[:max] -> find_max_with_remainder(tl(list), [max: hd(list), remainder: tl(list)], need)
          true -> find_max_with_remainder(tl(list), max, need)
        end
    end
  end
end

args = System.argv()
if length(args) < 1 do
  exit("Need argument")
end

filename = hd(args)

case File.read("./#{filename}") do
  {:ok, body} -> Battery.process(body)
end
