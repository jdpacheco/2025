defmodule ProductCodes do
  def process(body) do
    ranges = String.split(body, ",")
    IO.puts(find_bad(ranges))
  end

  def find_bad(ranges) do
    if length(ranges) == 0 do
      0
    else
      range_bad(String.split(hd(ranges), "-")) + find_bad(tl(ranges))
    end
  end

  def range_bad(range) do
    first = hd(range)
    second = hd(tl(range))
    if first == second do
      has_doubles(first)
    else
      next_first = Integer.to_string(String.to_integer(first)+1)
      has_doubles(first) + range_bad([next_first, second])
    end
  end

  def has_doubles(number_string) do
    if String.match?(number_string, ~r/^([0-9]+)\1$/) do
      IO.puts(number_string)
      String.to_integer(number_string)
    else
      0
    end
  end
end

args = System.argv()
if length(args) < 1 do
  exit("Need argument")
end

filename = hd(args)

case File.read("./#{filename}") do
  {:ok, body} -> ProductCodes.process(body)
end
