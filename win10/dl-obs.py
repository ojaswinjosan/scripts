from bs4 import BeautifulSoup
import urllib.request
import requests
import os

# Parse the webpage to be scraped
url = 'https://obsproject.com/download'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', class_="dl_ver")
version = span_tag.text[9:]

# Download URL
download_url = 'https://cdn-fastly.obsproject.com/downloads/OBS-Studio-'+version+'-Full-Installer-x64.exe'
file_path = '/Users/'+os.getenv('username')+'/Downloads/temp/obs.exe'

# Start the download
urllib.request.urlretrieve(download_url, file_path)
