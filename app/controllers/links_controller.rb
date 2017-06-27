class LinksController < ApplicationController
  def index
    @links = Link.all
  end

  def new
    @link = Link.new
  end

  def create
    @link = Link.new(link_params)
    if @link.save
      flash[:notice] = "Link successfully created!"
      redirect_to links_path
    else
      render :new
    end
  end

  def show
    @link = Link.find(params[:id])
  end

  def edit
    @link = Link.find(params[:id])
  end

  def update
    @link = Link.find(params[:id])
      if link_params[:votes] == nil
        if @link.update(link_params)
          redirect_to link_path(@link)
        else
          render :edit
        end
      else
        new_votes = @link.vote_up(@link)
        @link.update({votes: new_votes})
        redirect_to link_path(@link)
      end
  end

  def destroy
    Link.find(params[:id]).destroy
    redirect_to links_path
  end

private
  def link_params
    params.require(:link).permit(:title, :url, :votes)
  end
end
