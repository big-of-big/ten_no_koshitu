<template>
  <div id="app">
    <p>期間を選択</p>
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <button @click="num += 1">決定</button>
    <pre> {{ $data }} </pre>
    <pre> {{ tenhou_name }} </pre>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      num: 0,
      start_date: '',
      end_date: '',
    }
  },
  props: {
    tenhou_name: { type: String }
  }
}
</script>

<style scoped>
</style>
