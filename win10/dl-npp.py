# Import statments
from bs4 import BeautifulSoup
import urllib.request
import requests
import os
import sys

# Parse the webpage to be scraped
url = 'https://notepad-plus-plus.org/downloads/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Store all anchor tags in a list
anchor_list = [soup.findAll('a', href=True)]

# Get the latest version number
for anchor in anchor_list:
        version = str(anchor[2])[21:26]

# Download URL
download_url = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v'+version+'/npp.'+version+'.Installer.x64.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading Notepad++")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/npp.exe")
