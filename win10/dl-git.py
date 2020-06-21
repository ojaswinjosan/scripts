from bs4 import BeautifulSoup
import urllib.request
import requests
import os

# Parse the webpage to be scraped
url = 'https://git-scm.com/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
span_tag = soup.find('span', class_='version')
version = span_tag.text.strip()

# Download URL
download_url = 'https://github.com/git-for-windows/git/releases/download/v'+version+'.windows.1/Git-'+version+'-64-bit.exe'
file_path = '/Users/'+os.getenv('username')+'/Downloads/temp/git.exe'

# Start the download
urllib.request.urlretrieve(download_url, file_path)
