from bs4 import BeautifulSoup
import urllib.request
import requests
import os

# Parse the webpage to be scraped
url = 'https://www.teamviewer.com/en/download/windows/'
response = requests.get(url)
soup = BeautifulSoup(response.text, "html.parser")

# Get the span tag with the latest version number
version = soup.select('.wpb_text_column')[1].text.strip()[0:2]

# Download URL
download_url = 'https://dl.teamviewer.com/download/version_'+version+'x/TeamViewer_Setup.exe'
file_path = '/Users/'+os.getenv('username')+'/Downloads/temp/teamviewer.exe'

# Start the download
urllib.request.urlretrieve(download_url, file_path)
