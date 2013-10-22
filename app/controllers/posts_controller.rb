class PostsController < ApplicationController
    
    
    def new
        @post = Post.new
    end
    
    def index
        @post = Post.order('created_at DESC').all
        respond_to do |format|
            format.html # index.html.erb
            format.json { render :json => @post}
        end
    end
    
    def show
        @post = Post.find(params[:id])
        
        respond_to do |format|
            format.html # show.html.erb
            format.json { render :json => @post}
        end
    end
    
    def edit
        @post = Post.find(params[:id])
    end
    
    def create
        @post = Post.find(params[:post])
        @post.posted_by_uid=current_user.id
        @post.posted_by=current_user.first_name+" "+current_user.last_name
        @post.ups=0
        @post.down=0
        @post.save
        
        respond_to do |format|
            if @post.save
                format.html {redirect_to root_path}
                format.json {render :json => @post, :status => :created, :location => @post}
                else
                format.html {redirect_to root_path}
                format.json { render :json => @post.errors, :status => :unprocessable_entity }
            end
        end
    end
    
    def update
        @post = Post.find(params[:id])
        
        respond_to do |format|
            if @post.update_attributes(params[:post])
                format.html { redirect_to @post, :notice => 'Post was successfully updated.' }
                format.json { head :no_content }
                else
                format.html { render :action => "edit" }
                format.json { render :json => @post.errors, :status => :unprocessable_entity }
            end
        end
    end
    
    def destroy
        @post = post.find(params[:id])
        @post.destroy
        
        respond_to do |format|
            format.html { redirect_to post_url }
            format.json { head :no_content }
        end
    end
end
