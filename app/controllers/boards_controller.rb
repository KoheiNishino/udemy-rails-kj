class BoardsController < ApplicationController
  # onlyで絞り込んだアクションの直前にset_target_boardを実行する
  before_action :set_target_board, only: %i[show edit update destroy]

  # 掲示板一覧画面の表示
  def index
    # ※三項演算子で記述（条件式 ? もし値があった場合:もし値がなかった場合）
    #
    # params[:tag_id].present?：tag_idが取得できるかどうか。
    #   取得できた場合 → tag_idからタグを検索してタグに紐づく掲示板の一覧を取得する
    #   取得できなかった場合 → 掲示板の一覧を取得する
    #
    #   （@boardの中身が参照されてからDBに取得しにいくため、この時点ではDBにアクセスしていない）
    @boards = params[:tag_id].present? ? Tag.find(params[:tag_id]).boards : Board.all
    # page：引数に指定したページに表示するデータのみを取得する（デフォルトは25件）
    # @boardが参照されたため、DBに対して1ページあたりの掲示板の表示件数である10件に制限されたSQLが発行される
    @boards = @boards.page(params[:page])
  end

  # 掲示板新規作成画面の表示
  def new
    # Boardオブジェクトをインスタンス変数に格納する
    # コントローラー内で定義したインスタンス変数はビューで参照できる
    # 下記で掲示板作成に失敗した場合、flashで返されたBoardオブジェクトの内容をフォームに表示する
    @board = Board.new(flash[:board])
  end

  # 掲示板作成
  def create
    # StrongParametersで取得した値でBoardオブジェクト初期化して、ローカル変数に格納する
    board = Board.new(board_params)
    # DBにコミットする
    if board.save
      # コミット成功：flashでメッセージを返して掲示板画面にリダイレクトする
      flash[:notice] = "「#{board.title}」の掲示板を作成しました"
      redirect_to board
    else
      # コミット失敗：flashでBoardオブジェクトとエラーメッセージを返して掲示板新規作成画面にリダイレクトする
      redirect_to new_board_path, flash: {
        board: board,
        error_messages: board.errors.full_messages
      }
    end
  end

  # 掲示板詳細画面を表示
  def show
    # board_idを指定してCommentオブジェクトを作成し、インスタンス変数に格納する
    # @comment = @board.comments.newとすると空のコメントがcommentsに含まれてしまうためNG
    @comment = Comment.new(board_id: @board.id)
  end

  # 掲示板編集画面を表示
  def edit; end

  # 掲示板の内容を更新
  def update
    # StrongParametersで取得した値に更新してDBにコミットする
    if @board.update(board_params)
      # コミット成功：flashでメッセージを返して掲示板詳細画面にリダイレクトする
      flash[:notice] = "「#{@board.title}」の掲示板を修正しました"
      redirect_to @board # オブジェクトを指定することで/boards/:idのパスにリダイレクトされる
    else
      # コミット失敗：flashでBoardオブジェクトとエラーメッセージを返して掲示板編集画面にリダイレクトする
      redirect_back fallback_location: root_path, flash: {
        board: @board,
        error_messages: @board.errors.full_messages
      }
    end
  end

  # 掲示板を削除
  def destroy
    # オブジェクトをDBから削除する
    @board.destroy
    # flashでメッセージを返して掲示板一覧画面にリダイレクトする
    redirect_to boards_path, flash: { notice: "「#{@board.title}」の掲示板が削除されました" }
  end

  # 許可するパラメータはprivateメソッドでカプセル化する
  # createとupdateの両方で使いまわすことができる
  private

  # StrongPrameters
  #  require：POSTで受け取る値のキーを設定
  #  permit：許可するカラム指定
  def board_params
    params.require(:board).permit(:name, :title, :body, tag_ids: [])
  end

  # idを元にBoardモデルから該当のデータを1つ取得する
  def set_target_board
    @board = Board.find(params[:id])
  end
end
