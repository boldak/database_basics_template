from selenium import webdriver


def get_urls(request):
    path = r'Chromedriver'
    browser = webdriver.Chrome(executable_path=path)

    browser.get('https://www.bing.com/search?q=' + str(request))
    text = browser.find_element_by_xpath('/html/body').text
    urls = list(filter(lambda el: el.startswith('https') and not el.endswith('.'), text.split('\n')))

    return urls


def clear_text(text):  # Функція для очистки тексту
    text = ' '.join([el for el in text.split() if el])  # Видалення пробілів
    text = ' '.join([el for el in text.split('\n') if el])  # Видалення \n
    return text


def download_url_text(url):  # Функція для завантаження тексту із сайту
    import requests  # Бібліотека для завантаження коду сайту
    import bs4  # Бібліотека для коректного перетворення коду сайту в рядок Python
    url = requests.get(url)  # Отримання коду
    b = bs4.BeautifulSoup(url.text, "html.parser")  # Перетворення коду
    return b.get_text()  # Очистка і повернення тексту


def get_text(request):
    res = list()
    for url in get_urls(request):
        res.append(download_url_text(url))