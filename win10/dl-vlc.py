# Import statments
from bs4 import BeautifulSoup
import urllib.request
import requests
import os
import sys

# Parse the webpage to be scraped
url = 'https://www.videolan.org/vlc/download-windows.html'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', id="downloadVersion")
version = span_tag.text.strip()

# Download URL
download_url = 'https://get.videolan.org/vlc/'+version+'/win64/vlc-'+version+'-win64.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading VLC")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/vlc-x64.exe")
