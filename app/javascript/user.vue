<template>
  <tr>
    <td scope="row">
      <a :href="url"> {{ tenhouName }} </a>
    </td>
    <td>{{ displayScore(selectedFourGames) }}</td>
    <td>{{ averageRanking(selectedFourGames) }}</td>
    <td>{{ selectedFourGames.length}}</td>
    <td>{{ displayScore(selectedThreeGames) }}</td>
    <td>{{ averageRanking(selectedThreeGames) }}</td>
    <td>{{ selectedThreeGames.length}}</td>
  </tr>
</template>

<script>
export default {
  props: {
    tenhouName: { type: String },
    threeGamesString: {type: String},
    fourGamesString: {type: String},
    term: {type: Object},
    url: {type: String}
  },
  methods: {
    extractTenhouAccountsFrom: function(log) {
      let ary = log.split(' ')
      ary = ary.slice(6)
      let names = []
      for(const nameAndScore of ary) {
        const m = nameAndScore.match(/(?<name>.+)\((?<score>[+-]?[\d\.]+)/)
        names.push(m.groups.name)
      }
      return names
    },
    // 得点の配列を返す関数
    scores: function(logs, tenhouAccountName){
      let ary = []
      let escapedName = tenhouAccountName.replace(/[.*+?^=!:${}()|[\]\/\\]/g, '\\$&')
      let rg = new RegExp(escapedName + '\\((?<score>.+?)\\)')
      for(const log of logs){
        const m = log.match(rg)
        const number = parseInt(m.groups.score, 10)
        ary.push(number)
      }
      return ary
    },
    // 順位の配列を返す関数
    rankings: function(logs, tenhouAccountName){
      let ary = []
      for(const log of logs){
        let tenhouAccountNames = this.extractTenhouAccountsFrom(log)
        let ranking = tenhouAccountNames.indexOf(tenhouAccountName) + 1
        ary.push(ranking)
      }
      return ary
    },
    displayScore: function(games){
      let scores = this.scores(games, this.tenhouName)
      if(scores.length > 0){
        return scores.reduce((sum,currentValue) => sum + currentValue)
      }
    },
    averageRanking: function(games){
      let rankings = this.rankings(games, this.tenhouName)
      if(rankings.length > 0){
        let rankingTotal = rankings.reduce((sum,currentValue) => sum + currentValue)
        return (Math.round(rankingTotal / rankings.length * 100) / 100)
      }
    }
  },
  computed: {
    threeGames: function() {
      return JSON.parse(this.threeGamesString)
    },
    fourGames: function() {
      return JSON.parse(this.fourGamesString)
    },
    // ログが入った配列（他の情報はない）
    selectedThreeGames: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      let ary = []
      const threeGames = this.threeGames
      if(this.term.all === true){
        for(const threeGame of threeGames) {
          ary.push(threeGame.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for(const threeGame of threeGames) {
          let date = new Date(threeGame.date)
          if(date >= start && date <= end){
            ary.push(threeGame.one_game_log)
          }
        }
      }
      return ary
    },
    selectedFourGames: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      let ary = []
      const fourGames = this.fourGames
      if(this.term.all === true){
        for(const fourGame of fourGames) {
          ary.push(fourGame.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for(const fourGame of fourGames) {
          let date = new Date(fourGame.date)
          if(date >= start && date <= end){
            ary.push(fourGame.one_game_log)
          }
        }
      }
      return ary
    }
  }
}
</script>

