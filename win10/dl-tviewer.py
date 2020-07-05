# Import statments
from bs4 import BeautifulSoup
import urllib.request
import requests
import os
import sys

# Parse the webpage to be scraped
url = 'https://www.teamviewer.com/en/download/windows/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
version = soup.select('.wpb_text_column')[1].text.strip()[0:2]

# Download URL
download_url = 'https://dl.teamviewer.com/download/version_'+version+'x/TeamViewer_Setup.exe'

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading TeamViewer")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/teamviewer.exe")
