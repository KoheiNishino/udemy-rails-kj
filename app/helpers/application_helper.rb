# 全ページで使用されるヘルパーを定義
module ApplicationHelper
  # ナビゲーションバー 表示切替（name:リンクの表示名、path:リンク先のパス）
  def header_link_item(name, path)
    # classに'nav-item'を追加
    class_name = 'nav-item'
    # 表示中のページとリンク先のパスが同じであればリンクの表示をアクティブにする
    class_name << ' active' if current_page?(path)

    # 任意のhtmlタグを作成する（:liタグの作成、:上記で作成したclass名を指定）
    # ネストさせているので<li><a/></li>のようなかたちになる
    content_tag :li, class: class_name do
      link_to name, path, class: 'nav-link'
    end
  end
end
