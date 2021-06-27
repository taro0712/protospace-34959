class PrototypesController < ApplicationController
  before_action :authenticate_user!,only: [:new, :edit, :destroy]
  before_action :move_to_index, only: [:edit, :update, :destroy]

  def index
    @prototype = Prototype.new
    @prototypes = Prototype.includes(:user)
  end

  def new
    @prototype = Prototype.new
  end

  def create
    @prototype = Prototype.new(prototype_params)
   #@prototype = Prototype.create(prototype_params)
    @prototypes = Prototype.includes(:user)
    if @prototype.save
      redirect_to prototypes_path(@prototype)
    else
      @prototypes = Prototype.includes(:user)
      render :new
    end
  end

  def show
    @comment = Comment.new
    @prototype = Prototype.find(params[:id])
    @comments = @prototype.comment
  end

  def edit
    @prototype = Prototype.find(params[:id])
  end

  def update
    prototype = Prototype.find(params[:id])
    #prototype.update(prototype_params)
    if prototype.update(prototype_params)
      redirect_to prototype_path(prototype.id), method: :get
    else
      return :edit
    end
  end

  def destroy
    prototype = Prototype.find(params[:id])
    prototype.destroy
    redirect_to root_path
  end


  private
  def prototype_params
    params.require(:prototype).permit(:title, :catch_copy, :concept, :image ).merge(user_id: current_user.id)
  end

  def move_to_index
    @prototype = Prototype.find(params[:id])
    redirect_to root_path unless current_user.id == @prototype.user.id
  end

end
