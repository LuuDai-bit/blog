let user = {
  name: 'Lưu Xuân Đại',
  address: 'Cau Giay, Ha Noi',
  phone: '+84 347336981',
  email: 'dailx087@gmail.com',
  img: 'ava',
  objective: 'I’m seeking for Ruby Web internship. My short term goal is to become a junior Ruby Web engineer after 3 to 6 months working as a trainee. In the long term, my goal is to become a senior Ruby Web engineer.',
  education: {
    dateGraduation: '12/2020',
    university: 'Thuy Loi University',
    major: 'Infomation Techonology',
    gpa: 2.94
  },
  workingExperiences: [
    {
      position: 'Front-end Internship',
      company: 'Fsoft',
      duties: 'Learn how to use HTML, CSS, Javascript, Angular 6.'
    },
    {
      position: 'Java Web Internship',
      company: '2NF Software',
      duties: 'Learn SpringMVC and use it to create a pet project.'
    }
  ],
  tech_skills: [
    { name: 'SQLServer, PostgreSQL', type: 'database' },
    { name: 'Visual studio code, Intellij', type: 'tools' },
    { name: 'Basic knowledge of SpringMVC, basic knowledge of Vuejs', type: 'framework' }
  ],
  soft_skills: [
    'Self-learning',
    'Teamwork'
  ],
  projects: [
    {
      name: 'Estate Management', 
      duration: '1 month', 
      team_size: 1, 
      language: 'Java, Javascript',
      framework: 'SpringMVC, JSP, Bootstrap, Jquery',
      database: 'PostgreSQL',
      function: 'Add, Edit, Delete, Paging, ExportCSV',
      github: 'https://github.com/LuuDai-bit/2nf.project'
    }
  ],
  awards_honors: [
    'Fsoft code war intership 2019 #23 (Individual round)'
  ],
  additional_info: [
    { type: 'interest', description: 'Readbook, watch youtube(toidicodedao, Khanh Hung), listen to music' }
  ]
}
export default user
