import Vue from 'vue'
import Router from 'vue-router'
import App from '@/App'
import BlogPost from '@/views/BlogPost'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'App',
      component: App
    },
    {
      path: '/post',
      name: 'Post',
      component: BlogPost
    },
    // {
    //   path: '*',
    //   naem: 'Error 404',
    //   component: ErrorPageComponent
    // }
  ]
})
