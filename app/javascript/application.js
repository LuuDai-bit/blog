// Configure your import map in config/importmap.rb. Read more: https://github.com/rails/importmap-rails
import Rails from "@rails/ujs"
import * as ActiveStorage from "@rails/activestorage"
// import "channels"
// import "@fortawesome/fontawesome-free/css/all"
import "./controllers/index.js"
import "./scripts/theme.js"
import "./scripts/post.js"
import "./scripts/announcement.js"
import "./scripts/auto_save.js"
import "./scripts/password.js"
import "./scripts/sidebar.js"
import "./scripts/auth_token.js"
// import "./../assets/stylesheets/application"
import "trix"
import "@rails/actiontext"

import * as $ from "jquery"
window.$ = $
window.jQuery = $

Rails.start()
ActiveStorage.start()

require('jquery')
require("trix")
require("@rails/actiontext")

global.toastr = require("toastr");
window.bootstrap = require("bootstrap");
