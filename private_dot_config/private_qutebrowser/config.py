from os import uname

SEARCH_ENGINES = {
    'DEFAULT': 'https://google.com/search?q={}',
    'aw': 'https://wiki.archlinux.org/?search={}'
}

config.load_autoconfig(True)
c.hints.uppercase = True
c.content.autoplay = False
c.content.blocking.method = 'adblock'
c.fonts.default_family = 'FreeSans'
c.url.searchengines = SEARCH_ENGINES
config.bind('m', 'spawn mpv {url}')
config.bind('M', 'hint links spawn mpv {hint-url}')

if uname().nodename == 'tammy':
    c.fonts.default_size = '16pt'
    c.zoom.default = '150%'
