class Api::ArticlesController < ApplicationController
  before_action :authorize, only: [:create, :show, :update, :destroy]

  def index
    @articles = Article.all
    render json: @articles
  end

  def create
    @article = @user.articles.create(article_params)
    @article.slug = generate_slug(@article.title)
    if @article.valid?
      render json: {
        article: {
          slug: @article.slug,
          title: @article.title,
          description: @article.description,
          body: @article.body,
          createdAt: @article.created_at,
          updatedAt: @article.updated_at,
          author: {
            username: @article.user.username,
            bio: @article.user.bio,
            image: @article.user.image,
          }
        }
      }, status: :created
    else
      render json: {error: "Invalid article"}, status: :unprocessable_entity
    end
  end

  def show
    @article = @user.articles.find_by(slug: params[:slug])
    if @article
      render json: {
        article: {
          slug: @article.slug,
          title: @article.title,
          description: @article.description,
          body: @article.body,
          createdAt: @article.created_at,
          updatedAt: @article.updated_at,
          author: {
            username: @article.user.username,
            bio: @article.user.bio,
            image: @article.user.image,
          }
        }
      }
    else
      render json: {error: 'Article not found'}, status: :not_found
    end
  end
  
  def update
    @article = @user.articles.find_by(slug: params[:slug])
    if @article.update(article_params)
      render json: {
        article: {
          slug: @article.slug,
          title: @article.title,
          description: @article.description,
          body: @article.body,
          createdAt: @article.created_at,
          updatedAt: @article.updated_at,
          author: {
            username: @article.user.username,
            bio: @article.user.bio,
            image: @article.user.image,
          }
        }
      }
    else
      render json: {error: "Invalid article"}, status: :unprocessable_entity
    end
  end
  
  def destroy
    @article = @user.articles.find_by(slug: params[:slug])
    @article.destroy
  end

  private

  def article_params
    params.require(:article).permit(:title, :description, :body, :user_id)
  end
  
  def generate_slug(title)
    title.parameterize  
  end

end
