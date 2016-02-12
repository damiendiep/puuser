class PostAttachmentsController < ApplicationController
  before_action :set_post_attachment, only: [:show, :edit, :update, :destroy]

  # GET /post_attachments
  # GET /post_attachments.json
  def index
    @post_attachments = PostAttachment.all
  end

  # GET /post_attachments/1
  # GET /post_attachments/1.json
  def show
  end

  # GET /post_attachments/new
  def new
    @post_attachment = PostAttachment.new
  end

  # GET /post_attachments/1/edit
  def edit
  end

  # POST /post_attachments
  # POST /post_attachments.json
  def create
    @post_attachment = PostAttachment.new(post_attachment_params.merge(:post_id => @post.id))
   respond_to do |format|
     if @post.save
      unless params[:post_attachments].nil?
       params[:post_attachments]['picture'].each do |a|
          @post_attachment = @post.post_attachments.create!(:picture => a, :post_id => @post.id)
       end
     else format.html { redirect_to @post, notice: 'Post was successfully created.' }
        format.json { render :show, status: :ok, location: @post }
     end
        format.html { render :new }
        format.json { render json: @post.errors, status: :unprocessable_entity }
      end
    end
  end

  # PATCH/PUT /post_attachments/1
  # PATCH/PUT /post_attachments/1.json
def update
  respond_to do |format|
    if @post_attachment.update(post_attachment_params)
      format.html { redirect_to @post_attachment.post, notice: 'Post attachment was successfully updated.' }
    end 
  end
end

  # DELETE /post_attachments/1
  # DELETE /post_attachments/1.json
  def destroy
    @post_attachment.destroy
    respond_to do |format|
      format.html { redirect_to post_attachments_url, notice: 'Post attachment was successfully destroyed.' }
      format.json { head :no_content }
    end
  end

  private
    # Use callbacks to share common setup or constraints between actions.
    def set_post_attachment
      @post_attachment = PostAttachment.find(params[:id])
    end

    # Never trust parameters from the scary internet, only allow the white list through.
    def post_attachment_params
      params.require(:post_attachment).permit(:post_id, :picture)
    end
end
