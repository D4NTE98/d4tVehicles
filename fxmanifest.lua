fx_version 'cerulean'
game 'gta5'

name 'd4tVehicles'
author 'D4NTE'
description 'Vehicle ownership, garage, keys and state system for d4tCore'
version '1.0.0'
lua54 'yes'

ui_page 'web/index.html'

shared_scripts {
    'shared/config.lua',
    'shared/garages.lua',
    'shared/modules/*.lua'
}

client_scripts {
    'client/modules/*.lua'
}

server_scripts {
    'server/modules/*.lua'
}

files {
    'web/index.html',
    'web/preview.html',
    'web/style.css',
    'web/app.js'
}

dependencies {
    'd4tCore',
    'd4tConnection',
    'd4tData',
    'd4tInventory'
}
