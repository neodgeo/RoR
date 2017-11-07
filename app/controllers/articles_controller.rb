class ArticlesController < ApplicationController

  http_basic_authenticate_with name: "user", password: "password", only: [:index, :new, :update, :destroy]

  def new
    @article = Article.new
    render layout: "admin"
  end

  def index
    @articles = Article.all.paginate(page: params[:page], per_page: 2)
  end

  def blog
    @articles = Article.all.paginate(page: params[:page], per_page: 3)
  end

  def show
    @article = Article.find(params[:id])
    @comment = @article.comments.all
  end

  def edit
    @article = Article.find(params[:id])
  end

  def update
    @article = Article.find(params[:id])

    if @article.update(article_params)
      redirect_to @article,
        notice: 'Article enregristré'
    else
      render 'edit'
    end
  end

  def destroy
    @article = Article.find(params[:id])
    @article.destroy

    redirect_to articles_path
  end

  def create
    #render plain: params[:article].inspect

    #@article = Article.new(params.require(:article).permit(:title,:text))
    @article = Article.new(article_params)
    #@article.save
    #redirect_to @article

    if @article.save
      redirect_to @article,
        notice: 'Article enregristré'
    else
      render 'new', layout: "admin"
    end
  end

  private
    def article_params
      params.require(:article).permit(:title,:text)
    end
end
