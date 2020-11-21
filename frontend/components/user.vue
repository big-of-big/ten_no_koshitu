<template>
  <tr>
    <td class="user-name" scope="row">
      <a :href="url"> {{ tenhouName }} </a>
    </td>
    <td class="text-right">{{ displayScore(selectedFourGames) }}</td>
    <td class="text-right">{{ averageRanking(selectedFourGames) }}</td>
    <td class="text-right">{{ selectedFourGames.length}}</td>
    <td class="text-right">{{ displayScore(selectedThreeGames) }}</td>
    <td class="text-right">{{ averageRanking(selectedThreeGames) }}</td>
    <td class="text-right">{{ selectedThreeGames.length}}</td>
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
    threeGamesString: { type: String },
    fourGamesString: { type: String },
    term: { type: Object },
    url: { type: String }
  },
  methods: {
    extractTenhouAccountsFrom: extractTenhouAccountsFrom,
    scores: scores,
    rankings: rankings,
    displayScore: displayScore,
    averageRanking: averageRanking
  },
  computed: {
    threeGames: function () {
      return JSON.parse(this.threeGamesString)
    },
    fourGames: function () {
      return JSON.parse(this.fourGamesString)
    },
    // ログが入った配列（他の情報はない）
    selectedThreeGames: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      const ary = []
      const threeGames = this.threeGames
      if (this.term.all === true) {
        for (const threeGame of threeGames) {
          ary.push(threeGame.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for (const threeGame of threeGames) {
          const date = new Date(threeGame.date)
          if (date >= start && date <= end) {
            ary.push(threeGame.one_game_log)
          }
        }
      }
      return ary
    },
    selectedFourGames: function () {
      // 開始か終了の期間が変更されるとこの処理が実行される
      const ary = []
      const fourGames = this.fourGames
      if (this.term.all === true) {
        for (const fourGame of fourGames) {
          ary.push(fourGame.one_game_log)
        }
      } else {
        const start = new Date(this.term.start)
        const end = new Date(this.term.end)
        for (const fourGame of fourGames) {
          const date = new Date(fourGame.date)
          if (date >= start && date <= end) {
            ary.push(fourGame.one_game_log)
          }
        }
      }
      return ary
    }
  }
}
</script>

<style scoped>
  .user-name {
    width: 9rem;
  }
</style>
