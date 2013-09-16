class ContentsController < ApplicationController
  before_action :set_content, only: [:edit, :update]

  # GET /contents/1
  # GET /contents/1.json
  def show
    begin
      @content = Content.where(["name = ?", params[:id]]).first!
      @content.last_accessed_at = Time.now
      @content.save # Error handling はそこまで重要ではないので省略. 後で必要になったら考える

      respond_to do |format|
        format.html
      end
    rescue
      # 404
    end
  end

  # GET /contents/new
  def new
    @content = Content.new
  end

  # POST /contents
  # POST /contents.json
  def create
    begin
      @content = Content.new(content_params)
    rescue
      # パラメータ足りない (ファイル指定されてない) 場合の処理
      respond_to do |format|
        format.html { redirect_to :root, :flash => {:error => "ファイルを指定して下さい"} }
      end
      return
    end

    @content.last_accessed_at = @content.body_updated_at

    (@content.name, @content.extension) = @content.body.path.split('/')[-1].split('.')

    respond_to do |format|
      if @content.save
        format.html { redirect_to "/item/#{@content.name}", id: @content.name }
        format.json { render action: 'show', status: :created, location: @content }
      else
        format.html { render action: 'new' }
        format.json { render json: @content.errors, status: :unprocessable_entity }
      end
    end
  end

  private
  # Use callbacks to share common setup or constraints between actions.
  def set_content
    @content = Content.find(params[:id])
  end

  # Never trust parameters from the scary internet, only allow the white list through.
  def content_params
    params.require(:content).permit(:name, :category, :mime, :last_accessed_at, :created_at, :updated_at, :body)
  end
end
