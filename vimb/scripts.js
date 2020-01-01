

function injectDarkStyle () {
  console.log('injecting dark style...');

  var style = document.createElement('style');
  style.innerHTML = 'html { -webkit-filter: invert(95%) hue-rotate(180deg) !important; }'

  /* document.documentElement.appendChild(style); */

  var nodeList = document.querySelectorAll("p, a, span, code, pre");
  for (i = 0; i < nodeList.length; i++) {
    /* format: rgba(r, g, b) */
    var color = window.getComputedStyle(nodeList[i], null).getPropertyValue("color");
    var rgb = color.substring(4).match(/[0-9a-fA-F]+/g);
    if (rgb[0] < 30 && rgb[1] < 30 && rgb[2] < 30) {
      nodeList[i].appendChild(style);
    }
    else {
      console.log('already dark');
    } 
  }
}

// injectDarkStyle();
