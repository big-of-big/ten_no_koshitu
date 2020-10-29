<template>
  <div id="app">
    <p>期間を選択</p>
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <button @click="display()">決定</button>
    <pre> {{ $data }} </pre>
    <pre> {{ tenhou_name }} </pre>
    <ul>
      <li v-for="one_month_game in JSON.parse(one_month_games)" :key="one_month_game.name">
        {{ set(one_month_game.four_games) }}
        {{ one_month_game }}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
      num: 0,
      start_date: '',
      end_date: '',
      four_games_scores: '',
      four_games_rankings: '',
      three_games_scores: '',
      three_games_rankings: ''
    }
  },
  props: {
    tenhou_name: { type: String },
    one_month_games: {type: String}
  },
  methods: {
    display: function () {
      alert(this.start_date)
      alert(this.end_date)
    },
    set: function(value) {
      this.four_games_scores = value
    }
  }
}
</script>

<style scoped>
</style>
