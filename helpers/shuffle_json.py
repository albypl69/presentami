import json
import random
import sys

def shuffle_json(json_data):
    data = json.loads(json_data)
    random.shuffle(data)

    with open("shuffledData.json", "w") as file:
        json.dump(data, file, indent=4)

if __name__ == "__main__":
    shuffle_json(sys.argv[1])