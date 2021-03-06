import Vue from "vue";
import ElementUI from "element-ui";
import { Button, Select ,Form} from "element-ui";
import "element-ui/lib/theme-chalk/index.css";
import App from "./App.vue";
import router from "./router/index.js";
Vue.use(ElementUI);
Vue.config.productionTip = false;

Vue.component(Button.name, Button);
Vue.component(Select.name, Select);
Vue.component(Form.name, Form);
/* 或写为
 * Vue.use(Button)
 * Vue.use(Select)
 */

new Vue({
  render: (h) => h(App),
  router,
}).$mount("#app");
