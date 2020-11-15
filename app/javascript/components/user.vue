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
import {
  extractTenhouAccountsFrom,
  scores,
  rankings,
  displayScore,
  averageRanking
} from '../packs/calc'

export default {
  props: {
    tenhouName: { type: String },
    threeGamesString: {type: String},
    fourGamesString: {type: String},
    term: {type: Object},
    url: {type: String}
  },
  methods: {
    extractTenhouAccountsFrom: extractTenhouAccountsFrom,
    scores: scores,
    rankings: rankings,
    displayScore: displayScore,
    averageRanking: averageRanking
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

