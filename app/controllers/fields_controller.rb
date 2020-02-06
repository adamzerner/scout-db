class FieldsController < ApplicationController
  before_action :authorize_user, except: [:index, :show]
  helper_method :sort_column

  def index
    @fields = Field.sorted_fields(sort_column, sort_direction)
  end

  def show
    @field = Field.find(params[:id])
  end

  def new
    @field = Field.new
    @field.address = Address.new
  end

  def edit
    @field = Field.find(params[:id])
  end

  def create
    @field = Field.new(field_params)

    if @field.save
      redirect_to @field
    else
      render 'new'
    end
  end

  def update
    @field = Field.find(params[:id])

    if @field.update(field_params)
      redirect_to @field
    else
      render 'edit'
    end
  end

  def destroy
    @field = Field.find(params[:id])
    @field.destroy

    redirect_to fields_path
  end

  private
    def field_params
      params
        .require(:field)
        .permit(:name, address_attributes: [ :id, :line_one, :line_two, :city, :state, :zip ])
    end

    def sort_column
      %w[name location].include?(params[:sort]) ? params[:sort] : "location"
    end
end
