import Vue from 'vue'
import Router from 'vue-router'
import CurriculumVitae from '@/components/CurriculumVitae'
import BlogPost from '@/views/BlogPost'
import ErrorPage from '@/views/ErrorPage'

Vue.use(Router)

export default new Router({
  mode: 'history',
  routes: [
    {
      path: '/',
      name: 'CurriculumVitae',
      component: CurriculumVitae
    },
    {
      path: '/portfolio',
      name: 'CurriculumVitae',
      component: CurriculumVitae
    },
    {
      path: '/post',
      name: 'Post',
      component: BlogPost
    },
    {
      path: '*',
      name: 'Error 404',
      component: ErrorPage
    }
  ]
})
