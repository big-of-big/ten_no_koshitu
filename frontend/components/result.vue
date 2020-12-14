<template>
  <div class="vue-term">
    <span>期間を選択</span>
    <input type="date" v-model="start">
    <span>〜</span>
    <input type="date" v-model="end">
    <div class="data">
      <div class="card text-center mb-3 user-score">
        <div class="card-header">
          4人打ち
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">合計得点</p>
                <p class="card-text card-result">{{ displayScore(selectedFourGames) }}</p>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">平均順位</p>
                <p class="card-text card-result">{{ averageRanking(selectedFourGames) }}</p>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">対戦数</p>
                <p class="card-text card-result">{{ selectedFourGames.length}}</p>
              </div>
            </div>
          </div>
        </div>
      </div>

      <div class="card text-center mb-3 user-score">
        <div class="card-header">
          3人打ち
        </div>
        <div class="card-body">
          <div class="row">
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">合計得点</p>
                <p class="card-text card-result">{{ displayScore(selectedThreeGames) }}</p>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">平均順位</p>
                <p class="card-text card-result">{{ averageRanking(selectedThreeGames) }}</p>
              </div>
            </div>
            <div class="col-sm-4">
              <div class="card">
                <p class="card-text card-label">対戦数</p>
                <p class="card-text card-result">{{ selectedThreeGames.length}}</p>
              </div>
            </div>
          </div>
        </div>
      </div>
    </div>
  </div>
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
  data: function () {
    return {
      start: '',
      end: ''
    }
  },
  props: {
    tenhouName: { type: String },
    threeGamesString: { type: String },
    fourGamesString: { type: String }
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
    selectedThreeGames: function () {
      // ログが入った配列（他の情報はない)を返す関数
      // 開始か終了の期間が変更されるとこの処理が実行される
      const start = new Date(this.start)
      const end = new Date(this.end)
      const threeGames = this.threeGames
      const ary = []
      for (const threeGame of threeGames) {
        const date = new Date(threeGame.date)
        if (date >= start && date <= end) {
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
      const ary = []
      for (const fourGame of fourGames) {
        const date = new Date(fourGame.date)
        if (date >= start && date <= end) {
          ary.push(fourGame.one_game_log)
        }
      }
      return ary
    }
  }
}
</script>
