document.addEventListener('turbolinks:load', () => {
  const themes = {
    yellow_pink: {
      "--primary-color": "#B07548",
      "--btn-bg-color": "#eca1a6",
      "--btn-text-color": "#664227",
      "--btn-hover-bg-color": "#d49296",
      "--background-color": "#e1cdb4",
      "--main-bg-color": "#fff4f4",
      "--sidebar-bg-color": "#f9dfc1",
      "--fc-bg-color": "#e1cdb4",
      "--tb-head-th-bg-color": "#BFA48F",
      "--title-text-color": "#B07548",
      "--breadcrumb-text-color": "#B07548"
    }
  };

  const THEME_NAMES = ["--btn-bg-color", "--btn-text-color",
                       "--btn-hover-bg-color", "--background-color",
                       "--main-bg-color", "--sidebar-bg-color",
                       "--fc-bg-color", "--tb-head-th-bg-color",
                       "--title-text-color", "--breadcrumb-text-color",
                      "--primary-color"];

  function applyTheme(themeName) {
    if (themeName != "default") {
      const theme = themes[themeName];
      THEME_NAMES.forEach( (name) => {
        document.documentElement.style.setProperty(name, theme[name]);
      });
    }
  }

  // load saved theme
  const pageTheme = document.getElementById("page-theme").value || "default";

  applyTheme(pageTheme);
})
