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

# Pick the tag that contains the version number
for anchor in anchor_list:
        version_string = str(anchor[2])

# Get the version number
version_begin = version_string.find('Version ')
version_end = version_string.find('</strong>')
version_number = version_string[version_begin + 8: version_end]

# Download URL
download_url = 'https://github.com/notepad-plus-plus/notepad-plus-plus/releases/download/v'+version_number+'/npp.'+version_number+'.Installer.x64.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading Notepad++")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/npp.exe")
