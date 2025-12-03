defmodule Dial do
  def process(body) do
    starting_pos = 50
    lines = String.split(body)
    tracker = [pos: starting_pos, crosses: 0]
    IO.inspect(movelist(tracker, lines))
  end

  def movelist(tracker, lines) do
    case length(lines) do
      0 -> tracker
      _ -> movelist(move(tracker, hd(lines)), tl(lines))
    end
  end

  def move(tracker, line) do
    {direction, str_value} = String.split_at(line, 1)
    value = String.to_integer(str_value)
    pos = tracker[:pos]
    crosses = case pos do
      0 -> tracker[:crosses] - 1 # Corrects for starting at zero
      _ -> tracker[:crosses]
    end
    step([pos: pos, crosses: crosses], direction, value)
  end

  def step(tracker, direction, remain) do
    pos = tracker[:pos]
    real_pos = case pos do
      -1 -> 99
      100 -> 0
      _ -> pos
    end
    crosses = case real_pos do
      0 -> 1
      _ -> 0
    end
    case remain do
      0 -> [pos: real_pos, crosses: tracker[:crosses] + crosses]
      _ -> case direction do
        "L" -> step([pos: real_pos - 1, crosses: tracker[:crosses] + crosses], direction, remain - 1)
        "R" -> step([pos: real_pos + 1, crosses: tracker[:crosses] + crosses], direction, remain - 1)
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
  {:ok, body} -> Dial.process(body)
end
