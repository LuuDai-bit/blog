// This file is automatically compiled by Webpack, along with any other files
// present in this directory. You're encouraged to place your actual application logic in
// a relevant structure within app/javascript and only use these pack files to reference
// that code so it'll be compiled.

import Rails from "@rails/ujs"
import Turbolinks from "turbolinks"
import * as ActiveStorage from "@rails/activestorage"
import "channels"
import "@fortawesome/fontawesome-free/css/all"
import "controllers"
import "../scripts/post.js"
import "../scripts/announcement.js"
import "../scripts/auto_save.js"
import "../scripts/password.js"
import "../../assets/stylesheets/application"

Rails.start()
Turbolinks.start()
ActiveStorage.start()

require('jquery')
require("trix")
require("@rails/actiontext")

global.toastr = require("toastr");
window.bootstrap = require("bootstrap");
