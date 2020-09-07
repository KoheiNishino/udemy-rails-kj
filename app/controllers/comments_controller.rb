class CommentsController < ApplicationController
  # コメント作成
  def create
    # StrongParametersで取得した値でCommentオブジェクト初期化して、ローカル変数に格納する
    comment = Comment.new(comment_params)
    # DBにコミットする
    if comment.save
      # コミット成功：flashでメッセージを返して作成したコメントに紐づく掲示板画面にリダイレクトする
      flash[:notice] = 'コメントを投稿しました'
      redirect_to comment.board
    else
      # コミット失敗：flashでcommnetオブジェクトとエラーメッセージを返して掲示板詳細画面にリダイレクトする
      redirect_back fallback_location: root_path, flash: {
        comment: comment,
        error_messages: comment.errors.full_messages
      }
    end
  end

  # コメント削除
  def destroy
    # idを指定してCommentモデルから削除するコメントを取得する
    comment = Comment.find(params[:id])
    # 取得したコメントを削除する（関連データは削除しないためdelete）
    comment.delete
    # flashでメッセージを返して削除したコメントに紐づく掲示板詳細画面にリダイレクトする
    redirect_to comment.board, flash: { notice: 'コメントが削除されました' }
  end

  # 許可するパラメータはprivateメソッドでカプセル化する
  private

  # StrongPrameters
  #  require：POSTで受け取る値のキーを設定
  #  permit：許可するカラム指定
  def comment_params
    params.require(:comment).permit(:board_id, :name, :comment)
  end
end
