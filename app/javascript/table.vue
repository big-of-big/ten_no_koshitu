<template>
  <tr>
    <td scope="row">
      <a :href="url"> {{ tenhou_name }} </a>
    </td>
    <td>{{ games_score(selected_four_games) }}</td>
    <td>{{ games_average_ranking(selected_four_games) }}</td>
    <td>{{ selected_four_games.length}}</td>
    <td>{{ games_score(selected_three_games) }}</td>
    <td>{{ games_average_ranking(selected_three_games) }}</td>
    <td>{{ selected_three_games.length}}</td>
  </tr>
</template>

<script>
export default {
  data: function () {
    return {
      start_date: '',
      end_date: '',
    }
  },
  props: {
    tenhou_name: { type: String },
    three_games_string: {type: String},
    four_games_string: {type: String},
    term: {type: Object},
    url: {type: String}
  },
  methods: {
    extract_tenhou_accounts_from: function(log) {
      let ary = log.split(' ')
      ary = ary.slice(6)
      let names = []
      for(const name_and_score of ary) {
        const m = name_and_score.match(/(?<name>.+)\(/)
        names.push(m.groups.name)
      }
      return names
    },
    // 得点の配列を返す関数
    scores: function(logs, tenhou_account_name){
      let ary = []
      let escaped_name = tenhou_account_name.replace(/[.*+?^=!:${}()|[\]\/\\]/g, '\\$&')
      let rg = new RegExp(escaped_name + '\\((?<score>.+?)\\)')
      for(const log of logs){
        const m = log.match(rg)
        const number = parseInt(m.groups.score, 10)
        ary.push(number)
      }
      return ary
    },
    // 順位の配列を返す関数
    rankings: function(logs, tenhou_account_name){
      let ary = []
      for(const log of logs){
        let tenhou_account_names = this.extract_tenhou_accounts_from(log)
        let ranking = tenhou_account_names.indexOf(tenhou_account_name) + 1
        ary.push(ranking)
      }
      return ary
    },
    games_score: function(games){
      let scores = this.scores(games, this.tenhou_name)
      if(scores.length > 0){
        return scores.reduce((sum,currentValue) => sum + currentValue)
      }
    },
    games_average_ranking: function(games){
      let rankings = this.rankings(games, this.tenhou_name)
      if(rankings.length > 0){
        let ranking_total = rankings.reduce((sum,currentValue) => sum + currentValue)
        return (Math.round(ranking_total / rankings.length * 100) / 100)
      }
    }
  },
  computed: {
    three_games: function() {
      return JSON.parse(this.three_games_string)
    },
    four_games: function() {
      return JSON.parse(this.four_games_string)
    },
    // ログが入った配列（他の情報はない）
    selected_three_games: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      let ary = []
      const three_games = this.three_games
      if(this.term.all === true){
        for(const three_game of three_games) {
          ary.push(three_game.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for(const three_game of three_games) {
          let date = new Date(three_game.date)
          if(date >= start && date <= end){
            ary.push(three_game.one_game_log)
          }
        }
      }
      return ary
    },
    selected_four_games: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      let ary = []
      const four_games = this.four_games
      if(this.term.all === true){
        for(const four_game of four_games) {
          ary.push(four_game.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for(const four_game of four_games) {
          let date = new Date(four_game.date)
          if(date >= start && date <= end){
            ary.push(four_game.one_game_log)
          }
        }
      }
      return ary
    }
  }
}
</script>

