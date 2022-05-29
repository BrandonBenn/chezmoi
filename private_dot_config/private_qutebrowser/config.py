import theme

c.hints.uppercase = True
c.content.autoplay = False
c.fonts.default_family = ["FreeSans", "SF Pro"]
c.fonts.web.family.fixed = "JetBrains Mono"
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [ "https://hblock.molinero.dev/hosts_domains.txt" ]
c.statusbar.show = "in-mode"

c.url.searchengines = {
    "DEFAULT": "https://searx.be/?q={}",
    "g": "https://www.google.com/search?q={}",
}

config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('m', 'spawn mpv {url}')
config.bind('M', 'hint links spawn --detach mpv {hint-url}')
config.load_autoconfig(True)
theme.load(c)
