<template>
  <div id="app">
    <p>期間を選択</p>
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <button @click="display()">決定</button>
    <pre> {{ $data }} </pre>
    <pre> {{ tenhou_name }} </pre>
    <pre> {{ one_month_games }} </pre>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      num: 0,
      start_date: '',
      end_date: ''
    }
  },
  props: {
    tenhou_name: { type: String, },
    one_month_games: {type: Object}
  },
  methods: {
    display: function () {
      alert(this.start_date)
      alert(this.end_date)
    }
  }
}
</script>

<style scoped>
</style>
