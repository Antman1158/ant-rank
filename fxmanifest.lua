fx_version 'cerulean'
game 'gta5'

description 'Ant-Rank'
version '1.0.0'

shared_scripts {
    'config/*.lua',
    '@ox_lib/init.lua'
}

client_scripts {
    'client/*.lua'
}

dependencies {
    'ant-bridge'
}

lua54 'yes'