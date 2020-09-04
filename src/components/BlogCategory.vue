<template>
  <div>
    <ul class="list-group my-list">
      <li
      class="list-group-item"
      v-for="category in categories"
      :key="category.id">
        {{category.name}}
        <span style="float:right; color:#bfbfbf">></span>
      </li>
    </ul>
  </div>  
</template>

<script>
export default {
  props: ['categories']
}
</script>

<style scoped>
.my-list {
  text-align: left;
}
</style>
