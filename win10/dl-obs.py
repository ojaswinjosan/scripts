# Import statments
from bs4 import BeautifulSoup
import urllib.request
import requests
import os
import sys

# Parse the webpage to be scraped
url = 'https://obsproject.com/download'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', class_="dl_ver")
version = span_tag.text[9:]

# Download URL
download_url = 'https://cdn-fastly.obsproject.com/downloads/OBS-Studio-'+version+'-Full-Installer-x64.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading OBS Studio")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/obs.exe")
