class TweetsTag

  # Formオブジェクトは、1つのフォーム送信で複数のモデルを更新するときに使用するツールです。
  # 自分で定義したクラスをモデルのように扱うことができます。
  # このFormオブジェクトは、「ActiveModel::Model」というモジュールを読み込むことで使うことができます。

  # 「ActiveModel::Model」とは、Active Recordの場合と同様に「form_for」や「render」などのヘルパーメソッドを使えるようになるツールです。
  # また、「モデル名の調査」や「バリデーション」の機能も使えるようになります。

  include ActiveModel::Model
  attr_accessor :message, :name

  with_options presence: true do
    validates :message
    validates :name
  end

  def save
    tweet = Tweet.create(message: message)
    tag = Tag.where(name: name).first_or_initialize
    tag.save
    # first_or_initializeの記述だけでは、レコードを探すだけで終わってしまうため、saveメソッドで保存しましょう。

    TweetTagRelation.create(tweet_id: tweet.id, tag_id: tag.id)
  end

end