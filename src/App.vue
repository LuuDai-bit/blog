<template>
  <div id="app">
    <HeaderComponent></HeaderComponent>
    <CurriculumVitae></CurriculumVitae>
    <FooterComponent></FooterComponent>
  </div>
</template>

<script>
import CurriculumVitae from './components/CurriculumVitae'
import HeaderComponent from './components/HeaderComponent'
import FooterComponent from './components/FooterComponent'
export default {
  name: 'App',
  components: {
    CurriculumVitae,
    HeaderComponent,
    FooterComponent
  }
}
</script>

<style>
#app {
  font-family: Avenir, Helvetica, Arial, sans-serif !important;
  -webkit-font-smoothing: antialiased !important;
  -moz-osx-font-smoothing: grayscale !important;
  text-align: center !important;
  color: #2c3e50 !important;
}
</style>
