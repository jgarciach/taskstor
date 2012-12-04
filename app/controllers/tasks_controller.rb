class TasksController < ApplicationController
  before_filter :authenticate_user!, only: [ :new, :accept, :complete ]

  def accept
    @task = Task.find(params[:task_id])
    @task.update_attributes(status: "in_progress", runner_id: current_user.id)
    
    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: @task }
    end
  end

  def complete
    @task = Task.find(params[:task_id])
    @task.update_attributes(status: "completed")

    respond_to do |format|
      format.html { redirect_to :back }
      format.json { render json: @task }
    end
  end


  # GET /tasks
  # GET /tasks.json
  def index
    @tasks = Task.all
    @urgent_tasks = Task.urgent
    @not_urgent_tasks = Task.not_urgent

    respond_to do |format|
      format.html # index.html.erb
      format.json { render json: @tasks }
    end
  end

  # GET /tasks/1
  # GET /tasks/1.json
  def show
    @task = Task.find(params[:id])

    respond_to do |format|
      format.html # show.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/new
  # GET /tasks/new.json
  def new
    @task = Task.new

    respond_to do |format|
      format.html # new.html.erb
      format.json { render json: @task }
    end
  end

  # GET /tasks/1/edit
  def edit
    @task = Task.find(params[:id])
    if !owner?(@task) 
      respond_to do |format|
        format.html { redirect_to :back, notice: "You're not the owner" }
      end
    end
  end

  # POST /tasks
  # POST /tasks.json
  def create
    @task = Task.new(params[:task])
    @task.user_id = current_user.id
    @task.status = "unclaimed"

    respond_to do |format|
      if @task.save
        format.html { redirect_to @task, notice: 'Task was successfully created.' }
        format.json { render json: @task, status: :created, location: @task }
      else
        format.html { render action: "new" }
        format.json { render json: @task.errors, status: :unprocessable_entity }
      end
    end
  end

  # PUT /tasks/1
  # PUT /tasks/1.json
  def update
    @task = Task.find(params[:id])

    if owner?(@task)
      respond_to do |format|
        if @task.update_attributes(params[:task])
          format.html { redirect_to @task, notice: 'Task was successfully updated.' }
          format.json { head :no_content }
        else
          format.html { render action: "edit" }
          format.json { render json: @task.errors, status: :unprocessable_entity }
        end
      end
    else
      respond_to do |format|
        format.html { redirect_to :back, notice: "You're not the owner." }
      end
    end
  end

  # DELETE /tasks/1
  # DELETE /tasks/1.json
  def destroy
    @task = Task.find(params[:id])

    respond_to do |format|
      if owner?(@task)
        @task.destroy
        format.html { redirect_to tasks_url }
        format.json { head :no_content }
      else
        format.html { redirect_to :back, notice: "You're not the owner." }
        format.json { head :no_content } 
      end
    end
  end
  
  private
  def owner? task
    current_user.id == task.user_id
  end

end
