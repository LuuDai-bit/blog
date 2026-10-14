// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
import "trix"
import "@rails/actiontext"
import "jquery"

import "scripts/announcement"
import "scripts/auth_token"
import "scripts/auto_save"
import "scripts/highlight_categories"
import "scripts/password"
import "scripts/post"
import "scripts/sidebar_collapse"
import "scripts/sidebar"
import "scripts/theme"
import "scripts/feed"

Rails.start()
ActiveStorage.start()
