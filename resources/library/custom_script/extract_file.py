from bs4 import BeautifulSoup

def extract_file_html(html_string):
    soup = BeautifulSoup(html_string, "html.parser")
    html_text = soup.get_text()
    return    html_text