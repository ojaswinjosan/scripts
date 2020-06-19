from bs4 import BeautifulSoup
import urllib.request
import requests
import os

# Parse the webpage to be scraped
url = 'https://www.videolan.org/vlc/download-windows.html'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', id="downloadVersion")
version = span_tag.text.strip()

# Download URL
download_url = 'https://get.videolan.org/vlc/'+version+'/win64/vlc-'+version+'-win64.exe'
file_path = '/Users/'+os.getenv('username')+'/Downloads/temp/vlc-x64.exe'

# Start the download
urllib.request.urlretrieve(download_url, file_path)
