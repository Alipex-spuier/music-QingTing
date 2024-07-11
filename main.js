import Vue from 'vue'
import App from './App'

const url = 'http://8.217.178.86'

Vue.config.productionTip = false

App.mpType = 'app'

Vue.prototype.$baseURL = url+':8080'; 
Vue.prototype.$baseFaceURL = url+':8084'; 
Vue.prototype.$basePhotoURL = url+':8081'; 
const app = new Vue({
    ...App
})
app.$mount()
