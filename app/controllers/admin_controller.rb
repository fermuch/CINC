class AdminController < ApplicationController
  def index
    @students = Student.all
    @states = {}
    # State.all.map { |s|
    #   [s.name, s.machines.count]
    # }.each { |s|
    #   @states[s.first] = s.last
    # }
    Student.all.each { |stu|
      state = stu.machine.states.last.name
      @states[state] = 0 if not @states[state]
      @states[state] += 1
    }

    # gon.watch.test = Time.now
  end

  def update_table
    @student = Student.find(params[:row_id])

    case params[:id]
    when 'name'
      @student.name = params[:value]
      @student.save!
    when 'cuil'
      @student.cuil = params[:value]
      @student.save!
    when 'sn'
      @machine = @student.machine
      @machine.sn = params[:value]
      @machine.save!
    when 'model'
      @machine = @student.machine
      @machine.model = params[:value]
      @machine.save!
    when 'state'
      @state = State.find_or_create_by_name(params[:value])
      @student.machine.states << @state
    when 'reason'
      @reason = @student.machine.machine_states.last
      @reason.reason = params[:value]
      @reason.save!
    end

    if request.xhr? then
      render :text => params[:value]
      sleep 1.5
    end
  end

  def add_student
    @student = Student.new
    @student.name = params[:student][:name]
    @student.cuil = params[:student][:cuil]
    @student.save!
    @student.machine = Machine.create(:sn => params[:student][:sn], :model => params[:student][:model])
    @machine = @student.machine
    @state = State.find_or_create_by_name(params[:student][:state])
    @machine.states << @state
    @reason = @machine.machine_states.last
    @reason.reason = params[:student][:reason]
    @reason.save!

    redirect_to admin_index_path
  end
end
