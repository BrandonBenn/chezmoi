import theme

theme.load(c)
c.hints.uppercase = True
c.content.autoplay = False
c.fonts.default_family = ["FreeSans", "SF Pro"]
c.fonts.web.family.fixed = "JetBrains Mono"
c.content.blocking.method = "both"
c.content.blocking.adblock.lists = [ "https://hblock.molinero.dev/hosts_domains.txt" ]
c.statusbar.show = "in-mode"

c.url.searchengines = {
    "DEFAULT": "https://www.google.com/search?q={}",
}

config.bind('j', 'run-with-count 6 scroll down')
config.bind('k', 'run-with-count 6 scroll up')
config.bind('K', 'tab-next')
config.bind('J', 'tab-prev')
config.bind('m', 'spawn mpv {url}')
config.bind('M', 'hint links spawn --detach mpv {hint-url}')
config.load_autoconfig(True)
