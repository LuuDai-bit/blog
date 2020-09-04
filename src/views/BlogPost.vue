<template>
  <div class="post-container">
    <div class="cate-list">
      <BlogCategory :categories="categories"/>
    </div>
    <div class="post-list">
      <div v-for="post in posts" :key="post.id" class="card">
        <BlogPostItem :post="post"/>
      </div>
      <PaginationComponent/>
    </div>
  </div>
</template>

<script>
import posts from '@/data/post.js'
import categories from '@/data/categories.js'
import BlogPostItem from '@/components/BlogPostItem'
import BlogCategory from '@/components/BlogCategory'
import PaginationComponent from '@/components/PaginationComponent'

export default {
  components: {
    BlogPostItem,
    BlogCategory,
    PaginationComponent
  },
  data() {
    return {
      posts: [],
      categories: []
    }
  },
  created() {
    this.posts = posts
    this.categories = categories
  }
}
</script>

<style scoped>
.card {
  display: block;
  width: 90%;
  height: 140px;
  text-align: left;
  margin: 10px auto;
  position: relative;
}
.card:hover {
  -webkit-box-shadow: 1px 1px 3px 4px rgb(175, 170, 170) !important;  /* Safari 3-4, iOS 4.0.2 - 4.2, Android 2.3+ */
  -moz-box-shadow:    1px 1px 3px 4px rgb(158, 156, 156) !important;  /* Firefox 3.5 - 3.6 */
  box-shadow:         1px 1px 3px 4px rgb(158, 156, 156) !important;  /* Opera 10.5, IE 9, Firefox 4+, Chrome 6+, iOS 5 */
}
.cate-list {
  margin-top: 10px;
  width: 30%;
  float: left;
}
.post-list {
  width: 70%;
  float: left;
}
</style>
