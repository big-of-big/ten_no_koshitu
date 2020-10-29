<template>
  <div id="app">
    <p>期間を選択</p>
    <!-- <p>{{ message }}</p> -->
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <button @click="num += 1">決定</button>
    <pre> {{ num }} </pre>
    <pre> {{ start_date }} </pre>
    <pre> {{ end_date }} </pre>
    <pre> {{ name }} </pre>
    <pre> {{ $data }} </pre>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      // message: "Hello Vue!"
      num: 0,
      start_date: '',
      end_date: '',
      name: ''
    }
  },
  props: {
    tenhou_name: { type: String }
  },
  mounted: function (){
    this.name = this.tenhou_name
  }
}
</script>

<style scoped>
</style>
