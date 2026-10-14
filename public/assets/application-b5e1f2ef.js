// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "trix"
import "@rails/actiontext"
import "jquery"

import "scripts/sidebar_collapse"
import "scripts/sidebar"


Rails.start()
ActiveStorage.start()
