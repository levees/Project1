class CommunitiesController < ApplicationController
  before_filter :authenticate_user!, except: [:index, :list, :show]

  before_action :set_categories
  before_action :set_community
  before_action :set_article, only: [:show, :edit, :update, :destroy, :photo_new, :photo_upload, :photo_delete]

  def index
    @communities = Community.all
    respond_with(@communities)
  end

  # GET /:community/
  def list
    #@articles = @community.community_articles.order(created_at: :desc).paginate(page: params[:page], per_page: 10)
    if community_params != "gallery"
      per_page = 5
    else
      per_page = 12
    end

    @articles = @community.community_articles
                .joins("left outer join users on users.id = community_articles.id")
                .paginate(page: params[:page], per_page: per_page)
                .order("community_articles.created_at desc")
                .includes(:photos, :community_article_comments)

     
    if community_params == "gallery"
      render "gallery_list"
    end
  end

  # GET /:community/:id
  # GET /:community/:id.json
  def show
    if community_params == "gallery"
      @photos = @article.photos.map{|photo| photo.to_photo_upload }
      render "gallery_show"
    end
  end

  # GET /:community/new
  def new
    @article = CommunityArticle.new
    if community_params == "gallery"
      render "gallery_new"
    end
  end

  # GET /:community/:id/edit
  def edit
    if community_params == "gallery"
      render "gallery_edit"
    end
  end

  # POST /:community
  # POST /:community.json
  def create
    ip_addr = request.env['REMOTE_ADDR']

    @article = CommunityArticle.new(article_params)
    @article.user_id = current_user.id
    @article.community = @community
    @article.ip_address = ip_addr
    @article.ip_number = Functions.ip_number(ip_addr)

    respond_to do |format|
      if @article.save
        if community_params == "gallery"
          format.html { redirect_to photos_path(community_params, @article) }
        else
          format.html { redirect_to community_articles_path(community_params, page: params[:page]), notice: '작성한 글이 입력 되었습니다.' }
          format.json { render action: 'show', status: :created, location: @article }
        end 
      else
        format.html { render action: 'new' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /:community/:id
  # PATCH/PUT /:community/:id.json
  def update
    respond_to do |format|
      if @article.update(article_params)
        if community_params == "gallery"
          format.html { redirect_to photos_path(community_params, @article) }
        else
          format.html { redirect_to community_article_path(community_params, @article), notice: '수정 되었습니다.' }
          format.json { head :no_content }
        end 
      else
        format.html { render action: 'edit' }
        format.json { render json: @article.errors, status: :unprocessable_entity }
      end
    end

    #@community.update(community_params)
    #respond_with(@community)
  end

  # DELETE /:community/:id
  # DELETE /:community/:id.json
  def destroy
    @article.destroy
    respond_to do |format|
      format.html { redirect_to community_articles_path(page: params[:page]) }
      format.json { head :no_content }
    end
    #@community.destroy
    #respond_with(@community)
  end

  def photo_new
    if community_params != "gallery"
      redirect_to "/"
    else
      @photo = Photo.where(community_article_id: params[:id])


      #render action: "gallery_upload"
      respond_to do |format|
        format.html { render action: "gallery_upload" }
        format.json { render json: {files: @photo.map { |photo| photo.to_photo_upload }} }
      end
    end
  end

  def photo_upload
    params[:photo][:photo].each do |file|
      @photo = Photo.new(:photo => file)
      @photo.user_id = current_user.id
      @photo.community_article_id = @article.id
      @photo.save
      render json: {files: [@photo.to_photo_upload]}, status: :created
    end
    

    #p_attr = params[:photo]
    #p_attr[:photo] = params[:photo][:photo].first if params[:photo][:photo].class == Array

    #logger.info(params[:photo])

    #@photo = Photo.new(photo_params)
    #@photo.user_id = current_user.id
    #@photo.community_article_id = @article.id

#    respond_to do |format|
#      if @photo.save
#        format.html {
#          render :json => [@photo.to_photo_upload].to_json,
#          :content_type => 'text/html',
#          :layout => false
#        }
#        format.json { render json: {files: [@photo.to_photo_upload]}, status: :created, location: @photo }
#      else
#        format.html { redirect_to photos_path(community_params, params[:id]) }
#        format.json { render json: @photo.errors, status: :unprocessable_entity }
#      end
#    end
  end

  def photo_delete
    @photo = Photo.find(params[:cid])
    @photo.destroy

    respond_to do |format|
      format.html { redirect_to community_article_path(community_params, @article) }
      format.json { head :no_content }
    end
  end



  private
      # Set default infomation
    def set_categories
      begin 
        @community = Community.all
      rescue ActiveRecord::RecordNotFound
        @community = nil
        logger.error "Community list is not accessed."
      end
    end

    # Parameters
    def community_params
      params[:community]
    end

    def article_params
      params.require(:community_article).permit(:id, :title, :body)
    end

    def photo_params
      params.require(:photo).permit(:photo)
    end

    # Set default infomation
    def set_community
      @community = Community.find_by_community_path(community_params)
      case community_params # a_variable is the variable we want to compare
        when "notice"  
          @menu_title = "공지사항"
          @menu_icon = "bullhorn"
        when "information" 
          @menu_title = "산행안내"
          @menu_icon = "info-circle"
        when "review" 
          @menu_title = "산행후기"
          @menu_icon = "book"
        when "gallery" 
          @menu_title = "갤러리"
          @menu_icon = "photo"
        when "board" 
          @menu_title = "게시판"
          @menu_icon = "coffee"
        else
          @menu_title = ""
          @menu_icon = "leaf"
        end

      if @community.nil?
        redirect_to "/404.html"
      end
    end

    def set_article
      @article = CommunityArticle.find(params[:id])

      if @article.nil?
        redirect_to "/404.html"
      end
    end

end
