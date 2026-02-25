fx_version 'cerulean'
game 'gta5'

name "wz-methlab"
description "Portable meth cooking"
author "Whitezom"
version "1.0"

shared_scripts {
	'@ox_lib/init.lua',
	'shared/*.lua'
}

client_scripts {
	'client/*.lua'
}

server_scripts {
	'server/*.lua'
}

dependencies {
    'ox_lib',
    'ox_inventory',
}
