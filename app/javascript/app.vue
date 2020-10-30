<template>
  <div id="app">
    <p>期間を選択</p>
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <p>4人打ち</p>
    <p>3人打ち</p>
    <pre> {{ $data }} </pre>
    <!-- <pre> {{ tenhou_name }} </pre> -->
    <!-- {{ selected_four_games}} -->
    <!-- {{ selected_three_games}} -->
    <!-- <ul> -->
      <!-- <li v&#45;for="four_game in JSON.parse(four_games)" > -->
        <!-- {{ set(one_month_game.four_games) }} -->
        <!-- {{ four_game }} -->
        <!-- {{ set_four_games(four_game) }} -->
      <!-- </li> -->
    <!-- </ul> -->
    <ul>
      <li v-for="three_game in selected_three_games" >
        <!-- {{ set(one_month_game.four_games) }} -->
        {{ three_game }}
        {{ display(three_game)}}
      </li>
    </ul>
  </div>
</template>

<script>
export default {
  data: function () {
    return {
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
    one_month_games: {type: String},
    three_games_string: {type: String},
    four_games: {type: String}
  },
  methods: {
    display: function(game) {
      let log = game.one_game_log
      this.extract_tenhou_accounts_from(log)
    },
    extract_tenhou_accounts_from: function(log) {
      let ary = log.split(' ')
      ary = ary.slice(6)
      let names = []
      for(const name_and_score of ary) {
        const m = name_and_score.match(/(?<name>.+)\(/)
        names.push(m.groups.name)
      }
      return names
    }
  },
  computed: {
    three_games: function() {
      return JSON.parse(this.three_games_string)
    },
    selected_three_games: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される

      const start = new Date(this.start_date)
      const end = new Date(this.end_date)
      const three_games = this.three_games
      let ary = []
      for(const three_game of three_games) {
        let date = new Date(three_game.date)
        if(date >= start && date <= end){
          ary.push(three_game)
        }
      }
      // alert(end)
      return ary
    }
  }
}
</script>

<style scoped>
</style>
