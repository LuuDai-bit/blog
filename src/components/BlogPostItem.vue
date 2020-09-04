<template>
  <div>
    <div class="img">
      <router-link 
      :to="{
        path: '/posts/detail/}', 
        query: { id: post.id }
        }" 
      tag="img" 
      :src="require(`@/assets/${post.imgUrl}`)" 
      alt="post image"></router-link>
    </div>
    <div class="content">
      <div>
        <router-link
        :to="{
          path: '/posts/detail/}', 
          query: { id: post.id } 
          }">
          <h3>{{post.title}}</h3>
        </router-link>
        <p>{{post.content}}</p>
      </div>
      <div class="additionalInfo">
        <i class="fas fa-eye"></i><span>{{post.view}} &nbsp;</span>
        <i class="fas fa-user"></i><span>{{post.author}}</span>
      </div>
    </div>
  </div>
</template>

<script>

import { library } from '@fortawesome/fontawesome-svg-core'
import { faEye } from '@fortawesome/free-solid-svg-icons'

library.add(faEye)
export default {
  props: ['post'],
  data() {
    return {
    }
  }
}
</script>

<style scoped>
.img {
  float: left;
  width: 20%;
  margin-right: 1%;
}
.img > img {
  width: 100%;
  height: 140px;
}
.content {
  float: left;
  width: 79%;
}
.additionalInfo {
  position: absolute;
  bottom: 0;
}
</style>
