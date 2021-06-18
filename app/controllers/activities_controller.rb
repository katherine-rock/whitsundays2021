class ActivitiesController < ApplicationController
  before_action :set_activity, only: %i[ show edit update destroy ]
  before_action :authenticate_user!

  def index
    @activities = Activity.all.order(:date)
  end

  def show
  end

  def edit
  end

  def new
    @activity = Activity.new
  end

  def create
    @activity = Activity.new(activity_params)

    respond_to do |format|
    if @activity.save
        format.html { redirect_to @activity, notice: "Activity was successfully created." }
        format.json { render :show, status: :created, location: @activity }
    else
        format.html { render :new, status: :unprocessable_entity }
        format.json { render json: @activity.errors, status: :unprocessable_entity }
    end
    end
  end

  def update
    respond_to do |format|
      if @activity.update(activity_params)
      format.html { redirect_to @activity, notice: "Activity listing has been successfully updated." }
      format.json { render :show, status: :ok, location: @activity }
      else
      format.html { render :edit, status: :unprocessable_entity }
      format.json { render json: @activity.errors, status: :unprocessable_entity }
      end
  end
  end

  def destroy
    @activity.destroy
    respond_to do |format|
        format.html { redirect_to activities_url, notice: "Activity listing has been successfully deleted." }
        format.json { head :no_content }
    end
  end

  private

  def set_activity
    @activity = Activity.find(params[:id])
  end

  def activity_params
    params.require(:activity).permit(:id, :title, :description, :date, :time, :user_id).merge(user_id: current_user.id)
  end

end
