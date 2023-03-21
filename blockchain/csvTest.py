# Hash a CSV file

# Python program to find SHA256 hash string of a file
import hashlib

file_name = 'grades.csv'


with open(file_name) as f:
    data = f.read()
    sha256hash = hashlib.sha256(data.encode('utf-8')).hexdigest()
    
print(sha256hash)