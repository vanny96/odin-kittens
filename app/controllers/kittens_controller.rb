class KittensController < ApplicationController
  def index
    @kittens = Kitten.all
    respond_to do |format|
      format.html
      format.json {render :json => @kittens}
    end
  end

  def show
    @kitten = Kitten.find(params[:id])
    respond_to do |format|
      format.html
      format.json {render :json => @kitten}
    end
  end

  def new
    @kitten = Kitten.new
  end

  def create
    @kitten = Kitten.new params_for_kitten
    if @kitten.save
      flash[:success] = "Kitten added to the database"
      redirect_to @kitten
    else
      render :new
    end
  end

  def edit
    @kitten = Kitten.find(params[:id])
  end

  def update
    @kitten = Kitten.find(params[:id])
    if @kitten.update_attributes params_for_kitten
      flash[:success] = "Kitten updated!"
      redirect_to @kitten
    else
      render :edit
    end
  end

  def destroy
    @kitten = Kitten.find(params[:id])
    if @kitten.destroy
      redirect_to kittens_path
    end
  end

  private

  def params_for_kitten
    params.require(:kitten).permit(:name, :age, :softness, :cuteness)
  end
end
