# Import statments
from bs4 import BeautifulSoup
import urllib.request
import os
import sys

# Parse the webpage to be scraped
url = 'https://sourceforge.net/projects/sevenzip/rss?path=/7-Zip'
response = urllib.request.urlopen(url)
content = response.read()
soup = BeautifulSoup(content,'xml')

# Store all title tags in a list
title_list = [soup.find_all('title')]

# Get name of the latest exe
for title in title_list:
        file = str(title[2])[20:34]

# Download URL
download_url = 'https://www.7-zip.org/a/'+file

# File path
if (len(sys.argv)<2):
   file_path = sys.path[0]
   print ("Downloading 7-Zip")
else:
    file_path = sys.argv[1]

# Start the download
urllib.request.urlretrieve(download_url, file_path + "/7zip.exe")
