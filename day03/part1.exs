defmodule Battery do
  def process(body) do
    IO.puts(Enum.map(String.split(body), &(find_joltage(&1))) |> Enum.sum())
  end

  def find_joltage(line) do
    values = String.split(line,"", trim: true)
    first = find_max_with_remainder(values, 0)
    first_index = Enum.find_index(values, &(&1 == first))
    {_, rem} = Enum.split(values, first_index + 1)
    second = Enum.max(rem)
    String.to_integer(first <> second)
  end

  def find_max_with_remainder(list, max) do
    case length(tl(list)) do
      0 -> max
      _ ->
        cond do
          hd(list) > max -> find_max_with_remainder(tl(list), hd(list))
          true -> find_max_with_remainder(tl(list), max)
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
