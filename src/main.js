import 'bootstrap/dist/css/bootstrap.min.css'
import Vue from 'vue'
import App from './App.vue'
import router from '@/router/index.js'
import store from '@/store/index.js'
import { library, dom } from '@fortawesome/fontawesome-svg-core'
import { faUser } from '@fortawesome/free-solid-svg-icons'
import { FontAwesomeIcon } from '@fortawesome/vue-fontawesome'

library.add(faUser)
Vue.component('font-awesome-icon', FontAwesomeIcon)
Vue.config.productionTip = false
dom.watch()

new Vue({
  store,
  router,
  render: h => h(App),
}).$mount('#app')
