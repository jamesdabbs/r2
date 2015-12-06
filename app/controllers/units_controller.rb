class UnitsController < ApplicationController
  def index
    @units = Unit.includes(:rooms)
  end

  def show
    @unit = Unit.find params[:id]
    authorize @unit
  end

  def update
    @unit = UnitForm.new Unit.find params[:id]
    authorize @unit
    if @unit.validate params.require(:unit)
      @unit.save
      redirect_to unit_path(@unit), flash: { success: "Unit updated" }
    else
      render :show
    end
  end
end
