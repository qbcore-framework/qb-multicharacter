fx_version 'cerulean'
game 'gta5'

description 'QB-Multicharacter'
version '1.0.0'

ui_page 'html/index.html'

shared_scripts {
    '@qb-core/import.lua',
    'config.lua',
    'locale.lua',
    'locales/*.lua'
}

client_script 'client/main.lua'
server_script 'server/main.lua'

files {
    'html/index.html',
    'html/style.css',
    'html/reset.css',
    'html/script.js'
}

dependencies {
    'qb-core',
    'qb-spawn'
}
