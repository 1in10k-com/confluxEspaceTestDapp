import Vue from "vue";
import Router from "vue-router";
Vue.use(Router);
const routes = [
  {
    path: "/",
    component: () => import("../components/map.vue"),
  },
  { path: "/redcity", component: () => import("../components/redCity.vue") },
  {
    path: "/greencity",
    component: () => import("../components/greenCity.vue"),
  },
  {
    path: "/yellowcity",
    component: () => import("../components/yellowCity.vue"),
  },
  {
    path: "*",
    redirect: "/",
  },
];

const router = new Router({
  routes,
  mode: "hash",
});

export default router;
