<template>
  <div>
    <span>期間を選択</span>
    <input type="date" v-model="start_date">
    <span>〜</span>
    <input type="date" v-model="end_date">
    <p>
      4人打ち
      得点:{{ games_score(selected_four_games) }}
      平均順位:{{ games_average_ranking(selected_four_games) }}
      対戦数:{{ selected_four_games.length}}
    </p>
    <p>
      3人打ち
      得点:{{ games_score(selected_three_games) }}
      平均順位:{{ games_average_ranking(selected_three_games) }}
      対戦数:{{ selected_three_games.length}}
    </p>
  </div>
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
    tenhouName: { type: String },
    threeGamesString: {type: String},
    fourGamesString: {type: String}
  },
  methods: {
    extract_tenhou_accounts_from: function(log) {
      let ary = log.split(' ')
      ary = ary.slice(6)
      let names = []
      for(const name_and_score of ary) {
        const m = name_and_score.match(/(?<name>.+)\((?<score>[+-]?[\d\.]+)/)
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
      let scores = this.scores(games, this.tenhouName)
      if(scores.length > 0){
        return scores.reduce((sum,currentValue) => sum + currentValue)
      }
    },
    games_average_ranking: function(games){
      let rankings = this.rankings(games, this.tenhouName)
      if(rankings.length > 0){
        let ranking_total = rankings.reduce((sum,currentValue) => sum + currentValue)
        return (Math.round(ranking_total / rankings.length * 100) / 100)
      }
    }
  },
  computed: {
    three_games: function() {
      return JSON.parse(this.threeGamesString)
    },
    four_games: function() {
      return JSON.parse(this.fourGamesString)
    },
    // ログが入った配列（他の情報はない）
    selected_three_games: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される

      const start = new Date(this.start_date)
      const end = new Date(this.end_date)
      const three_games = this.three_games
      let ary = []
      for(const three_game of three_games) {
        let date = new Date(three_game.date)
        if(date >= start && date <= end){
          ary.push(three_game.one_game_log)
        }
      }
      return ary
    },
    selected_four_games: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される

      const start = new Date(this.start_date)
      const end = new Date(this.end_date)
      const four_games = this.four_games
      let ary = []
      for(const four_game of four_games) {
        let date = new Date(four_game.date)
        if(date >= start && date <= end){
          ary.push(four_game.one_game_log)
        }
      }
      return ary
    }
  }
}
</script>

<style scoped>
</style>
