class ArticlesController < ApplicationController
    def index
        @articles = Article.all
    end

    def show
        @article = Article.find(params[:id])
    end

    def new
        @article = Article.new
    end

    def edit
        @article = Article.find(params[:id])
    end

    def destroy
        @article = Article.find(params[:id])
        @article.destroy
        respond_to  do |delete|
            delete.html {redirect_to articles_url, notice: "The article was successfully deleted" }
        end
    end

    def create
        @create_item = Article.new(params.require(:article).permit(:title, :body))

        respond_to (@article) do |create|
            if @create_item.save
                create.html {redirect_to @create_item, notice: 'The article has been created correctly'}
                create.json { render :show, status: :created, location: @create_item }
            else
                create.html(render :new)
                create.json { render json: @create_item.errors, status: :unprocessable_entity }
            end
        end
    end

    def update
        @update_item =  Article.find(params[:id])

        respond_to (@article) do |update|
            if @update_item.update(params.require(:article).permit(:title, :body))
                update.html {redirect_to edit_article_path, notice: 'The article has been updated correctly'}
            else
                create.html(render :edit)
            end
        end
    end

end
