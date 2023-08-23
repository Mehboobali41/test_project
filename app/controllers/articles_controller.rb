class ArticlesController < ApplicationController
    before_action :authenticate_user!, except: [:index, :show]   
     before_action :set_article, only: [:show, :edit, :update, :destroy]
    def index
        @articles =Article.all
        
    end

    def show
    end

    def new
        @article =Article.new
    end
    def create
        @article=Article.new(article_pramas)
        @article.user = User.first # <--- Add this line
       if @article.save
        redirect_to @article
       else
        @errors = @article.errors
        render turbo_stream: turbo_stream.replace('article_form', partial: 'form')
       end
    end

    def edit
    end

    def update
        if @article.update(article_pramas)
            redirect_to @article
            else
                @errors = @article.errors
                render turbo_stream: turbo_stream.replace('article_form', partial: 'form')
            end 
    end

    def destroy
        @article.destroy
    
        redirect_to article_path
        
    end
    private
    def set_article
        @article=Article.find(params[:id])
    end

    def article_pramas
        params.require(:article).permit(:title, :description)
    end

   
end
