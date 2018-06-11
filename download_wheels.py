#!/usr/bin/env python
from bs4 import BeautifulSoup
import os
import urllib.request
import shutil
import sys
import requests

VERSION = sys.argv[1]
WHEELS_DIR = "tmp"   # Directory where to store the wheels
WHEELS_WEBSITE = "http://dl.bintray.com:80/v1/content/bstellato/generic/osqp-wheels/%s" % VERSION

r  = requests.get(WHEELS_WEBSITE)
data = r.text
soup = BeautifulSoup(data, "html.parser")

print("Downloading wheels for version %s" % VERSION)


# Create directory where to store the wheels
print("Creating %s directory" % WHEELS_DIR)
if not os.path.exists(WHEELS_DIR):
    os.makedirs(WHEELS_DIR)
else:
    shutil.rmtree(WHEELS_DIR)
    os.makedirs(WHEELS_DIR)

# Go inside temporary directory
os.chdir(WHEELS_DIR)

# Download all the files
for link in soup.find_all('a'):
    file_name = link.get('href')[1:]
    print("Downliading ", file_name, "...", end='')
    urllib.request.urlretrieve(WHEELS_WEBSITE + "/" + file_name, file_name)
    print("[OK]")

# Go back to original directory and remove tmp/
os.chdir("..")
