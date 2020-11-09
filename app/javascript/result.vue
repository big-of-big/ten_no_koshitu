<template>
  <div>
    <span>期間を選択</span>
    <input type="date" v-model="start">
    <span>〜</span>
    <input type="date" v-model="end">
    <p>
      4人打ち
      得点:{{ displayScore(selectedFourGames) }}
      平均順位:{{ averageRanking(selectedFourGames) }}
      対戦数:{{ selectedFourGames.length}}
    </p>
    <p>
      3人打ち
      得点:{{ displayScore(selectedThreeGames) }}
      平均順位:{{ averageRanking(selectedThreeGames) }}
      対戦数:{{ selectedThreeGames.length}}
    </p>
  </div>
</template>

<script>
import {
  extractTenhouAccountsFrom,
  scores,
  rankings,
  displayScore,
  averageRanking
} from './packs/calc'

export default {
  data: function () {
    return {
      start: '',
      end: '',
    }
  },
  props: {
    tenhouName: { type: String },
    threeGamesString: {type: String},
    fourGamesString: {type: String}
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
    selectedThreeGames: function () {
      // ログが入った配列（他の情報はない)を返す関数
      // 開始か終了の期間が変更されるとこの処理が実行される
      const start = new Date(this.start)
      const end = new Date(this.end)
      const threeGames = this.threeGames
      let ary = []
      for(const threeGame of threeGames) {
        let date = new Date(threeGame.date)
        if(date >= start && date <= end){
          ary.push(threeGame.one_game_log)
        }
      }
      return ary
    },
    selectedFourGames: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      const start = new Date(this.start)
      const end = new Date(this.end)
      const fourGames = this.fourGames
      let ary = []
      for(const fourGame of fourGames) {
        let date = new Date(fourGame.date)
        if(date >= start && date <= end){
          ary.push(fourGame.one_game_log)
        }
      }
      return ary
    }
  }
}
</script>
