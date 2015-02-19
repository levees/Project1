class CommentsController < ApplicationController
  before_filter :authenticate_user!, only: [:create, :delete]

  before_action :set_article
  before_action :set_comment, only: [:destroy]

  layout false
  #respond_to "json"

  def list
    @comments = @article.community_article_comments
                .joins("left outer join users on users.id = community_article_comments.user_id")
                .order("community_article_comments.created_at desc")
  end

  def create
    ip_addr = request.env['REMOTE_ADDR']
    param = {  
              user_id: current_user.id, 
              community_article_id: @article.id, 
              comment: params[:comment],
              ip_address: ip_addr,
              ip_number: Functions.ip_number(ip_addr)
            }
    @comment = @article.community_article_comments.new(param)

    if @comment.save
      render json: { result: true, message: "Success."}
    else
      render json: { result: false, message: @comment.errors }
    end
  end
  
  def destroy
    @article = current_user.articles.find(params[:article_id])
    @comment = @article.comments.find(params[:id])
    @comment.destroy
    respond_to do |format|
      format.html { redirect_to @article, :notice => t('comments.destroy_success') }
      format.js
    end
  end
  
  private
    def set_article
      @article = CommunityArticle.find(params[:id])
    end

    def set_comment
      @comment = CommunityArticleComment.find(param[:cid])
    end

    def params_comment
      params.require(:community_article_comment).permit(:comment)
    end 
end