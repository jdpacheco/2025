defmodule Dial do
  def process(body) do
    starting_pos = 50
    lines = String.split(body)
    IO.puts(movelist(starting_pos, lines))
  end

  def movelist(pos, lines) do
    if length(lines) > 0 do
      pos = move(pos, hd(lines))
      zero = if pos == 0 do
        1
      else
        0
      end
      zero + movelist(pos, tl(lines))
    else
      0
    end
  end

  def move(pos, line) do
    {direction, str_value} = String.split_at(line, 1)
    value = String.to_integer(str_value)
    case direction do
      "L" -> Integer.mod(pos - value, 100)
      "R" -> Integer.mod(pos + value, 100)
    end
  end
end



args = System.argv()
if length(args) < 1 do
  exit("Need argument")
end

filename = hd(args)

case File.read("./#{filename}") do
  {:ok, body} -> Dial.process(body)
end
