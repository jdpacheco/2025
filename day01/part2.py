import sys

class Dial:
    def __init__(self):
        self.pos = 50
        self.zeros = 0

    def move(self, instruction):
        direction = instruction[0]
        number = int(instruction[1:])
        for x in range(1, number + 1):
            if direction == "L":
                self.pos = self.pos - 1
            else:
                self.pos = self.pos + 1
            if self.pos == -1:
                self.pos = 99
            if self.pos == 100:
                self.pos = 0
            if self.pos == 0:
                self.zeros += 1
        

def parse(content):
    dial = Dial()
    for x in content:
        dial.move(x.strip())
    print(dial.zeros)

args = sys.argv

try:
    with open(args[1], "r") as file:
        parse(file)
except FileNotFoundError:
    print(f"Error: The file {args[1]} was not found.")
except Exception as e:
    print(f"An error occurred: {e}")
