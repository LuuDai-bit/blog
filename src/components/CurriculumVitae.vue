<template>
  <div id='cv' class="shadow">
    <div id="mycv">
      <div class="header">
        <div class='img'>
          <img src="@/assets/ava.png" alt='my avatar' style="margin: 5px">
        </div>
        <div class="space"></div>
        <div class='general-info'>
          <h3><i class="fa fa-user" aria-hidden="true"></i> {{user.name}}</h3>
          <h3><i class="fa fa-address-book" aria-hidden="true"></i> {{user.address}}</h3>
          <h3><i class="fa fa-mobile" aria-hidden="true"></i> {{user.phone}}</h3>
          <h3><i class="fa fa-envelope" aria-hidden="true"></i> {{user.email}}</h3>
        </div>
      </div>
      <div class="body">
        <div class='objective'>
          <h1>Objective</h1>
          <hr>
          <p>{{user.objective}}</p>
        </div>
        <div class='education'>
          <h1>Education</h1>
          <hr>
          <ul>
            <li>Date of graduation: {{user.education.dateGraduation}}</li>
            <li>University: {{user.education.university}}</li>
            <li>Major: {{user.education.major}}</li>
            <li>gpa: {{user.education.gpa}}</li>
          </ul>
        </div>
        <div class='working-experience'>
          <h1>Working Experience</h1>
          <hr>
          <ul>
            <li v-for="we in user.workingExperiences" :key="we.duties">
              <p>
                <span>{{we.position}}</span>
                <span><b> {{we.company}}</b></span>
              </p>
              <p>Duties: {{we.duties}}</p>
            </li>
          </ul>
        </div>
        <div class='skills'>
          <h1>Skills</h1>
          <hr>
          <ul>
            <li>
              <p>Technical skills:</p>
              <p v-for="ts in user.tech_skills" :key="ts.type">
                <span>{{ts.type | capitalize}}: </span>
                <span>{{ts.name}}</span>
              </p>
            </li>
            <li>
              <p>Soft skills: </p>
              <p v-for="ss in user.soft_skills" :key="ss">{{ss}}</p>
            </li>
          </ul>
        </div>
        <div class='projects'>
          <h1>Project</h1>
          <hr>
          <ul>
            <li v-for="project in user.projects" :key="project.name">
              {{project.name}}
              <ul>
                <li>Duration: {{project.duration}}</li>
                <li>Team size: {{project.team_size}}</li>
                <li>Language: {{project.language}}</li>
                <li>Framework: {{project.framework}}</li>
                <li>Database: {{project.database}}</li>
                <li>Function: {{project.function}}</li>
                <li>Github: {{project.github}}</li>
              </ul>
            </li>
          </ul>
        </div>
        <div class='awards-honor'>
          <h1>Awards and honors</h1>
          <hr>
          <ul>
            <li v-for="aah in user.awards_honors" :key="aah">{{aah}}</li>
          </ul>
        </div>
        <div class='additional-info'>
          <h1>Additional Infomation</h1>
          <hr>
          <ul>
            <li v-for="info in user.additional_info" :key="info.type">
              <p>{{info.type}}: {{info.description}}</p>
            </li>
          </ul>
        </div>
        <br>
      </div>
    </div>
    <div class="button">
      <button type="button" class="" @click="exportPdf()">Export pdf</button>
    </div>
  </div>
</template>

<script>
import { jsPDF } from "jspdf";
import html2canvas from 'html2canvas'
import user from '@/cv.js'
import { library } from '@fortawesome/fontawesome-svg-core'
import { faAddressBook, faUser, faMobile, faEnvelope } from '@fortawesome/free-solid-svg-icons'

library.add(faAddressBook, faUser, faMobile, faEnvelope)
export default {
  data () {
    return {
      user: {}
    }
  },
  created () {
    this.user = user
  },
  methods: {
    exportPdf () {
      const filename = "LuuXuanDai_cv.pdf"
      const html = document.getElementById('mycv')
      html2canvas(html, { scale: 1 }).then(canvas => {
        let pdf = new jsPDF('p', 'mm', 'a4')
        pdf.addImage(canvas.toDataURL('image/png'), 'PNG', 0, 0, 210, 297)
        console.log('banza')
        pdf.save(filename)
      })
    }
  },
  filters: {
    capitalize: function (value) {
      if (!value) return ''
      value = value.toString()
      return value.charAt(0).toUpperCase() + value.slice(1)
    }
  }
}
</script>

<style scoped>
#cv {
  width: 80%  !important;
  margin: 0 auto !important;
  text-align: left !important;
  background-color: #B9F2FF !important;
}
.shadow {
  -webkit-box-shadow: 3px 3px 5px 6px rgb(158, 156, 156) !important;  /* Safari 3-4, iOS 4.0.2 - 4.2, Android 2.3+ */
  -moz-box-shadow:    3px 3px 5px 6px rgb(158, 156, 156) !important;  /* Firefox 3.5 - 3.6 */
  box-shadow:         3px 3px 5px 6px rgb(158, 156, 156) !important;  /* Opera 10.5, IE 9, Firefox 4+, Chrome 6+, iOS 5 */
}
h1 {
  color: #0f52ba !important;
  z-index: 1 !important;
  margin-bottom: 0 !important;
  margin-top: 1rem;
}
.header {
  color: white;
  /* background-color: #143b77; */
  background-image: url('../assets/ho_guom.gif');
  /* filter: blur(8px);
  -webkit-filter: blur(8px); */
  background-position: center;
  background-repeat: no-repeat;
  background-size: cover;
  display: inline-flex;
  width: 100%;
}
.body {
  width: 90%;
  margin: 0 auto;
}
.img {
  width: 20%;
  display: inline-block;
  text-align: center;
  margin-left: 20px;
  margin-top: 5px;
}
.space {
  width: 40%;
}
.general-info {
  width: 40%;
  display: inline-block;
  margin-top: 10px;
}
.img img {
  width: 200px;
  height: 200px;
}
hr {
  margin-top: 0;
  color: black;
}
</style>
