export function extractTenhouAccountsFrom(log) {
  let ary = log.split(' ')
  ary = ary.slice(6)
  let names = []
  for(const nameAndScore of ary) {
    const m = nameAndScore.match(/(?<name>.+)\((?<score>[+-]?[\d\.]+)/)
    names.push(m.groups.name)
  }
  return names
}

// 得点の配列を返す関数
export function scores(logs, tenhouAccountName){
  let ary = []
  let escapedName = tenhouAccountName.replace(/[.*+?^=!:${}()|[\]\/\\]/g, '\\$&')
  let rg = new RegExp(escapedName + '\\((?<score>.+?)\\)')
  for(const log of logs){
    const m = log.match(rg)
    const number = parseInt(m.groups.score, 10)
    ary.push(number)
  }
  return ary
}

// 順位の配列を返す関数
export function rankings(logs, tenhouAccountName){
  let ary = []
  for(const log of logs){
    let tenhouAccountNames = this.extractTenhouAccountsFrom(log)
    let ranking = tenhouAccountNames.indexOf(tenhouAccountName) + 1
    ary.push(ranking)
  }
  return ary
}

export function displayScore(games){
  let scores = this.scores(games, this.tenhouName)
  if(scores.length > 0){
    return scores.reduce((sum,currentValue) => sum + currentValue)
  }
}

export function averageRanking(games){
  let rankings = this.rankings(games, this.tenhouName)
  if(rankings.length > 0){
    let rankingTotal = rankings.reduce((sum,currentValue) => sum + currentValue)
    return (Math.round(rankingTotal / rankings.length * 100) / 100)
  }
}
