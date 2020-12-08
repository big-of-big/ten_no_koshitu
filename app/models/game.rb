class Game
  attr_accessor :name, :content
  def initialize(name, content)
    @name = name
    @content = content # 全てのログ（文字列）
  end
end
