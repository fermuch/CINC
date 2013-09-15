class AdminController < ApplicationController
  def index
    # save all the stundents in an array
    # TODO: eager-loading
    @students = Student.first(10)

    # gon.watch.test = Time.now
  end

  def students
    # make the json for datatables
    if params['iDisplayStart'] and params['iDisplayLength'] then
      @students = Student.paginate(:page => params['iDisplayStart'], :per_page => params['iDisplayLength'])
    else
      @students = Student.all
    end

    if params['sSearch'] then
      @students.where('name LIKE ?', params['sSearch'])
    end

    if params['iSortingCols'] then
      @students.order('? DESC', params['iSortingCols'])
    end

    @json = {}
    @json['aaData'] = []
    @students.each { |stu|
      # alumno, cuil, s/n, modelo, estado, razón
      @json['aaData'] << [stu.name, stu.cuil, stu.machine.sn, stu.machine.model,
                            stu.machine.states.last.name, stu.machine.machine_states.last.reason]
    }
    render :json => @json
  end

  def states_stats
    @students = Student.all
    @states   = {}
    @students.each { |stu|
      state = stu.machine.states.last.name
      @states[state] = 0 if not @states[state]
      @states[state] += 1
    }
    render :json => @states
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
    if request.post?
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
end
