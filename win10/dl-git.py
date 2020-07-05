# Import statments
from bs4 import BeautifulSoup
import urllib.request
import requests
import os
import sys

# Parse the webpage to be scraped
url = 'https://git-scm.com/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', class_='version')
version = span_tag.text.strip()

# Download URL
download_url = 'https://github.com/git-for-windows/git/releases/download/v'+version+'.windows.1/Git-'+version+'-64-bit.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading Git")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/git.exe")
