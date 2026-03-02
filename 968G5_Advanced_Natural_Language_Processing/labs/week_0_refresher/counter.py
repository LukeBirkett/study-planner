import sys
import nltk
nltk.download('punkt', quiet=True)

from nltk.tokenize import word_tokenize

def count_stats(filepath):
    lines = 0
    words = 0
    chars = 0

    try:
        with open(filepath, 'r') as file:
            for line in file:
                lines+=1
                line = word_tokenize(line)
                for word in line:
                    words+=1
                    for char in word:
                        chars+=1
                    
        print(f"Number of lines: {lines}")
        print(f"Number of words: {words}")
        print(f"Number of characters: {chars}")

    except FileNotFoundError:
        print(f"Error: The file '{filepath}' was not found.")

if __name__ == "__main__":
        count_stats(sys.argv[1])