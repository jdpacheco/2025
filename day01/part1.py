import sys

def move(pos, thing):
    direction = thing[0]
    number = int(thing[1:-1])
    if direction == "L":
        pos = pos - number
    else:
        pos = pos + number
    pos = pos % 100
    return pos

def parse(content):
    pos = 50
    zeros = 0
    for x in content:
        pos = move(pos, x)
        if pos == 0:
            zeros = zeros + 1
    print(zeros)

args = sys.argv

try:
    with open(args[1], "r") as file:
        parse(file)
except FileNotFoundError:
    print(f"Error: The file {args[1]} was not found.")
except Exception as e:
    print(f"An error occurred: {e}")
